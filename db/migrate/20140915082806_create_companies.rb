class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :num_employee #0: 1-10, 1: 10-50, 2: 50-100, 3: 100 - 500, 4: 500 - 1000, 5: 1000+
      t.integer :country_id
      t.string  :website

      t.timestamps
    end
  end
end
