class AddIndexNumberToMarketingtypes < ActiveRecord::Migration
  def change
    add_column :marketingtypes, :index_number, :integer
  end
end
