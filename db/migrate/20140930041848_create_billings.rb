class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.integer :user_id
      t.integer :status, :default => 0  #0: pending, 1: charge, 2: spent
      t.datetime :date
      t.string  :detail
      t.integer  :payment_method #0: Wire Transfer, 1: Jungggle Credit
      t.integer :amount

      t.timestamps
    end
  end
end
