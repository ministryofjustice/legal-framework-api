class AddStartDateEndDateToProceedings < ActiveRecord::Migration[8.1]
  def change
    add_column :proceeding_types, :start_date, :date, default: Date.new(2021, 1, 1), null: false
    add_column :proceeding_types, :end_date, :date, default: Date.new(2099, 12, 31), null: false
  end
end
