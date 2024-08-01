class RemoveClientInvolvementTypes < ActiveRecord::Migration[7.1]
  def change
    drop_table :client_involvement_types, id: :uuid do |t|
      t.string :ccms_code, null: false
      t.string :description, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :ordering
    end
  end
end
