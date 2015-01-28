class AddCreditToCompanies < ActiveRecord::Migration
  def change
    add_column  :companies, :credit, :float
  end
end
