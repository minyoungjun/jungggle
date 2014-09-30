class CreatePayables < ActiveRecord::Migration
  def change
    create_table :payables do |t|
      t.integer :payment_id
      t.integer :product_id
      t.timestamps
    end
  end
end
