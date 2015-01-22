class Country < ActiveRecord::Base
  has_many :procons
  has_many  :companies
  has_many  :searchings

  def self.able_list

    countries = Array.new
    Procon.all.each do |procon|
      countries << procon.country
    end
    if countries.uniq.count != 0
      countries.uniq!
      countries.compact!
      countries.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    end

    return countries

  end
end
