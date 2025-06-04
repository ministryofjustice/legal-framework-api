class RemoveFullS8FromProceedingTypes < ActiveRecord::Migration[8.0]
  def change
    remove_column :proceeding_types, :full_s8_only, :boolean
  end
end
