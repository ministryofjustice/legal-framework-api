class EligibleScopesService
  # use class instance variable so that config is loaded once only and is available to all instances of the class
  @config ||= YAML.load_file(Rails.root.join("config/eligible_scopes.yml"))

  def initialize(proceeding_type, client_involvement_type, service_level, df_used)
    @proceeding_type = proceeding_type
    @service_level = service_level
    @df_used = df_used
    @client_involvement_type = client_involvement_type
  end

  class << self
    attr_reader :config
  end

  def self.eligible_scopes(proceeding_type, client_involvement_type, service_level, df_used)
    new(proceeding_type, client_involvement_type, service_level, df_used).eligible_scopes
  end

  def self.default_scope(proceeding_type, client_involvement_type, service_level, df_used)
    new(proceeding_type, client_involvement_type, service_level, df_used).default_scope
  end

  def self.default_service_level(proceeding_type)
    new(proceeding_type, nil, nil, nil).default_service_level
  end

  def eligible_scopes
    innermost_config[:scopes]
  end

  def default_scope
    innermost_config[:defaults][cit_key]
  end

  def default_service_level
    scheme_config[:default_service_level]
  end

private

  def scheme_config
    raise "No such proceeding type '#{@proceeding_type}'" unless EligibleScopesService.config[:proceeding_types].key?(@proceeding_type)

    scheme_name = EligibleScopesService.config[:proceeding_types][@proceeding_type]
    raise "No such scheme '#{scheme_name}'" unless EligibleScopesService.config[:schemes].key?(scheme_name)

    EligibleScopesService.config[:schemes][scheme_name]
  end

  def service_level_config
    raise "No such service level '#{@service_level}'" unless scheme_config.key?(service_level_key)

    scheme_config[service_level_key]
  end

  def innermost_config
    raise "Invalid Client Involvement Type '#{@client_involvement_type}" unless ClientInvolvementType::VALID_CLIENT_INVOLVEMENT_TYPES.include?(@client_involvement_type)

    service_level_config[df_state_key]
  end

  def service_level_key
    @service_level_key ||= :"service_level_#{@service_level}"
  end

  def df_state_key
    @df_state_key ||= @df_used ? :delegated_functions : :substantive
  end

  def cit_key
    @cit_key ||= @client_involvement_type == "A" ? :cit_a : :non_cit_a
  end
end
