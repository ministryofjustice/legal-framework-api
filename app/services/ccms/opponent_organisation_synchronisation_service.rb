module CCMS
  class OpponentOrganisationSynchronisationService
    OrganisationStruct = Struct.new(:name, :type, :ccms_code)

    def call
      organisation_collection.each { |organisation| populate(organisation) unless Organisation.find_by(ccms_code: organisation[:ccms_code]) }
    rescue StandardError
      false
    end

  private

    def populate(organisation)
      org_type = OrganisationType.find_by(ccms_code: organisation[:type])

      Organisation.create!(
        ccms_code: organisation[:ccms_code],
        name: organisation[:name],
        searchable_type: org_type.description,
        organisation_type_id: org_type.id,
      )
    end

    def organisation_collection
      @organisation_collection ||=
        organisation_list
          .pluck(:organization_name, :organization_type, :organization_party_id)
          .sort_by { |el| el[0] }
          .each_with_object([]) do |el, memo|
          memo << OrganisationStruct.new(el[0], el[1], el[2])
        end
    end

    def organisation_list
      @organisation_list ||= CCMS::Requestors::OpponentOrganisationSearchRequestor
        .new(Rails.configuration.x.ccms_soa.provider_username)
        .call
        .body[:common_org_inq_rs][:organization_list]
    end
  end
end
