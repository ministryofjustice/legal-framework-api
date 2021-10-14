# frozen_string_literal: true

class AddProceedingTypeMeritsTasks < ActiveRecord::Migration[6.1]
  def up
    load 'db/populators/proceeding_type_merits_task_populator.rb'
    ProceedingTypeMeritsTaskPopulator.call
  end

  def down
    ProceedingTypeMeritsTask.destroy_all
  end
end
