class Product < ActiveRecord::Base
  belongs_to :publisher
  belongs_to  :language
  has_many  :costs
end
