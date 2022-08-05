class ProceedingTypePopulator
  DATA_FILE = Rails.root.join("db/seed_data/proceeding_types.yml").freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_hash| populate(seed_hash) }
    populate_default_cost_limitations
  end

private

  def populate(seed_hash)
    seed_hash["matter_type_id"] = __send__(seed_hash["matter_type_method"])
    seed_hash.delete("matter_type_method")
    record = ProceedingType.find_by(ccms_code: seed_hash["ccms_code"]) || ProceedingType.new
    record.update!(seed_hash)
  end

  def domestic_abuse_id
    @domestic_abuse_id ||= MatterType.domestic_abuse.id
  end

  def section8_id
    @section8_id ||= MatterType.section8.id
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end

  def populate_default_cost_limitations
    pts = ProceedingType.all
    pts.each { |pt| add_cost_limitations(pt) }
  end

  def add_cost_limitations(proceeding_type)
    find_or_create_dcl(proceeding_type:, cost_type: "substantive", start_date: Date.parse("1970-01-01"), value: 25_000.0)
    find_or_create_dcl(proceeding_type:, cost_type: "delegated_functions", start_date: Date.parse("1970-01-01"), value: 1_350.0)
    find_or_create_dcl(proceeding_type:, cost_type: "delegated_functions", start_date: Date.parse("2021-09-13"), value: 2_250.0)
  end

  def find_or_create_dcl(proceeding_type:, cost_type:, start_date:, value:)
    dcl = DefaultCostLimitation.find_by(proceeding_type:, cost_type:, start_date:, value:)
    return if dcl.present?

    DefaultCostLimitation.create!(proceeding_type:, cost_type:, start_date:, value:)
  end
end
