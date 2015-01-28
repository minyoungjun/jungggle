class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :project_id
      t.integer :receipt_number
      t.datetime :date
      t.float :cost
      t.integer :quantity
      t.timestamps
    end
  end
end
