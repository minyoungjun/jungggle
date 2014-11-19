class AddPriceToCosts < ActiveRecord::Migration
  def change
    add_column :costs, :price, :decimal, :precision => 8, :scale => 2
  end
end
