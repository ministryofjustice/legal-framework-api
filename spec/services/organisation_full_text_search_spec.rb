require "rails_helper"
require_relative "full_text_search_query_transformer_examples"

RSpec.describe OrganisationFullTextSearch do
  it_behaves_like "full text search query transformer"

  describe ".call" do
    subject(:results) { described_class.call(search_term) }

    context "when searching for a non-existent organisation" do
      let(:search_term) { "foobar" }

      it "returns an empty array" do
        expect(results).to eq []
      end
    end

    context "when searching for organisation searchable type" do
      let(:search_term) { "local authority" }

      it "returns all expected results" do
        expect(results.size).to eq 425
      end
    end

    context "when searching for a term that only exists on one record" do
      let(:search_term) { "babergh" }

      it "returns one result row" do
        expect(results.size).to eq 1
      end

      it "returns an instance of Result" do
        expect(results).to all(be_an_instance_of(OrganisationFullTextSearch::Result))
      end

      it "returns expected result" do
        result = results.first
        expect(result.name).to eq "Babergh District Council"
        expect(result.searchable_type).to eq "Local Authority"
        expect(result.ccms_code).to eq "280370"
      end
    end

    context "when searching for a term which occurs in more than one organisation" do
      let(:search_term) { "council" }

      it "returns expected results" do
        expect(results.size).to eq 421
      end
    end

    context "with multiple partial matching term searches" do
      let(:search_term) { "pub lim comp" }

      it "returns results matching either term" do
        expect(results.map(&:name)).to contain_exactly("G4S",
                                                       "Imperial College London",
                                                       "University North Durham")
      end
    end

    context "with multiple exact matching term searches" do
      let(:search_term) { "public limited company" }

      it "returns results matching either term" do
        expect(results.map(&:name)).to contain_exactly("G4S",
                                                       "Imperial College London",
                                                       "University North Durham")
      end
    end
  end
end
