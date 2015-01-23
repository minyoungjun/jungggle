class AddProductsCountToMarketingtypes < ActiveRecord::Migration

  def self.up

    add_column :marketingtypes, :products_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :marketingtypes, :products_count

  end

end
