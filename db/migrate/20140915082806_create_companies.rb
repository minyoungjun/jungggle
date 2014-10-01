class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|

      t.string  :name
      t.text :location
      t.integer :num_employee
      t.string  :website
      t.text :introduction
      t.string  :logo_src

      t.timestamps
    end
  end
end
