class AddSearchingsCountToCountries < ActiveRecord::Migration

  def self.up

    add_column :countries, :searchings_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :countries, :searchings_count

  end

end
