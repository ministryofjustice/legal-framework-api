class AddNameToProceedingTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :proceeding_types, :name, :string, null: false, default: 'default_name'
  end
end
