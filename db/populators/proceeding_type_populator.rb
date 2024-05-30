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
    seed_hash["matter_type_id"] = MatterType.find_by(code: seed_hash["matter_type_code"]).id
    seed_hash.delete("matter_type_code")
    record = ProceedingType.find_by(ccms_code: seed_hash["ccms_code"]) || ProceedingType.new
    record.update!(seed_hash)
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
