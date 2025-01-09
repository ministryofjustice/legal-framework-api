class AddNonMeansTestedPLFToProceedingTypes < ActiveRecord::Migration[7.2]
  def change
    add_column :proceeding_types, :non_means_tested_plf, :boolean, default: false, null: false
  end
end
