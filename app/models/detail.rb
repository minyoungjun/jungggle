class Detail < ActiveRecord::Base
  belongs_to :product
  has_many  :proimages
  has_many  :detailangs
end
