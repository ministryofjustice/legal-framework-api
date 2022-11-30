class RemoveProceedingTypeScopeLimitations < ActiveRecord::Migration[7.0]
  def up
    drop_table :proceeding_type_scope_limitations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
