class AddIndexToMatterTypes < ActiveRecord::Migration[7.2]
  def change
    add_index :matter_types, :code, name: "index_matter_types_on_code", unique: true
  end
end
