class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to  :language
  belongs_to  :payment
  belongs_to  :marketingtype
  belongs_to  :country
  belongs_to :company
  has_many  :costs
  has_many  :carts
end
