project_id   = attribute('project_id')
network_name = attribute('network_name')

control 'gcloud' do
  title 'gcloud configuration'

  describe command("gcloud compute networks subnets describe #{network_name}-subnet-01 --project=#{project_id} --region=us-west1 --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status.zero?
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    it "should have the correct secondaryIpRanges configuration for #{network_name}-subnet-01-01" do
      expect(data['secondaryIpRanges'][0]).to include(
        'rangeName' => "#{network_name}-subnet-01-secondary-range-01",
        'ipCidrRange' => '192.168.64.0/24'
      )
    end

    it "should have the correct secondaryIpRanges configuration for #{network_name}-subnet-01-02" do
      expect(data['secondaryIpRanges'][1]).to include(
        'rangeName' => "#{network_name}-subnet-01-secondary-range-02", #
        'ipCidrRange' => '192.168.65.0/24'
      )
    end
  end

  describe command("gcloud compute networks subnets describe #{network_name}-subnet-03 --project=#{project_id} --region=us-west1 --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status.zero?
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    it "should have the correct secondaryIpRanges configuration for #{network_name}-subnet-03-01" do
      expect(data['secondaryIpRanges'][0]).to include(
        'rangeName' => "#{network_name}-subnet-03-secondary-range-01",
        'ipCidrRange' => '192.168.66.0/24'
      )
    end
  end
end
