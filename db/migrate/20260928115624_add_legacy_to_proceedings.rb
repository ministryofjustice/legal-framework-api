class AddLegacyToProceedings < ActiveRecord::Migration[8.1]
  def change
    add_column :proceeding_types, :legacy, :boolean, default: false, null: false
  end
end
