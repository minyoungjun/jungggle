class CreateUsernotis < ActiveRecord::Migration
  def change
    create_table :usernotis do |t|
      t.integer :user_id
      t.integer :notification_id
      t.text  :content
      t.boolean :is_deleted, default: false
      t.timestamps
    end
  end
end
