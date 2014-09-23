class Product < ActiveRecord::Base
  belongs_to :publisher
  belongs_to  :language
  belongs_to  :payment
  belongs_to  :marketingtype
  belongs_to  :country
  has_many  :costs
end
