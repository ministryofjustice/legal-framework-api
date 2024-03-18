class AddSearchableToCountry < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def up
    add_column :countries, :searchable, :tsvector
    add_index :countries, :searchable, using: :gin, algorithm: :concurrently
  end

  def down
    remove_column :countries, :searchable
  end
end
