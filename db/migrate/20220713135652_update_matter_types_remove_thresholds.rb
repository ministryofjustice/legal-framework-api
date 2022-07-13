class UpdateMatterTypesRemoveThresholds < ActiveRecord::Migration[7.0]
  def up
    change_table :matter_types, bulk: true do |t|
      t.remove :upper_gross_income_waiver, :upper_disposable_income_waiver, :upper_capital_waiver
    end
  end

  def down
    change_table :matter_types, bulk: true do |t|
      t.boolean :upper_gross_income_waiver, default: false, null: false
      t.boolean :upper_disposable_income_waiver, default: false, null: false
      t.boolean :upper_capital_waiver, default: false, null: false
    end

    MatterType.where(name: "Domestic abuse").update!(upper_gross_income_waiver: true,
                                                     upper_disposable_income_waiver: true,
                                                     upper_capital_waiver: true)
  end
end
