class AddCountryIdToBillings < ActiveRecord::Migration
  def change
    add_column  :billings, :coutry_id, :integer
  end
end
