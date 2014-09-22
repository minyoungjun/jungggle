class PublishersController < ApplicationController

  def create
    @languages = Language.all
    @marketing = Marketingtype.where(:filter => 1)
    @countries = Country.all
    @payments = Payment.all

  end
end
