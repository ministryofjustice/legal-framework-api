class ScopeLimitationsPopulator
  DATA_FILE = Rails.root.join('db/seed_data/scope_limitations.yml').freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

  private

  def populate(seed_row)
    code, meaning, description, substantive, delegated_functions = seed_row
    record = ScopeLimitation.find_by(code:) || ScopeLimitation.new
    record.update!(
      code:,
      meaning:,
      description:,
      substantive:,
      delegated_functions:
    )
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
