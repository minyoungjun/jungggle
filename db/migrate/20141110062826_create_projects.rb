class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :publisher_id
      t.integer :advertiser_id
      t.integer :product_id
      t.integer :quantity
      t.integer :money
      t.datetime :payment_date
      t.integer :status #0:Ongoing, 1:Complete, 2: Rejected, 3: Refund, 4: Disagreed
      t.boolean :refunded
      t.integer :result_rate
      t.text  :result_comment
      t.timestamps
    end
  end
end
