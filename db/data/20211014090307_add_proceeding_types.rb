# frozen_string_literal: true

class AddProceedingTypes < ActiveRecord::Migration[6.1]
  def up
    ProceedingType.populate
    puts 'populated proceeding types'
  end

  def down
    ProceedingType.destroy_all
    ScopeLimitation.destroy_all
  end
end
