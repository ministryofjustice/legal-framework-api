require "rails_helper"

module CCMS
  RSpec.describe OpponentOrganisationSynchronisationService do
    subject(:opponent_organisation_synchronisation_service) { described_class.new }

    let(:requestor) { instance_double(CCMS::Requestors::OpponentOrganisationSearchRequestor) }
    let(:response_xml) { "spec/fixtures/data/ccms/get_common_org_reponse.xml" }
    let(:endpoint) { "https://ccmssoagateway.dev.legalservices.gov.uk/ccmssoa/soa-infra/services/default/GetCommonOrg/getcommonorg_ep" }

    before do
      stub_request(:post, endpoint).to_return(body: File.read(response_xml), status: 200)
    end

    describe "#call" do
      it "calls the opponent organisation search requestor service" do
        allow(CCMS::Requestors::OpponentOrganisationSearchRequestor).to receive(:new).and_return(requestor)
        expect(requestor).to receive(:call)
        opponent_organisation_synchronisation_service.call
      end

      context "with new organisation(s)" do
        let(:org_type) { OrganisationType.find_by(ccms_code: "LA") }

        it "creates organisations that do not already exist" do
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
    end
  end
end
