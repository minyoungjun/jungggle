class CreateMarketingtypes < ActiveRecord::Migration
  def change
    create_table :marketingtypes do |t|
      t.integer :parent_id
      t.string  :name
      t.integer :filter
      t.timestamps
    end
  end
end
