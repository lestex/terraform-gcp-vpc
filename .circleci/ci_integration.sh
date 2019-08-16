#! /bin/bash
# Always clean up.
DELETE_AT_EXIT="$(mktemp -d)"

finish() {
  echo 'BEGIN: finish() trap handler' >&2
  set +e
  bundle exec kitchen destroy
  [[ -d "${DELETE_AT_EXIT}" ]] && rm -rf "${DELETE_AT_EXIT}"
  echo 'END: finish() trap handler' >&2
}

setup_environment() {
  local tmpfile
  tmpfile="$(mktemp)"

  echo "$GOOGLE_APPLICATION_CREDENTIALS" > "${tmpfile}"

  # Terraform and most other tools respect GOOGLE_CREDENTIALS
  export GOOGLE_CREDENTIALS="$GOOGLE_APPLICATION_CREDENTIALS"          

  # gcloud variables
  export CLOUDSDK_CORE_PROJECT="${PROJECT_ID}"
  export GOOGLE_APPLICATION_CREDENTIALS="${tmpfile}"

  # Terraform input variables
  export TF_VAR_project_id="${PROJECT_ID}"
  TF_VAR_random_string_for_testing="${RANDOM_STRING_FOR_TESTING:-$(LC_ALL=C tr -dc 'a-z0-9' < /dev/urandom | fold -w 5 | head -n 1)}"
  export TF_VAR_random_string_for_testing

  # Setup auth for service account
  gcloud auth activate-service-account --key-file="${tmpfile}"
}

main() {
  set -eu
  # Setup trap handler to auto-cleanup
  export TMPDIR="${DELETE_AT_EXIT}"
  trap finish EXIT

  # Setup environment
  setup_environment

  set -x
  # Execute the test lifecycle
  bundle exec kitchen create
  bundle exec kitchen converge
  bundle exec kitchen verify
}

# if script is being executed and not sourced.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
