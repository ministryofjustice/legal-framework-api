class CreateProceedingTypeMeritsTask < ActiveRecord::Migration[6.1]
  def change
    create_table :proceeding_type_merits_tasks, id: :uuid do |t|
      t.uuid :proceeding_type_id, null: false
      t.uuid :merits_task_id, null: false
      t.integer :sequence, null: false
      t.timestamps
    end

    add_index :proceeding_type_merits_tasks, :proceeding_type_id
  end
end
