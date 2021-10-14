# frozen_string_literal: true

class AddMeritsTasks < ActiveRecord::Migration[6.1]
  def up
    load 'db/populators/merits_task_populator.rb'
    MeritsTaskPopulator.call
  end

  def down
    MeritsTask.destroy_all
  end
end
