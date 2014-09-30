class CreateBiddings < ActiveRecord::Migration
  def change
    create_table :biddings do |t|
      t.integer :user_id
      t.integer :country_id
      t.integer :marketingtype_id
      t.integer :company_id
      t.string  :name
      t.string  :service_url
      t.text  :detail
      t.integer :budget
      t.datetime :deadline
      t.timestamps
    end
  end
end
