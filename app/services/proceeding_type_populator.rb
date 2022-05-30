class ProceedingTypePopulator
  DATA_FILE = Rails.root.join("db/seed_data/proceeding_types.json").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    record = ProceedingType.find_by(ccms_code: seed_row[:ccms_code]) || ProceedingType.new
    record.update!(
      ccms_code: seed_row[:ccms_code],
      meaning: seed_row[:meaning],
      name: seed_row[:name],
      description: seed_row[:description],
      additional_search_terms: seed_row[:additional_search_terms],
      matter_type_id: __send__(seed_row[:method]),
    )
    if seed_row[:default_cost_limitations]
      add_cost_limitations_from(seed_row[:default_cost_limitations], record)
    else
      add_default_cost_limitations(record)
    end
  end

  def domestic_abuse_id
    @domestic_abuse_id ||= MatterType.domestic_abuse.id
  end

  def section8_id
    @section8_id ||= MatterType.section8.id
  end

  def seed_data
    @seed_data ||= JSON.load_file(DATA_FILE, symbolize_names: true)[:seed_data]
  end

  def add_default_cost_limitations(proceeding_type)
    find_or_create_dcl(proceeding_type:, cost_type: "substantive", start_date: Date.parse("1970-01-01"), value: 25_000.0)
    find_or_create_dcl(proceeding_type:, cost_type: "delegated_functions", start_date: Date.parse("1970-01-01"), value: 1_350.0)
    find_or_create_dcl(proceeding_type:, cost_type: "delegated_functions", start_date: Date.parse("2021-09-13"), value: 2_250.0)
  end

  def add_cost_limitations_from(seed_data, proceeding_type)
    seed_data.each do |dcl|
      find_or_create_dcl(proceeding_type:, cost_type: dcl[:type], start_date: Date.parse(dcl[:start_date]), value: dcl[:threshold])
    end
  end

  def find_or_create_dcl(proceeding_type:, cost_type:, start_date:, value:)
    DefaultCostLimitation.upsert({ proceeding_type_id: proceeding_type.id, cost_type:, start_date:, value: },
                                 unique_by: %i[proceeding_type_id cost_type start_date])
  end
end
