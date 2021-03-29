class CreateProceedingTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :proceeding_types, id: :uuid do |t|
      t.string :ccms_code, null: false
      t.string :meaning, null: false
      t.string :description, null: false
      t.uuid :matter_type_id, null: false
      t.timestamps
    end
  end
end
