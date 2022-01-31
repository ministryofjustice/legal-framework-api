class UuidValidator < Apipie::Validator::BaseValidator
  def self.build(param_description, argument, _options, _block)
    new(param_description) if argument == :uuid
  end

  def validate(value)
    value =~ /\A^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\Z$/
  end

  def description
    "Must be an UUID. For example: b369784a-6c81-4e08-bb17-ba3bd54a3551"
  end
end
