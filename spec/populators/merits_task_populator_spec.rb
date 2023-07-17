require "rails_helper"

RSpec.describe MeritsTaskPopulator do
  let(:application_merits_tasks) do
    %w[
      latest_incident_details
      opponent_name
      opponent_mental_capacity
      domestic_abuse_summary
      children_application
      statement_of_case
      client_denial_of_allegation
      client_offer_of_undertakings
      nature_of_urgency
      why_matter_opposed
      laspo
    ]
  end

  let(:proceeding_type_merits_tasks) do
    %w[
      chances_of_success
      children_proceeding
      attempts_to_settle
      specific_issue
      prohibited_steps
      opponents_application
      vary_order
    ]
  end

  let(:merits_tasks) do
    (application_merits_tasks + proceeding_type_merits_tasks).flatten
  end

  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    context "when no merits tasks exist" do
      before do
        MeritsTask.all.map(&:destroy!)
      end

      it "seeds all merits tasks" do
        expect { call }.to change(MeritsTask, :count).from(0).to(18)
        expect(MeritsTask.pluck(:name)).to match_array(merits_tasks)
      end
    end

    context "when merits tasks already exist" do
      it "does not change merits tasks" do
        expect { call }.not_to change(MeritsTask, :count)
      end
    end

    context "when a merits tasks has been added" do
      before do
        stub_const("MeritsTaskPopulator::APPLICATION_MERITS_TASKS", application_merits_tasks << "my_new_task")
      end

      it "adds the merits tasks to the relevant subclass" do
        expect { call }.to change(ApplicationTask, :count).from(11).to(12)
        expect(ApplicationTask.pluck(:name)).to include("my_new_task")
      end
    end

    context "when merits tasks have been removed" do
      before do
        stub_const("MeritsTaskPopulator::APPLICATION_MERITS_TASKS", %w[latest_incident_details])
        stub_const("MeritsTaskPopulator::PROCEEDING_TYPE_MERITS_TASKS", %w[chances_of_success])
      end

      it "removes the merits tasks that are no longer seeded" do
        expect { call }.to change(MeritsTask, :count).from(18).to(2)
      end
    end
  end
end
