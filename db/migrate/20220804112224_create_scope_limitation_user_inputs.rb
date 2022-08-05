class CreateScopeLimitationUserInputs < ActiveRecord::Migration[7.0]
  def change
    create_table :scope_limitation_user_inputs do |t|
      t.references :scope_limitation, type: :uuid
      t.references :scope_user_input, type: :uuid

      t.timestamps
    end
  end
end
