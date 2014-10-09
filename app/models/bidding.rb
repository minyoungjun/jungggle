class Bidding < ActiveRecord::Base
  belongs_to :user
  belongs_to :marketingtype
  belongs_to :country
end
