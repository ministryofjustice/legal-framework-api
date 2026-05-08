class ExpertTypeMatterTypesPopulator
  DATA_FILE = Rails.root.join("db/seed_data/expert_type_matter_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |row| populate(row) }
  end

private

  def populate(row)
    row["expert_type_codes"].each do |expert_type_code|
      ExpertTypeMatterType.where(
        matter_type_id: matter_type_id(row["matter_type_code"]),
        expert_type_id: expert_type_id(expert_type_code),
      ).first_or_create!
    end
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end

  def matter_type_id(code)
    matter_types.find { |mt| mt.code == code }.id
  end

  def expert_type_id(code)
    expert_types.find { |et| et.code == code }.id
  end

  def matter_types
    @matter_types ||= MatterType.select(:id, :code).all
  end

  def expert_types
    @expert_types ||= ExpertType.select(:id, :code).all
  end
end
