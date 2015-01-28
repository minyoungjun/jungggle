class AddCompanyIdToBillings < ActiveRecord::Migration
  def change
    add_column :billings, :company_id, :integer
  end
end
