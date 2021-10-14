# frozen_string_literal: true

class AddProceedingTypes < ActiveRecord::Migration[6.1]
  def up
    ProceedingType.populate
  end

  def down
    ProceedingType.destroy_all
  end
end
