class CreateOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations, id: :uuid do |t|
      t.string :name, null: false
      t.string :ccms_code, null: false
      t.string :searchable_type, null: false
      t.belongs_to :organisation_type, null: false, type: :uuid, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
