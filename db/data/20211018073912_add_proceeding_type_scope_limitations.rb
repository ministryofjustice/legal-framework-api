# frozen_string_literal: true

class AddProceedingTypeScopeLimitations < ActiveRecord::Migration[6.1]
  def up
    load 'db/populators/proceeding_type_scope_limitations_populator.rb'
    ProceedingTypeScopeLimitationsPopulator.call
  end

  def down
    ProceedingTypeScopeLimitation.destroy_all
  end
end
