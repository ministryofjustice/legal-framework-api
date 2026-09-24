class RemovePostSgoUpdateFromProceedingTypes < ActiveRecord::Migration[8.1]
  def change
    remove_column :proceeding_types, :post_sgo_update, :boolean
  end
end
