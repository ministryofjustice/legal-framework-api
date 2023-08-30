class OrganisationsPopulator
  DATA_FILE = Rails.root.join("db/seed_data/organisations.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    record = Organisation.find_by(ccms_code: seed_row[:ccms_code]) || Organisation.new
    org_type = OrganisationType.find_by(ccms_code: seed_row[:organisation_type])

    record.update!(
      ccms_code: seed_row[:ccms_code],
      name: seed_row[:name],
      searchable_type: org_type.description,
      organisation_type_id: org_type.id,
    )
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
