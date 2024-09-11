class MatterTypePopulator
  DATA_FILE = Rails.root.join("db/seed_data/matter_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed| populate(seed) }.freeze
  end

private

  def populate(seed_hash)
    matter_type(seed_hash["code"]).update!(
      name: seed_hash["name"],
      code: seed_hash["code"],
      category_of_law: seed_hash["category_of_law"],
      category_of_law_code: seed_hash["category_of_law_code"],
    )
  end

  def matter_type(code)
    MatterType.find_by(code:) || MatterType.new
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
