class CreateProimages < ActiveRecord::Migration
  def change
    create_table :proimages do |t|
      t.integer :detail_id
      t.timestamps
    end
  end
end
