class ProceedingTypeScopePopulator
  DATA_FILE = Rails.root.join("db/seed_data/proceeding_type_scopes.yml").freeze
  DELEGATED_FUNCTION_STATES = [true, false].freeze
  CLIENT_INVOLVEMENT_TYPES = %w[A D I W Z].freeze

  def self.call
    new.call
  end

  def initialize
    @seed_data = YAML.load_file(DATA_FILE)
  end

  def call
    ProceedingTypeScope.transaction do
      ProceedingTypeScope.delete_all
      populate!
    end
  end

  private

  def populate!
    @seed_data["proceeding_types"].each do |proceeding_type|
      populate_proceeding_type(proceeding_type)
    end
  end

  def populate_proceeding_type(proceeding_type_hash)
    pt_ccms_code = proceeding_type_hash["proceeding_type_code"]
    proceeding_type_hash['service_levels'].each do |service_level_hash|
      populate_service_level(pt_ccms_code, service_level_hash)
    end
  end

  def populate_service_level(pt_ccms_code, service_level_hash)
    level_num = service_level_hash['level_num']
    scopes = service_level_hash["scopes"]
    scopes.each do |scope|
      populate_scope(scope, level_num, pt_ccms_code)
    end
    update_defaults(pt_ccms_code, level_num, proceeding_type_hash["defaults"])

  end

  def populate_scope(scope, level_num, pt_ccms_code)
    DELEGATED_FUNCTION_STATES.each do |df_state|
      populate_df_state(df_state, scope, level_num, pt_ccms_code)
    end
  end

  def populate_df_state(df_state, scope, level_num, pt_ccms_code)
    CLIENT_INVOLVEMENT_TYPES.each do |cit|
      populate_record(cit, df_state, scope, level_num, pt_ccms_code)
    end
  end

  def populate_record(cit, df_state, scope, level_num, pt_ccms_code)
    ProceedingTypeScope.create!(
      proceeding_type_ccms_code: pt_ccms_code,
      service_level: level_num,
      client_involvement_type_code: cit,
      df_used: df_state,
      scope_limitation_code: scope,
      default: false
    )
  end

  def update_defaults(pt_ccms_code, level_num,  defaults)
    update_defaults_for_df_state(true, pt_ccms_code, level_num, defaults["df_used"])
    update_defaults_for_df_state(false, pt_ccms_code, level_num, defaults["substantive"])
  end

  def update_defaults_for_df_state(df_state, pt_ccms_code, level_num, specific_defaults)
    scope_code = specific_defaults['cit_a']
    cit_code = 'A'
    update_default(df_state, pt_ccms_code, level_num, cit_code, cit_a_scope_code)
    cit_diwz_scope_code =  specific_defaults['cit_diwz']
    %w[D I W Z].each do |cit_code|
      update_default(df_state, pt_ccms_code, level_num, cit_code, cit_diwz_scope_code)
    end
  end

  def update_default(df_state, pt_ccms_code, level_num, cit_code, scope)
    pt_scope = ProceedingTypeScope.find_by!(
      proceeding_type_ccms_code: pt_ccms_code,
      service_level: level_num,
      client_involvement_type_code: cit_code,
      df_used: df_state,
      scope_limitation_code: scope)
    pt_scope.update!(default: true)
  end
end
