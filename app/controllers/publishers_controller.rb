class PublishersController < ApplicationController

  def create
    @languages = Language.all
    @marketing = Marketingtype.all
    @countries = Country.all
    @payments = Payment.all

  end
end
