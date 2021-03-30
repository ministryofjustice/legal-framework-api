class CreateMeritsTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :merits_tasks, id: :uuid do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.timestamps
    end
  end
end
