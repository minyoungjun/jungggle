class Translation < ActiveRecord::Base
  belongs_to  :translanguage
  belongs_to  :product
  belongs_to :product_from, class_name: "Product", foreign_key: "from_id"
  belongs_to :product_to, class_name: "Product", foreign_key: "to_id"
end
