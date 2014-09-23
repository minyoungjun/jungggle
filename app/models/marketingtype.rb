class Marketingtype < ActiveRecord::Base
  has_many :child_types, class_name: "Marketingtype", foreign_key: "parent_id"
  belongs_to :parent_type, class_name: "Marketingtype", foreign_key: "parent_id"
  has_many :products
end
