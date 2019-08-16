project_id   = attribute('project_id')
network_name = attribute('network_name')

control 'gcp' do
  title 'VPC auto-subnets check'

  describe google_compute_network(project: project_id, name: network_name) do
    it { should exist }
    its('auto_create_subnetworks') { should be true }
  end
end
