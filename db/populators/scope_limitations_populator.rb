class ScopeLimitationsPopulator
  DATA_FILE = Rails.root.join("db/seed_data/scope_limitations.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |attrs| populate(attrs) }
  end

private

  def populate(attrs)
    record = ScopeLimitation.find_by(code: attrs["code"]) || ScopeLimitation.new
    record.update!(attrs)
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)["scope_limitations"]
  end
end
