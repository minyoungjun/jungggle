class CreateProlangs < ActiveRecord::Migration
  def change
    create_table :prolangs do |t|
      t.integer :product_id
      t.integer :language_id
      t.text  :title
      t.timestamps
    end
  end
end
