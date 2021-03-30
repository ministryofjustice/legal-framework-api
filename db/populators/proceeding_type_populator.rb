class ProceedingTypePopulator
  DATA_FILE = Rails.root.join('db/seed_data/proceeding_types.yml').freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

  private

  def populate(seed_row)
    ccms_code, meaning, description, matter_type_id_method = seed_row
    matter_type_id = __send__(matter_type_id_method)
    record = ProceedingType.find_by(ccms_code: ccms_code) || ProceedingType.new
    record.update!(
      ccms_code: ccms_code,
      meaning: meaning,
      description: description,
      matter_type_id: matter_type_id
    )
  end

  def domestic_abuse_id
    @domestic_abuse_id ||= MatterType.domestic_abuse.id
  end

  def section8_id
    @section8_id ||= MatterType.section8.id
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
