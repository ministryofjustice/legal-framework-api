class DropForeignKeyConstraintOnThresholdWaivers < ActiveRecord::Migration[7.1]
  def change
    remove_index :threshold_waivers,
                 %i[client_involvement_type_id matter_type_id],
                 unique: true,
                 name: "index_threshold_waivers_on_client_involvement_and_matter_types"

    remove_foreign_key :threshold_waivers, :client_involvement_types
    remove_column :threshold_waivers, :client_involvement_type_id, :uuid
    add_column :threshold_waivers, :client_involvement_type, :string
  end
end
