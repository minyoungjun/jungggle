class Product < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to  :marketingtype
  belongs_to :company
  has_many  :prolangs
  has_many  :costs
  has_many  :carts
  has_many  :payables
  has_many  :procons
  has_many  :details
end
