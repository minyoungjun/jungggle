class AddPhotoToProimages < ActiveRecord::Migration
  def self.up
    add_attachment :proimages, :photo
  end

  def self.down
    remove_attachment :proimages, :photo
  end
end
