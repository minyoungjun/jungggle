class CreateProcons < ActiveRecord::Migration
  def change
    create_table :procons do |t|
      t.integer :country_id
      t.integer :product_id
      t.timestamps
    end
  end
end
