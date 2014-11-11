class Language < ActiveRecord::Base
  has_many :prolangs
  has_many  :comlangs
end
