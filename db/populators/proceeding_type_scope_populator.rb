class ProceedingTypeScopePopulator
  DATA_FILE = Rails.root.join("db/seed_data/proceeding_type_scopes.yml").freeze
  DELEGATED_FUNCTION_STATES = [true, false].freeze
  CLIENT_INVOLVEMENT_TYPES = %w[A D I W Z].freeze
  NON_A_CLIENT_INVOLVEMENT_TYPES = %w[D I W Z].freeze

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
    @seed_data.each do |_category_name, config|
      populate_category(config)
    end
  end

  def populate_category(config)
    proceeding_type_codes = config[:proceeding_types]
    config[:service_levels].each { |level_hash| populate_service_level(level_hash, proceeding_type_codes) }
  end

  def populate_service_level(level_hash, proceeding_type_codes)
    level = level_hash[:level]
    scopes = level_hash[:scopes]
    proceeding_type_codes.each do |ptc|
      scopes.each do |scope|
        populate_scope(ptc, level, scope)
      end
      update_defaults(level, ptc, level_hash[:defaults])
    end
  end

  def populate_scope(ptc, level, scope)
    DELEGATED_FUNCTION_STATES.each do |df_state|
      CLIENT_INVOLVEMENT_TYPES.each do |cit|
        populate_record(ptc, level, df_state, cit, scope)
      end
    end
  end

  def populate_record(ptc, level, df_state, cit, scope)
    return if scope_not_available_for_this_df_state?(scope, df_state)

    ProceedingTypeScope.create!(
      proceeding_type_ccms_code: ptc,
      service_level: level,
      client_involvement_type_code: cit,
      df_used: df_state,
      scope_limitation_code: scope,
      default: false,
    )
  end

  def update_defaults(level, ptc, defaults_config)
    subst_a_scope = defaults_config[:substantive][:cit_a]
    update_default(false, ptc, level, "A", subst_a_scope)

    subst_non_a_scope = defaults_config[:substantive][:cit_not_a]
    NON_A_CLIENT_INVOLVEMENT_TYPES.each do |cit|
      update_default(false, ptc, level, cit, subst_non_a_scope)
    end

    df_a_scope = defaults_config[:delegated_functions][:cit_a]
    update_default(true, ptc, level, "A", df_a_scope)

    df_non_a_scope = defaults_config[:delegated_functions][:cit_not_a]
    NON_A_CLIENT_INVOLVEMENT_TYPES.each do |cit|
      update_default(true, ptc, level, cit, df_non_a_scope)
    end
  end

  def update_default(df_state, ptc, level, cit, scope)
    return if scope_not_available_for_this_df_state?(scope, df_state)

    join_rec = ProceedingTypeScope.find_by!(proceeding_type_ccms_code: ptc,
                                            service_level: level,
                                            client_involvement_type_code: cit,
                                            df_used: df_state,
                                            scope_limitation_code: scope)
    join_rec.update!(default: true)
  end

  def scope_not_available_for_this_df_state?(scope_code, df_state)
    sl_rec = ScopeLimitation.find_by(code: scope_code)
    return true if !df_state && !sl_rec.substantive?

    return true if df_state && !sl_rec.delegated_functions?

    false
  end
end
