class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :code, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
