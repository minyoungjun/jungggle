class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
