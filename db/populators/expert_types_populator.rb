class ExpertTypesPopulator
  DATA_FILE = Rails.root.join("db/seed_data/expert_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |row| populate(row) }
  end

private

  def populate(row)
    record = ExpertType.find_or_initialize_by(code: row["code"])
    record.update!(description: row["description"])
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
