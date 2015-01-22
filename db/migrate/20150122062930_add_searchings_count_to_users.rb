class AddSearchingsCountToUsers < ActiveRecord::Migration

  def self.up

    add_column :users, :searchings_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :searchings_count

  end

end
