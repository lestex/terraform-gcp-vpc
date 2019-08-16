project_id   = attribute('project_id')
network_name = attribute('network_name')

control 'gcp' do
  title 'Google Cloud configuration'

  describe google_compute_firewalls(project: project_id) do
    its('firewall_names') { should include "#{network_name}-ingress-internal" }
    its('firewall_names') { should include "#{network_name}-ingress-tag-http" }
    its('firewall_names') { should include "#{network_name}-ingress-tag-https" }
    its('firewall_names') { should include "#{network_name}-ingress-tag-ssh" }
    its('firewall_names') { should_not include 'default-ingress-admins' }
  end
end
