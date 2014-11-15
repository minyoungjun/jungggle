class Comlang < ActiveRecord::Base
  belongs_to  :company
  belongs_to  :language
  has_many  :comdocuments
end
