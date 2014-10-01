class AdvertisersController < ApplicationController
  def new_bidding
    @languages = Language.all
    @marketing = Marketingtype.where(:filter => 1)
    @countries = Country.all
    @payments = Payment.all
  end
  def new_process

    company = Company.new
    company.name = params[:company_name]
    company.save
    current_user.company_id = company.id
    current_user.save
    bidding = Bidding.new
    bidding.user_id = current_user.id
    bidding.country_id = params[:country]
    bidding.name = params[:service_name]
    bidding.service_url = params[:url]
    bidding.budget = params[:budget]
    bidding.marketingtype_id = params[:marketing_type]
    bidding.deadline = params[:deadline]
    bidding.detail = params[:detail]
    bidding.save
    redirect_to :root

  end
  def billing
    @user = current_user
  end
  def add_credit
    user = current_user
    billing = Billing.new
    billing.user_id = user.id
    billing.detail = "Jungggle Credit"
    billing.date = Time.now
    billing.payment_method = "Wire Transfer"
    billing.amount = params[:amount]
    billing.status = 0
    billing.save
    redirect_to :back
  end
end
