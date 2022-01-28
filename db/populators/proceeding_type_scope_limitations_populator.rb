class ProceedingTypeScopeLimitationsPopulator
  # The yaml file does not include headers therefore items are selected based on their position in the array
  # [0] - proceeding_type_code
  # [1] - scope_limitation_code
  # [2] - substantive_default
  # [3] - delegated_functions_default

  DATA_FILE = Rails.root.join('db/seed_data/proceeding_type_scope_limitations.yml').freeze

  def self.call
    new.call
  end

  def call
    seed_data.each { |seed_row| populate(seed_row) }
  end

private

  def populate(seed_row)
    record = ProceedingTypeScopeLimitation.where(proceeding_type_id: proceeding_type_id(seed_row),
                                                 scope_limitation_id: scope_limitation_id(seed_row)).first_or_initialize
    record.update! attributes(seed_row)
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end

  def attributes(seed_row)
    {
      proceeding_type_id: proceeding_type_id(seed_row),
      scope_limitation_id: scope_limitation_id(seed_row),
      substantive_default: seed_row[2],
      delegated_functions_default: seed_row[3],
    }
  end

  def proceeding_type_id(seed_row)
    proceeding_types.find { |proceeding_type| proceeding_type.ccms_code == seed_row[0] }.id
  end

  def scope_limitation_id(seed_row)
    scope_limitations.find { |scope_limitation| scope_limitation.code == seed_row[1] }.id
  end

  def proceeding_types
    @proceeding_types ||= ProceedingType.select(:id, :ccms_code).all
  end

  def scope_limitations
    @scope_limitations ||= ScopeLimitation.select(:id, :code).all
  end
end
