class AddCompaniesCountToCountries < ActiveRecord::Migration

  def self.up

    add_column :countries, :companies_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :countries, :companies_count

  end

end
