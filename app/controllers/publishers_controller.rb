class PublishersController < ApplicationController

before_filter :is_login, :except => [:list]

  def create
    @languages = Language.all
    @marketing = Marketingtype.where(:filter => 1)
    @countries = Country.all
    @payments = Payment.all
  end

  def create_process
    product = Product.new
    product.language_id = params[:language]
    product.name = params[:service_name]
    product.marketingtype_id = params[:marketing_type]
    product.service_detail = params[:detail]
    product.country_id = params[:country]
    product.payment_id = params[:payment]
    product.save
    cost = Cost.new
    cost.product_id = product.id
    cost.amount = params[:cost]
    cost.save
    company = Company.new
    company.name = params[:company]
    company.save
    current_user.company_id = compnany.id
    current_user.save

    render :text => "seccess"

  end
end
