class CreateScopeUserInputs < ActiveRecord::Migration[7.0]
  def change
    create_table :scope_user_inputs, id: :uuid do |t|
      t.text :input_name, null: false
      t.text :input_type, null: false
      t.boolean :mandatory, null: false, default: true

      t.timestamps
    end

    add_index :scope_user_inputs, :input_name, unique: true
  end
end
