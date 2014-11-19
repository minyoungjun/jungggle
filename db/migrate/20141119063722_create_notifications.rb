class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :level #0: red, 1: green
      t.text  :content
      t.boolean :is_important
      t.boolean :is_deleted
      t.timestamps
    end
  end
end
