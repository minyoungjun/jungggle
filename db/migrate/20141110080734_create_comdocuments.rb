class CreateComdocuments < ActiveRecord::Migration
  def change
    create_table :comdocuments do |t|
      t.integer :company_id
      t.string  :name
      t.string  :saved_name
      t.text  :original_name

      t.timestamps
    end
  end
end
