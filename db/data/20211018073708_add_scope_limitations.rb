# frozen_string_literal: true

class AddScopeLimitations < ActiveRecord::Migration[6.1]
  def up
    load 'db/populators/scope_limitations_populator.rb'
    ScopeLimitationsPopulator.call
  end

  def down
    ScopeLimitation.destroy_all
  end
end
