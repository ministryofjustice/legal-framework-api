class RemoveIndexFromMatterTypes < ActiveRecord::Migration[7.2]
  def change
    remove_index :matter_types, :name, name: "index_matter_types_on_name", unique: true
  end
end
