class ServiceLevelsPopulator
  DATA_FILE = Rails.root.join("db/seed_data/service_levels.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    level, name, stage = seed_row
    record = ServiceLevel.find_by(level:) || ServiceLevel.new
    record.update!(
      level:,
      name:,
      stage:,
    )
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
