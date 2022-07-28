class AddFullSection8ToProceedingTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :proceeding_types, :full_s8_only, :boolean, null: false, default: false
  end
end
