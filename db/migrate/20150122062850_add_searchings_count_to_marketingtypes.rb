class AddSearchingsCountToMarketingtypes < ActiveRecord::Migration

  def self.up

    add_column :marketingtypes, :searchings_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :marketingtypes, :searchings_count

  end

end
