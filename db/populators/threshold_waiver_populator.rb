class ThresholdWaiverPopulator
  DATA_FILE = Rails.root.join("db/seed_data/threshold_waivers.json").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    record = find_or_create_threshold_waiver(seed_row)
    record.update!(
      gross_income_upper: seed_row[:gross_income_upper],
      disposable_income_upper: seed_row[:disposable_income_upper],
      capital_upper: seed_row[:capital_upper],
    )
  end

  def find_or_create_threshold_waiver(seed_row)
    matter_type = MatterType.find_by(name: seed_row[:matter_type])
    client_involvement_type = ClientInvolvementTypeService.call(nil).find_by(ccms_code: seed_row[:client_involvement_type])
    ThresholdWaiver.find_or_create_by!(matter_type:, client_involvement_type:)
  end

  def seed_data
    @seed_data ||= JSON.load_file(DATA_FILE, symbolize_names: true)[:seed_data]
  end
end
