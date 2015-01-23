class Company < ActiveRecord::Base
  validates :logo,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  has_attached_file :logo, styles: {
    thumb: '52x52#',
    square: '200x200#',
    medium: '300x300>'
  }
  belongs_to :country
  counter_culture :country
  has_many :members
  has_many :products
  has_many :comlangs
  has_many  :comclients

  def employee_count
    count = String.new
    case self.num_employee
    when 0
      count = "1~10"
    when 1
      count = "10~50"
    when 2
      count = "50~100"
    when 3
      count = "100~500"
    when 4
      count = "500~1000"
    when 5
      count = "1000+"
    end
    return count
  end

end
