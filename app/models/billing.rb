class Billing < ActiveRecord::Base

  def date_view
    if self.date.to_s[5] == "0"
      return self.date.to_s[0..3] + ". " + self.date.to_s[6] + ". " + self.date.to_s[8..9]
    else
      return self.date.to_s[0..3] + ". " + self.date.to_s[5..6] + ". " + self.date.to_s[8..9]
    end
  end
end
