require "rails_helper"

RSpec.describe ProceedingTypeFullTextSearch do
  context "whole service" do
    before { seed_live_data }

    let(:excluded_codes) { [] }

    describe ".call" do
      subject { described_class.call(search_term) }

      context "searching for a non-existent term" do
        let(:search_term) { "animals" }

        it "returns an empty array" do
          expect(subject).to eq []
        end
      end

      context "search for category of law" do
        let(:search_term) { "Family" }

        it "returns everything" do
          result_set = subject
          expect(result_set.count).to eq ProceedingType.count
        end
      end

      context "searching for a term that only exists on one record" do
        let(:search_term) { "mutilation" }

        it "returns one result row" do
          result_set = subject
          expect(result_set.size).to eq 1
        end

        it "returns an instance of Result" do
          result = subject.first
          expect(result).to be_an_instance_of(ProceedingTypeFullTextSearch::Result)
        end

        it "returns FGM Protection order" do
          result = subject.first
          expect(result.meaning).to eq "FGM Protection Order"
          expect(result.description).to eq "To be represented on an application for a Female Genital Mutilation Protection Order under the Female Genital Mutilation Act."
        end
      end

      context "search term only exists in additional_search_terms" do
        let(:search_term) { "cao" }

        it "returns two records" do
          result_set = subject
          expect(result_set.map(&:ccms_code).sort).to eq %w[SE013 SE014]
        end
      end

      context "searching for a term which occurs in more than one proceeding" do
        let(:search_term) { "injunction" }

        it "returns three results" do
          result_set = subject
          expect(result_set.size).to eq 3
        end

        it "returns the ones in which the search term appears first; and additional terms matches are last" do
          result_set = subject
          expect(result_set.map(&:meaning)).to match_array ["Harassment - injunction", "Inherent jurisdiction high court injunction", "Non-molestation order"]
          expect(result_set.map(&:meaning)[2]).to eq "Non-molestation order"
        end

        context "when you send one of the codes as an excluded_term" do
          subject { described_class.call(search_term, excluded_codes) }

          let(:excluded_codes) { "DA001" }

          it "returns two results" do
            result_set = subject
            expect(result_set.size).to eq 2
          end

          it "returns the one with the search term in meaning first and excludes the second result" do
            result_set = subject
            expect(result_set.map(&:meaning)).to eq ["Harassment - injunction", "Non-molestation order"]
          end
        end
      end

      context "multiple term searches" do
        let(:search_term) { "protection order" }

        it "returns results matching either term" do
          result_set = subject
          expect(result_set.map(&:meaning)).to match_array(["FGM Protection Order",
                                                            "Forced marriage protection order",
                                                            "Variation or discharge under section 5 protection from harassment act 1997"])
        end
      end
    end
  end

  describe "transformation of search terms" do
    subject { service.instance_variable_get(:@ts_query) }

    let(:dummy_url) { nil }
    let(:service) { described_class.new(search_terms) }

    context "one single search term" do
      let(:search_terms) { "term1" }

      it "returns term followed by :*" do
        expect(subject).to eq "term1:*"
      end
    end

    context "terms separated by a single space" do
      let(:search_terms) { "term1 term2" }

      it "returns :* after each item separated by &" do
        expect(subject).to eq "term1:* & term2:*"
      end
    end

    context "terms separated by a tab" do
      let(:search_terms) { "term1\tterm2" }

      it "returns :* after each item separated by &" do
        expect(subject).to eq "term1:* & term2:*"
      end
    end

    context "terms separated by multiple spaces" do
      let(:search_terms) { "term1   term2" }

      it "returns :* after each item separated by &" do
        expect(subject).to eq "term1:* & term2:*"
      end
    end

    context "terms separated by mixture of multiple spaces and tabs" do
      let(:search_terms) { "term1\t\tterm2  term3\t term4  \tterm5" }

      it "returns :* after each item separated by &" do
        expect(subject).to eq "term1:* & term2:* & term3:* & term4:* & term5:*"
      end
    end
  end
end
