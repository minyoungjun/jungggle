class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :language_id
      t.integer :country_id
      t.integer :marketingtype_id
      t.integer :company_id
      t.string  :name
      t.text :service_detail
      t.boolean :saved
      t.integer :minimun_budget
      t.integer :status #0: off , 1:on, 2:etc
      t.timestamps
    end
  end
end
