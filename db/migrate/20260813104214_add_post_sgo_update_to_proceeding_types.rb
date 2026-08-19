class AddPostSgoUpdateToProceedingTypes < ActiveRecord::Migration[8.1]
  def change
    add_column :proceeding_types, :post_sgo_update, :string
  end
end
