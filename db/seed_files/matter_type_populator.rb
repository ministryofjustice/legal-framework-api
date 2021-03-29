class MatterTypePopulator
  SEED_DATA = [
    ['Domestic abuse', true, true, true],
    ['Children - section 8', false, false, false]
  ]

  def self.call
    new.call
  end

  def call
    SEED_DATA.each { |seed_row| populate(seed_row) }
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
end

