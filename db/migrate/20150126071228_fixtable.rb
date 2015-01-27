class Fixtable < ActiveRecord::Migration
  def self.up
    change_column :billings, :amount, :float
    change_column :billings, :payment_method, :integer
  end
  def self.down
    change_column :billings, :amount, :integer
    change_column :billings, :payment_method, :string
  end
end
