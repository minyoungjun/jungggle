class Marketingtype < ActiveRecord::Base
  has_many :child_types, class_name: "Marketingtype", foreign_key: "parent_id"
  belongs_to :parent_type, class_name: "Marketingtype", foreign_key: "parent_id"
  has_many :products

  def subtypes
    mkt_array = Array.new
    mkt_array << self
    self.child_types.each do |first_child|
      mkt_array << first_child
      first_child.child_types.each do |second_child|
        mkt_array << second_child
        second_child.child_types.each do |third_child|
          mkt_array << third_child
        end
      end
    end
    return mkt_array
  end

  def upper_types
    mkt_array = Array.new
    mkt_array << self

    first_parent =  self.parent_type
    if first_parent != nil
      mkt_array << first_parent
      second_parent =  first_parent.parent_type
      if second_parent != nil
        mkt_array << second_parent
          third_parent =  second_parent.parent_type
          if third_parent != nil
            mkt_array << third_parent
          end
      end
    end

    return mkt_array.reverse
  end



end
