class Product < ActiveRecord::Base
  translates :title
  belongs_to :user
  belongs_to  :marketingtype
  belongs_to :company
  has_many  :prolangs
  has_many  :costs
  has_many  :carts
  has_many  :payables
  has_many  :procons
end
