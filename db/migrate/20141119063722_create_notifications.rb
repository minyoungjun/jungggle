class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :level #0: red, 1: green
      t.text  :information
      t.boolean :is_important
      t.timestamps
    end
  end
end
