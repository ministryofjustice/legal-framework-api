class CreateProceedingTypeScopes < ActiveRecord::Migration[7.0]
  def change
    create_table :proceeding_type_scopes, id: :uuid do |t|
      t.string :proceeding_type_ccms_code, null: false
      t.integer :service_level, null: false
      t.string :client_involvement_type_code, null: false
      t.boolean :df_used, null: false
      t.string :scope_limitation_code, null: false
      t.boolean :default, null: false, default: false

      t.timestamps
    end

    add_index :proceeding_type_scopes,
              %i[proceeding_type_ccms_code service_level client_involvement_type_code df_used],
              name: "pt_sl_cit_df_idx",
              unique: false
  end
end
