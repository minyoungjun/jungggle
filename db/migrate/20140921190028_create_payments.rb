class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string  :name
      t.text :fee_detail
      t.timestamps
    end
  end
end
