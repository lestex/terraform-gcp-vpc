project_id   = attribute('project_id')
network_name = attribute('network_name')

control 'gcloud' do
  title 'gcloud configuration'

  describe command("gcloud compute firewall-rules describe #{network_name}-ingress-internal --project=#{project_id} --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status.zero?
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe 'internal rule' do
      it 'should exist' do
        expect(data).to include(
          'sourceRanges' => ['10.10.20.0/24', '10.10.10.0/24']
        )
      end
    end
  end
end
