class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :company_id
      t.integer :user_id
      t.string  :privilege
      t.boolean :approved
      t.timestamps
    end
  end
end
