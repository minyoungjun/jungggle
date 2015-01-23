class Product < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to  :marketingtype
  counter_culture :marketingtype
  belongs_to :company
  has_many  :prolangs
  has_many  :costs
  has_many  :carts
  has_many  :payables
  has_many  :procons
  has_many  :details
  has_one :trans_from, class_name: "Translation", foreign_key: "from_id"
  has_one :trans_to, class_name: "Translation", foreign_key: "to_id"
end
