class Prolang < ActiveRecord::Base
  belongs_to :product
  belongs_to :language
  has_many  :detailangs
  has_many  :prodocuments
end
