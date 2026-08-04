class ExpertTypesPopulator
  DATA_FILE = Rails.root.join("db/seed_data/expert_types.yml").freeze

  def self.call
    new.call
  end

  def call
    remove_obsolete_records
    seed_data.each { |row| populate(row) }
  end

private

  def populate(row)
    record = ExpertType.find_or_initialize_by(code: row["code"])
    record.update!(description: row["description"])
  end

  def remove_obsolete_records
    valid_codes = seed_data.pluck("code")
    ExpertType.where.not(code: valid_codes).destroy_all
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
