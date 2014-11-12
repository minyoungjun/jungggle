class CreateComclients < ActiveRecord::Migration
  def change
    create_table :comclients do |t|
      t.integer :company_id
      t.timestamps
    end
  end
end
