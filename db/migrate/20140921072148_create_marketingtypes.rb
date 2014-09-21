class CreateMarketingtypes < ActiveRecord::Migration
  def change
    create_table :marketingtypes do |t|
      t.string  :name
      t.timestamps
    end
  end
end
