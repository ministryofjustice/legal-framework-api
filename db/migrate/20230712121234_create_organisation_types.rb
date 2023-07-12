class CreateOrganisationTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :organisation_types, id: :uuid do |t|
      t.string :ccms_code, null: false
      t.string :description, null: false
      t.timestamps
    end
  end
end
