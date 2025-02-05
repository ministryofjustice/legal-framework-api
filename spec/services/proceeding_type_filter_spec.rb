require "rails_helper"

RSpec.describe ProceedingTypeFilter do
  subject(:proceeding_type_filter) { described_class.call(current_proceedings, allowed_categories, search_term) }

  let(:current_proceedings) { [] }
  let(:allowed_categories) { [] }
  let(:search_term) { "" }

  context "when created with blank parameters" do
    it "returns all proceedings excluding sca_related" do
      expect(proceeding_type_filter.count).to eq 142
    end
  end

  context "when created with current_proceedings parameter" do
    context "and it has a non-SCA proceeding" do
      let(:current_proceedings) { %w[DA001] }

      it "returns all proceedings excluding the current one, all PLF and all sca_related proceedings" do
        expect(proceeding_type_filter.count).to eq 39
        expect(proceeding_type_filter.pluck("ccms_matter_code").uniq).not_to include "KPBLB"
        expect(proceeding_type_filter.pluck("sca_related").uniq).not_to include true
      end
    end

    context "and it has an SCA proceeding" do
      let(:current_proceedings) { %w[PB003] }

      it "returns only sca_core and sca_related proceedings minus the current one" do
        expect(proceeding_type_filter.count).to eq 20
      end
    end

    context "and it has a means tested PLF proceeding" do
      let(:current_proceedings) { %w[PBM04] }

      it "returns only PLF proceedings minus the current one and the non_means_tested ones" do
        expect(proceeding_type_filter.pluck("ccms_matter_code").uniq).to eq %w[KPBLB]
        expect(proceeding_type_filter.pluck("non_means_tested_plf").uniq).to eq [false]
        expect(proceeding_type_filter.count).to eq 90
      end
    end

    context "and it has a non means tested PLF proceeding" do
      let(:current_proceedings) { %w[PBM40] }

      it "returns only the other non means tested PLF proceedings" do
        expect(proceeding_type_filter.pluck("ccms_matter_code").uniq).to eq %w[KPBLB]
        expect(proceeding_type_filter.pluck("ccms_code").uniq).to match_array %w[PBM45 PBM40E PBM45E]
        expect(proceeding_type_filter.pluck("non_means_tested_plf").uniq).to eq [true]
        expect(proceeding_type_filter.count).to eq 3
      end
    end
  end

  context "when created with allowed_categories parameter" do
    context "and it currently exists and has proceedings" do
      let(:allowed_categories) { %w[MAT] }

      it "returns all proceedings excluding sca_related" do
        expect(proceeding_type_filter.count).to eq 142
      end
    end

    context "and it is not currently supported by the service" do
      let(:allowed_categories) { %w[MED] }

      it "returns no proceedings" do
        expect(proceeding_type_filter.count).to eq 0
      end
    end
  end
end
