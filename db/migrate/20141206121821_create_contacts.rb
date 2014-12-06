class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :contact_type #0: Customer Support, 1: Feedback, 2: Press
      t.string  :name
      t.string  :company_name
      t.string  :email
      t.text  :content
      t.timestamps
    end
  end
end
