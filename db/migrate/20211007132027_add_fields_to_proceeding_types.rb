class AddFieldsToProceedingTypes < ActiveRecord::Migration[6.1]
  def change
    change_table :proceeding_types, bulk: true do |t|
      t.string :ccms_category_law_code
      t.string :ccms_matter_code
    end
  end
end
