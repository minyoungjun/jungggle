class Prolang < ActiveRecord::Base
  belongs_to :product
  belongs_to :language
  has_many  :detailangs
end
