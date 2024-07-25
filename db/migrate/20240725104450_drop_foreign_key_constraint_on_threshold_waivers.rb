class DropForeignKeyConstraintOnThresholdWaivers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :threshold_waivers, :client_involvement_types
    remove_column :threshold_waivers, :client_involvement_type_id, :uuid
    add_column :threshold_waivers, :client_involvement_type, :string
  end
end
