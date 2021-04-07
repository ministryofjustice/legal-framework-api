class CreateRequestHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :request_histories do |t|
      t.string :request_method
      t.string :request_id
      t.string :endpoint
      t.inet :remote_ip
      t.string :request_payload
      t.integer :response_status
      t.string :response_payload
      t.timestamps
    end
  end
end
