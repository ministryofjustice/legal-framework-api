require "rails_helper"

RSpec.describe TaskDependencyPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    context "when no task dependencies exist" do
      before do
        TaskDependency.delete_all
      end

      it "seeds all task dependencies tasks" do
        expect { call }.to change(TaskDependency, :count).from(0).to(1)
      end
    end

    context "when task dependencies already exist" do
      it "does not add or remove task dependencies" do
        expect { call }.not_to change(TaskDependency, :count)
      end
    end
  end
end
