require "rails_helper"

describe "fixes", type: :task do
  describe ":remove_proceeding_type" do
    subject(:run) do
      Rake::Task["fixes:remove_proceeding_type"].execute(arguments)
    end

    let(:arguments) { Rake::TaskArguments.new(%i[ccms_code], [ccms_code]) }

    before do
      Rails.application.load_tasks if Rake::Task.tasks.empty?

      # spy on output and prevent output in test suite
      allow($stdout).to receive(:puts)
      allow($stdout).to receive(:write)

      # say yes to any prompted output
      allow($stdin).to receive(:gets).and_return "yes"
    end

    context "with a non-existent proceeding type ccms code" do
      let(:ccms_code) { "SE099E" }

      it "does not delete any proceedings" do
        expect { run }.not_to change(ProceedingType, :count)
      end

      it "outputs not found message" do
        run
        expect($stdout).to have_received(:puts).with("ProceedingType SE099E not found!")
      end
    end

    context "with existing proceeding type matching the ccms code" do
      let(:ccms_code) { "SE099E" }

      before do
        create(:proceeding_type,
               ccms_code: "SE099E",
               meaning: "Amd enforcement-breach-S8",
               description: "whatever description",
               matter_type: MatterType.find_by(code: "KSEC8"))
      end

      it "deletes the proceeding" do
        expect { run }.to change(ProceedingType, :count).by(-1)
      end

      it "outputs success message" do
        run
        expect($stdout).to have_received(:puts).with("Deleted proceeding_type SE099E with meaning \"Amd enforcement-breach-S8\"")
      end
    end

    context "when cancelled" do
      before { allow($stdin).to receive(:gets).and_return "foobar" }

      let(:ccms_code) { "SE100E" }

      it "does not delete any proceedings" do
        expect { run }.not_to change(ProceedingType, :count)
      end

      it "outputs cancel message" do
        run
        expect($stdout).to have_received(:puts).with("Cancelled!")
      end
    end
  end
end
