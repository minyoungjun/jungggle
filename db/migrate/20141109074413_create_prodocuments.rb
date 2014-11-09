class CreateProdocuments < ActiveRecord::Migration
  def change
    create_table :prodocuments do |t|
      t.integer :product_id
      t.string  :name
      t.string  :saved_name
      t.text  :original_name
      t.timestamps
    end
  end
end
