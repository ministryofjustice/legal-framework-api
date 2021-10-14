# frozen_string_literal: true

class AddTaskDependencies < ActiveRecord::Migration[6.1]
  def up
    load 'db/populators/task_dependency_populator.rb'
    TaskDependencyPopulator.call
  end

  def down
    TaskDependency.destroy_all
  end
end
