class AddMoneysToCosts < ActiveRecord::Migration
  def change
    add_column :costs, :money, :float
  end
end
