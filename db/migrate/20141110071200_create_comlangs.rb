class CreateComlangs < ActiveRecord::Migration
  def change
    create_table :comlangs do |t|
      t.integer :language_id
      t.integer :company_id
      t.string  :name
      t.text :introduction
      t.timestamps
    end
  end
end
