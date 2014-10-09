class Company < ActiveRecord::Base
  validates :logo,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  has_attached_file :logo, styles: {
    thumb: '52x52#',
    square: '200x200#',
    medium: '300x300>'
  }
  has_many :members
  has_many :products
end
