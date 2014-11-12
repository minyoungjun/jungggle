class AddAttachmentLogoToComclients < ActiveRecord::Migration
  def self.up
    change_table :comclients do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :comclients, :logo
  end
end
