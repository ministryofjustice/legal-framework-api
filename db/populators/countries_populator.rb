class CountriesPopulator
  DATA_FILE = Rails.root.join("db/seed_data/ccms_countries.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    record = Country.find_by(code: seed_row[:code]) || Country.new

    record.update!(
      code: seed_row[:code],
      description: seed_row[:description],
    )
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
