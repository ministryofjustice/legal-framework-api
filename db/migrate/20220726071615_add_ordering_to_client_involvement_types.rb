class AddOrderingToClientInvolvementTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :client_involvement_types, :ordering, :integer
  end
end
