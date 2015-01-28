class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :billing_id
      t.integer :invoice_number
      t.string  :receiver
      t.string  :email
      t.text  :description
      t.string  :price
      t.string  :payment_method
      t.string  :order_number
      t.string  :bank_name
      t.string  :bank_swift_code
      t.text  :bank_address
      t.string  :beneficiary_name
      t.string  :iban #recipient's account number

      t.timestamps
    end
  end
end
