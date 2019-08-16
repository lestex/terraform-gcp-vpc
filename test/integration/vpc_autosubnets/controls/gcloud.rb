project_id   = attribute('project_id')
network_name = attribute('network_name')

control 'gcloud' do
  title 'VPC auto-subnets check number of networks created'

  describe command("gcloud compute networks describe #{network_name} --project=#{project_id} --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status.zero?
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe 'number of subnets' do
      it 'should be grater than 20' do
        expect(data['subnetworks'].length).to be >= 20
      end
    end
  end
end
