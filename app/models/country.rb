class Country < ActiveRecord::Base
  has_many :procons
  has_many  :companies
end
