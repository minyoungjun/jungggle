class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.integer :product_id
      t.text  :content
      t.timestamps
    end
  end
end
