class CreateProceedingTypeServiceLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :proceeding_type_service_levels, id: :uuid do |t|
      t.references :proceeding_type, type: :uuid, foreign_key: true
      t.references :service_level, type: :uuid, foreign_key: true
      t.boolean :proceeding_default
      t.timestamps
    end

    add_index :proceeding_type_service_levels,
              %i[proceeding_type_id service_level_id],
              unique: true,
              name: "index_proceedings_service_levels_unique_on_ids"

    add_index :proceeding_type_service_levels,
              %i[proceeding_type_id proceeding_default],
              unique: true,
              where: "proceeding_default = true",
              name: "index_proceedings_service_levels_unique_default"
  end
end
