class CreateScopeLimitationsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :scope_limitations, id: :uuid do |t|
      t.string :code, index: true, null: false
      t.string :meaning, null: false
      t.string :description, null: false
      t.boolean :substantive, default: false, null: false
      t.boolean :delegated_functions, default: false, null: false
      t.timestamps
    end
  end
end
