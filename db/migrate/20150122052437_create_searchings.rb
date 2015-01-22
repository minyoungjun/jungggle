class CreateSearchings < ActiveRecord::Migration
  def change
    create_table :searchings do |t|
      t.integer :user_id
      t.integer :country_id
      t.integer :marketingtype_id
      t.integer :platform
      t.float :cost_from
      t.float :cost_to
      t.timestamps
    end
  end
end
