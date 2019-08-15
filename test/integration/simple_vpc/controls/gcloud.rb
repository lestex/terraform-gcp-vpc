project_id   = attribute('project_id')
network_name = attribute('network_name')

control "gcloud" do
  title "gcloud configuration"

  describe command("gcloud compute networks subnets describe #{network_name}-subnet-01 --project=#{project_id} --region=us-west1 --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "enableFlowLogs" do
      it "should be false" do
        expect(data).to include(
          "enableFlowLogs" => false
        )
      end
    end
  end

  describe command("gcloud compute networks subnets describe #{network_name}-subnet-02 --project=#{project_id} --region=us-west1 --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "enableFlowLogs" do
      it "should be true" do
        expect(data).to include(
          "enableFlowLogs" => true
        )
      end
    end
  end
end
