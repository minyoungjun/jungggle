class Procon < ActiveRecord::Base
  belongs_to :product
  belongs_to :country
  counter_culture :country
end
