class AddBankAddressToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :bank_address, :text
  end
end
