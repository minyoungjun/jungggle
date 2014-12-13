class CreateTranslanguages < ActiveRecord::Migration
  def change
    create_table :translanguages do |t|
      t.string  :name
      t.string  :nickname
      t.timestamps
    end
  end
end
