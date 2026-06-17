class CreateExpertTypeMatterTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :expert_type_matter_types, id: :uuid do |t|
      t.references :expert_type, type: :uuid, null: false, foreign_key: true
      t.references :matter_type, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :expert_type_matter_types,
              %i[expert_type_id matter_type_id],
              unique: true,
              name: "index_expert_type_matter_types_uniqueness"
  end
end
