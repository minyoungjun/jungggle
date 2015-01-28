class AdvertisersController < ApplicationController
  before_filter :is_login
  before_filter :sns_confirmed
  before_filter :is_confirmed
  before_filter :credit_params

  def check_out
    billing = Billing.new
    billing.user_id = current_user.id
    billing.company_id = current_user.member.company.id
    billing.amount = params[:amount]
    billing.status = 0
    billing.date = Time.now
    billing.detail = "Jungggle Credit (Add)"
    billing.payment_method = 0
    if billing.save
      render :json => ["success", billing.date_view, billing.id, billing.amount]
    else
      render :json => ["fail"]
    end

  end

  def biddings

    @selected = "biddings"
    @user = current_user
    @biddings = @user.biddings.order('created_at DESC').page(params[:page]).per(10)
    

  end
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
    @selected = "billing"
    @user = current_user

    @billings = @user.member.company.billings.order('created_at DESC').page(params[:page]).per(6)

  end
end
