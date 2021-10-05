class AddFieldsToMatterType < ActiveRecord::Migration[6.1]
  def change
    change_table :matter_types, bulk: true do |t|
      t.string :category_of_law
      t.string :code
      t.string :category_of_law_code
    end
  end
end
