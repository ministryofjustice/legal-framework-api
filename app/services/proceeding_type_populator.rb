class ProceedingTypePopulator
  DATA_FILE = Rails.root.join("db/seed_data/proceeding_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_hash| populate(seed_hash) }
  end

private

  def populate(seed_hash)
    seed_hash["matter_type_id"] = __send__(seed_hash["matter_type_method"])
    seed_hash.delete("matter_type_method")
    record = ProceedingType.find_by(ccms_code: seed_hash["ccms_code"]) || ProceedingType.new
    record.update!(seed_hash)
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
