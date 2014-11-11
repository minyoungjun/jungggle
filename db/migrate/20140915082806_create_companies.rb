class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :num_employee
      t.string  :website
      t.string  :logo_src

      t.timestamps
    end
  end
end
