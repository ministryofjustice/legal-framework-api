class CreateExpertTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :expert_types, id: :uuid do |t|
      t.string :code, null: false
      t.string :description, null: false

      t.timestamps
    end

    add_index :expert_types, :code, unique: true
  end
end
