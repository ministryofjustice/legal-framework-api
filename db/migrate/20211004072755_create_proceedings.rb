class CreateProceedings < ActiveRecord::Migration[6.1]
  def change
    create_table :proceedings, id: :uuid do |t|
      t.belongs_to :proceeding_type, foreign_key: true, null: false, type: :uuid
      t.uuid :legal_aid_application_id, null: false
      t.integer :proceeding_case_id, null: true
      t.date :used_delegated_functions_on, null: false
      t.date :used_delegated_functions_reported_on, null: false
      t.timestamps
    end
  end
end
