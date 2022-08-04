require "rails_helper"

RSpec.describe ScopeUserInput, type: :model do
  describe "validations" do
    let(:user_input) { build :scope_user_input, input_name: "my input", input_type:, mandatory: true }

    describe "input_type" do
      context "with valid value of date" do
        let(:input_type) { "date" }

        it "is valid" do
          expect(user_input).to be_valid
        end
      end

      context "with valid value of text" do
        let(:input_type) { "text" }

        it "is valid" do
          expect(user_input).to be_valid
        end
      end

      context "with invalid input type" do
        let(:input_type) { "boolean" }

        it "is not valid" do
          expect(user_input).not_to be_valid
          expect(user_input.errors[:input_type]).to eq ["boolean is not a valid input_type"]
        end
      end
    end
  end
end
