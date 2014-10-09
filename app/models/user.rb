class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :avatar,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  has_attached_file :avatar, styles: {
    thumb: '52x52#',
    square: '200x200#',
    medium: '300x300>'
  }
  has_one :member
  has_many :carts
  has_many  :products
  has_many  :billings
  has_many  :biddings
end
