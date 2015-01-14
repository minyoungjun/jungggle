class IsMobileToMarketingtypes < ActiveRecord::Migration
  def change
    add_column :marketingtypes, :is_mobile, :boolean
    change_column_default :marketingtypes, :is_mobile, false
  end
end
