class Payment < ActiveRecord::Base
  has_many :products
end
