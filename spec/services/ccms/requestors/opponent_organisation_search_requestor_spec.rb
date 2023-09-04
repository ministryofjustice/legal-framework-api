require "rails_helper"

module CCMS
  module Requestors
    RSpec.describe OpponentOrganisationSearchRequestor do
      let(:expected_xml) { ccms_data_from_file "get_common_org_request.xml" }
      let(:expected_tx_id) { "20230904121530000000" }
      let(:organisation_name) { "Bucks Council" }
      let(:organisation_type) { "LA" }
      let(:requestor) { described_class.new("my_login", organisation_name, organisation_type) }

      describe "XML request" do
        context "with an organisation name and type" do
          it "generates the expected XML" do
            allow(requestor).to receive(:transaction_request_id).and_return(expected_tx_id)
            expect(requestor.formatted_xml).to be_soap_envelope_with(
              command: "refdatabim:CommonOrgInqRQ",
              transaction_id: expected_tx_id,
              matching: %w[
                <common:MaxRecordsToFetch>2000</common:MaxRecordsToFetch>
                <common:RetriveDataOnMaxCount>true</common:RetriveDataOnMaxCount>
                <refdatabim:OrganizationName>Bucks
                Council</refdatabim:OrganizationName>
                <refdatabim:OrganizationType>LA</refdatabim:OrganizationType>
              ],
            )
          end
        end

        context "when requesting all organisations" do
          let(:organisation_name) { nil }
          let(:organisation_type) { nil }

          it "generates the expected XML" do
            allow(requestor).to receive(:transaction_request_id).and_return(expected_tx_id)
            expect(requestor.formatted_xml).to be_soap_envelope_with(
              command: "refdatabim:CommonOrgInqRQ",
              transaction_id: expected_tx_id,
              matching: %w[
                <common:MaxRecordsToFetch>2000</common:MaxRecordsToFetch>
                <common:RetriveDataOnMaxCount>true</common:RetriveDataOnMaxCount>
                <refdatabim:OrganizationName/>
                <refdatabim:OrganizationType/>
              ],
            )
          end
        end
      end

      describe "#call" do
        let(:soap_client_double) { Savon.client(env_namespace: :soap, wsdl: requestor.__send__(:wsdl_location)) }
        let(:expected_soap_operation) { :process }
        let(:expected_xml) { requestor.__send__(:request_xml) }

        it "calls the savon soap client" do
          allow(requestor).to receive(:soap_client).and_return(soap_client_double)
          expect(soap_client_double).to receive(:call).with(expected_soap_operation, xml: expected_xml)
          requestor.call
        end
      end
    end
  end
end
