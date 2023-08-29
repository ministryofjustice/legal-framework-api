class AddSearchableToOrganisations < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE organisations
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('simple', coalesce(name, '')), 'A') ||
        setweight(to_tsvector('simple', coalesce(searchable_type,'')), 'B')
      ) STORED;
    SQL
  end

  def down
    remove_column :organisations, :searchable
  end
end
