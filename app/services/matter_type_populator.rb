class MatterTypePopulator
  DATA_FILE = Rails.root.join("db/seed_data/matter_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }.freeze
  end

private

  def populate(seed_row)
    name, matter_code, category_of_law, category_of_law_code, gross_income, disposable_income, capital = seed_row
    matter_type(name).update!(
      name:,
      code: matter_code,
      category_of_law:,
      category_of_law_code:,
      upper_gross_income_waiver: gross_income,
      upper_disposable_income_waiver: disposable_income,
      upper_capital_waiver: capital,
    )
  end

  def matter_type(name)
    MatterType.find_by(name:) || MatterType.new
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end
end
