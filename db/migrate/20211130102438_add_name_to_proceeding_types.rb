class AddNameToProceedingTypes < ActiveRecord::Migration[6.1]
  # rubocop:disable Rails/NotNullColumn
  def change
    add_column :proceeding_types, :name, :string, null: false
  end
  # rubocop:enable Rails/NotNullColumn
end
