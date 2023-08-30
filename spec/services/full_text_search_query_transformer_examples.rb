RSpec.shared_examples "full text search query transformer" do
  describe "@ts_query" do
    subject(:ts_query) { service.instance_variable_get(:@ts_query) }

    let(:service) { described_class.new(search_terms) }

    context "with one single search term" do
      let(:search_terms) { "term1" }

      it "returns term followed by :*" do
        expect(ts_query).to eq "term1:*"
      end
    end

    context "with terms separated by a single space" do
      let(:search_terms) { "term1 term2" }

      it "returns :* after each item separated by &" do
        expect(ts_query).to eq "term1:* & term2:*"
      end
    end

    context "with terms separated by a tab" do
      let(:search_terms) { "term1\tterm2" }

      it "returns :* after each item separated by &" do
        expect(ts_query).to eq "term1:* & term2:*"
      end
    end

    context "with terms separated by multiple spaces" do
      let(:search_terms) { "term1   term2" }

      it "returns :* after each item separated by &" do
        expect(ts_query).to eq "term1:* & term2:*"
      end
    end

    context "with terms separated by mixture of multiple spaces and tabs" do
      let(:search_terms) { "term1\t\tterm2  term3\t term4  \tterm5" }

      it "returns :* after each item separated by &" do
        expect(ts_query).to eq "term1:* & term2:* & term3:* & term4:* & term5:*"
      end
    end
  end
end
