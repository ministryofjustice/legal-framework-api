class MatterTypePopulator
  DATA_FILE = Rails.root.join('db/seed_data/matter_types.yml').freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }.freeze
  end

  private

  def populate(seed_row)
    name, gross_income, disposable_income, capital = seed_row
    record = MatterType.find_by(name: name) || MatterType.new
    record.update!(
      name: name,
      upper_gross_income_waiver: gross_income,
      upper_disposable_income_waiver: disposable_income,
      upper_capital_waiver: capital
    )
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
