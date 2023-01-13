class DefaultCostLimitationPopulator
  DATA_FILE = Rails.root.join("db/seed_data/default_cost_limitations.yml").freeze

  def self.call
    new.call
  end

  def call
    DefaultCostLimitation.destroy_all
    populate_default_cost_limitations
  end

private

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end

  def populate_default_cost_limitations
    pts = ProceedingType.all
    pts.each { |pt| add_cost_limitations(pt) }
  end

  def add_cost_limitations(proceeding_type)
    proc_type_ccms_code = proceeding_type.ccms_code
    dcl_values = build_dcl_hash_for(proc_type_ccms_code)

    %w[substantive delegated_functions].each { |cost_type| create_records_for(proceeding_type, dcl_values, cost_type) }
  end

  def create_records_for(proceeding_type, dcl_values, cost_type)
    dcl_values[cost_type].each do |start_date, value|
      DefaultCostLimitation.create!(proceeding_type:, cost_type:, start_date:, value:)
    end
  end

  def build_dcl_hash_for(proc_type_ccms_code)
    source = default_dcl
    specific_hash = seed_data[proc_type_ccms_code]
    return source if specific_hash.nil?

    source.merge(specific_hash)
  end

  def default_dcl
    @default_dcl ||= seed_data["default"]
  end
end
