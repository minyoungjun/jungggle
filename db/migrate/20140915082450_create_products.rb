class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :language_id
      t.integer :country_id
      t.string  :name
      t.integer :marketing_type
      t.text :service_detail
      t.timestamps
    end
  end
end
