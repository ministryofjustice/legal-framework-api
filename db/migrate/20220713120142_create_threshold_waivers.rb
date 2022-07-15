class CreateThresholdWaivers < ActiveRecord::Migration[7.0]
  def change
    create_table :threshold_waivers do |t|
      t.belongs_to :client_involvement_type, null: false, foreign_key: true, type: :uuid
      t.belongs_to :matter_type, null: false, foreign_key: true, type: :uuid
      t.boolean :gross_income_upper
      t.boolean :disposable_income_upper
      t.boolean :capital_upper

      t.timestamps
    end

    add_index :threshold_waivers,
              %i[client_involvement_type_id matter_type_id],
              unique: true,
              name: "index_threshold_waivers_on_client_involvement_and_matter_types"
  end
end
