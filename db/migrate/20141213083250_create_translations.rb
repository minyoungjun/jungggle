class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :translanguage_id
      t.timestamps
    end
  end
end
