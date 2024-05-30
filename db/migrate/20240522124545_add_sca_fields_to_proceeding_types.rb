class AddScaFieldsToProceedingTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :proceeding_types, :sca_core, :boolean
    add_column :proceeding_types, :sca_related, :boolean
  end
end
