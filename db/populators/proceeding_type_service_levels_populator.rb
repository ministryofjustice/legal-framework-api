class ProceedingTypeServiceLevelsPopulator
  # The yaml file does not include headers therefore items are selected based on their position in the array
  # [0] - service_level_level
  # [1] - provider_type_ccms_code
  # [2] - proceeding_default

  DATA_FILE = Rails.root.join("db/seed_data/proceeding_type_service_levels.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data_keys.each { |seed_hash| populate(seed_hash) }
  end

private

  def populate(seed_data)
    seed_data["proceeding_type_ids"].each do |proceeding_id|
      record = ProceedingTypeServiceLevel.where(service_level_id: service_level_id(seed_data),
                                                proceeding_type_id: proceeding_type_id(proceeding_id)).first_or_initialize
      record.update!(
        proceeding_type_id: proceeding_type_id(proceeding_id),
        service_level_id: service_level_id(seed_data),
        proceeding_default: seed_data["default"],
      )
    end
  end

  def seed_data_keys
    @seed_data_keys ||= YAML.load_file(DATA_FILE)
  end

  def service_level_id(seed_row)
    service_levels.find { |service_level| service_level.level == seed_row["service_level_id"] }.id
  end

  def proceeding_type_id(proceeding_code)
    proceeding_types.find { |proceeding_type| proceeding_type.ccms_code == proceeding_code }.id
  end

  def proceeding_types
    @proceeding_types ||= ProceedingType.select(:id, :ccms_code).all
  end

  def service_levels
    @service_levels ||= ServiceLevel.select(:id, :level).all
  end
end
