require "rails_helper"

module CCMS
  RSpec.describe OpponentOrganisationSynchronisationService do
    subject(:opponent_organisation_synchronisation_service) { described_class.new }

    let(:success_response_xml) { "spec/fixtures/data/ccms/get_common_org_reponse.xml" }
    let(:failure_response_xml) { "spec/fixtures/data/ccms/get_common_org_reponse_failure.xml" }
    let(:no_records_response_xml) { "spec/fixtures/data/ccms/get_common_org_reponse_no_records.xml" }
    let(:endpoint) { "https://ccmssoagateway.dev.legalservices.gov.uk/ccmssoa/soa-infra/services/default/GetCommonOrg/getcommonorg_ep" }

    describe "#call" do
      before { stub_request(:post, endpoint).to_return(body: File.read(response_xml), status: 200) }

      context "with new organisation(s)" do
        let(:response_xml) { success_response_xml }
        let(:org_type) { OrganisationType.find_by(ccms_code: "LA") }

        it "creates new organisations but does not create duplicates" do
          Organisation.create!(
            ccms_code: "123456",
            name: "Existing LA",
            searchable_type: org_type.description,
            organisation_type_id: org_type.id,
          )
          expect { opponent_organisation_synchronisation_service.call }.to change(Organisation, :count).by(1)
          expect(Organisation.where(name: "New Council").pluck(:ccms_code)).to eq %w[123457]
          expect(Organisation.where(name: "Existing Council").pluck(:ccms_code)).to eq []
          expect(Organisation.where(name: "Existing LA").pluck(:ccms_code)).to eq %w[123456]
        end
      end

      context "when ccms returns an error" do
        let(:response_xml) { failure_response_xml }

        it "raises an error" do
          expect { opponent_organisation_synchronisation_service.call }.to raise_error CCMS::GetCommonOrgError, "CCMSGetCommonOrg call failed"
        end
      end

      context "when ccms returns no records" do
        let(:response_xml) { no_records_response_xml }

        it "raises an error" do
          expect { opponent_organisation_synchronisation_service.call }.to raise_error CCMS::GetCommonOrgError, "CCMSGetCommonOrg returned no records"
        end
      end
    end
  end
end
