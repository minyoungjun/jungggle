class Procon < ActiveRecord::Base
  belongs_to :product
  belongs_to :country
end