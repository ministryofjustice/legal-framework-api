class CreateServiceLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :service_levels, id: :uuid do |t|
      t.integer :level, null: false
      t.string :name, null: false
      t.integer :stage
      t.timestamps
    end

    add_index :service_levels,
              :level,
              unique: true,
              name: "index_service_levels_unique_on_level"
  end
end
