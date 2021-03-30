class CreateMatterTypes < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
    create_table :matter_types, id: :uuid do |t|
      t.string :name, null: false
      t.boolean :upper_gross_income_waiver, default: false, null: false
      t.boolean :upper_disposable_income_waiver, default: false, null: false
      t.boolean :upper_capital_waiver, default: false, null: false
      t.timestamps
    end

    add_index :matter_types, :name, unique: true
  end
end
