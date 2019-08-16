project_id   = attribute('project_id')
network_name = attribute('network_name')

control 'gcp' do
  title 'Google Cloud configuration'

  describe google_compute_network(
    project: project_id,
    name: network_name
  ) do
    it { should exist }
    its('routing_config.routing_mode') { should eq 'REGIONAL' }
  end

  describe google_compute_subnetwork(
    project: project_id,
    name: "#{network_name}-subnet-01",
    region: 'us-west1'
  ) do
    it { should exist }
    its('ip_cidr_range') { should eq '10.10.10.0/24' }
    its('private_ip_google_access') { should be false }
  end

  describe google_compute_subnetwork(
    project: project_id,
    name: "#{network_name}-subnet-02",
    region: 'us-west1'
  ) do
    it { should exist }
    its('ip_cidr_range') { should eq '10.10.20.0/24' }
    its('private_ip_google_access') { should be true }
  end
end
