class CreateDetailangs < ActiveRecord::Migration
  def change
    create_table :detailangs do |t|
      t.integer :detail_id
      t.integer :prolang_id
      t.text  :content
      t.timestamps
    end
  end
end
