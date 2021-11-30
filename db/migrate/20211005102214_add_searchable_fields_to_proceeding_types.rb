class AddSearchableFieldsToProceedingTypes < ActiveRecord::Migration[6.1]
  def up
    add_column :proceeding_types, :additional_search_terms, :string
    execute 'ALTER TABLE proceeding_types ADD COLUMN textsearchable tsvector'
    execute 'CREATE INDEX textsearch_idx ON proceeding_types USING GIN (textsearchable)'
  end

  def down
    remove_column :proceeding_types, :additional_search_terms
    execute 'DROP INDEX textsearch_idx'
    execute 'ALTER TABLE proceeding_types DROP COLUMN textsearchable'
  end
end
