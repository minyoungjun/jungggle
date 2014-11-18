class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :marketingtype_id
      t.integer :company_id
      t.boolean :saved
      t.integer :minimum_budget
      t.integer :status #0: off , 1:on, 2:etc
      t.timestamps
    end
  end
end
