class Searching < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :marketingtype
  belongs_to  :country
  counter_culture :user
  counter_culture :marketingtype
  counter_culture :country

end
