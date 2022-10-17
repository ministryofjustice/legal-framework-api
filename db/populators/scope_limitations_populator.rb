class ScopeLimitationsPopulator
  DATA_FILE = Rails.root.join("db/seed_data/scope_limitations.yml").freeze
  HEARING_DATE_CODES = %w[CV118 CV027].freeze
  LIMITATION_NOTE_CODES = %w[APL13 APL20 APL29 APL50 APL53 APL56 APL67 APL68].freeze

  def self.call
    new.call
  end

  def call
    ActiveRecord::Base.transaction do
      destroy_user_inputs
      populate_user_inputs
      seed_data.each { |attrs| populate(attrs) }
      join_scopes_to_user_inputs
    end
  end

private

  def populate(attrs)
    record = ScopeLimitation.find_by(code: attrs["code"]) || ScopeLimitation.new
    record.update!(attrs)
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)["scope_limitations"]
  end

  def destroy_user_inputs
    ScopeLimitationUserInput.destroy_all
    ScopeUserInput.destroy_all
  end

  def populate_user_inputs
    ScopeUserInput.create!(
      input_name: "hearing_date",
      input_type: "date",
      mandatory: true,
    )
    ScopeUserInput.create!(
      input_name: "limitation_note",
      input_type: "text",
      mandatory: true,
    )
  end

  def hearing_date
    ScopeUserInput.find_by(input_name: "hearing_date")
  end

  def limitation_note
    ScopeUserInput.find_by(input_name: "limitation_note")
  end

  def join_scopes_to_user_inputs
    join_hearing_dates
    join_limitation_notes
  end

  def join_hearing_dates
    HEARING_DATE_CODES.each do |code|
      scope = ScopeLimitation.find_by!(code:)
      scope.user_inputs << hearing_date
      scope.save!
    end
  end

  def join_limitation_notes
    LIMITATION_NOTE_CODES.each do |code|
      scope = ScopeLimitation.find_by!(code:)
      scope.user_inputs << limitation_note
      scope.save!
    end
  end
end
