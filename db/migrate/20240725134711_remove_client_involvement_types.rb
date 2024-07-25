class RemoveClientInvolvementTypes < ActiveRecord::Migration[7.1]
  def change
    drop_table :client_involvement_types
  end
end
