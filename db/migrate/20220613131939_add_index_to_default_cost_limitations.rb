class AddIndexToDefaultCostLimitations < ActiveRecord::Migration[7.0]
  def change
    add_index :default_cost_limitations,
              %i[proceeding_type_id cost_type start_date],
              unique: true,
              name: "index_default_cost_limitations_unique_on_cost_date_and_type"
  end
end
