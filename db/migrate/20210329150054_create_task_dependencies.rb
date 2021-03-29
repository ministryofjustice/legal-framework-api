class CreateTaskDependencies < ActiveRecord::Migration[6.1]
  def change
    create_table :task_dependencies do |t|
      t.uuid :merits_task_id
      t.uuid :dependency_id

      t.timestamps
    end
  end
end
