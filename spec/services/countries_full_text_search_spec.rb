require "rails_helper"
require_relative "full_text_search_query_transformer_examples"

RSpec.describe CountriesFullTextSearch do
  it_behaves_like "full text search query transformer"

  describe ".call" do
    subject(:results) { described_class.call(search_term) }

    context "when searching for a non-existent country" do
      let(:search_term) { "foobar" }

      it "returns an empty array" do
        expect(results).to eq []
      end
    end

    context "when searching for an existing country" do
      let(:search_term) { "ja" }

      it "returns all expected results" do
        expect(results.size).to eq 4
      end
    end

    context "when searching for a term that only exists on one record" do
      let(:search_term) { "China" }

      it "returns one result row" do
        expect(results.size).to eq 1
      end

      it "returns an instance of Result" do
        expect(results).to all(be_an_instance_of(CountriesFullTextSearch::Result))
      end

      it "returns expected result" do
        expect(results.first).to have_attributes(description: "China",
                                                 code: "CHN")
      end
    end

    context "when searching for a term which occurs in more than one country" do
      let(:search_term) { "ant" }

      it "returns expected results" do
        expect(results.size).to eq 3
      end
    end

    context "with multiple partial matching term searches" do
      let(:search_term) { "sai an" }

      it "returns results matching either term" do
        expect(results.map(&:description)).to contain_exactly("Saint Kitts and Nevis",
                                                              "Saint Pierre and Miquelon",
                                                              "Saint Vincent and the Grenadines")
      end
    end

    context "with multiple exact matching term searches" do
      let(:search_term) { "saint and" }

      it "returns results matching either term" do
        expect(results.map(&:description)).to contain_exactly("Saint Kitts and Nevis",
                                                              "Saint Pierre and Miquelon",
                                                              "Saint Vincent and the Grenadines")
      end
    end
  end
end
