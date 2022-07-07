class ClientInvolvementTypesPopulator
  DATA_FILE = Rails.root.join("db/seed_data/client_involvement_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    ccms_code, description = seed_row
    record = ClientInvolvementType.find_by(ccms_code:) || ClientInvolvementType.new
    record.update!(
      ccms_code:,
      description:,
    )
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
