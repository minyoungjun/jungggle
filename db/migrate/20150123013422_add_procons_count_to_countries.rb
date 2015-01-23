class AddProconsCountToCountries < ActiveRecord::Migration

  def self.up

    add_column :countries, :procons_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :countries, :procons_count

  end

end
