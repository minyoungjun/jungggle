class PublishersController < ApplicationController

before_filter :is_login, :except => [:list]

  def create
    @languages = Language.all
    @marketing = Marketingtype.where(:filter => 1)
    @countries = Country.all
    @payments = Payment.all
  end

  def create_process


=begin
    company = Company.new
    company.name = params[:company_name]
    company.save

    current_user.company_id = company.id
    current_user.save

=end

    product = Product.new
    product.user_id = current_user.id
    
    product.marketingtype_id = params[:marketing_type]
    product.status = 1 #0: off , 1:on, 2:etc
    product.save

    Language.all.each do |lang|
      if params["lang_#{lang.id}"] != nil
        prolang = Prolang.new
        prolang.language_id = lang.id
        prolang.product_id = product.id
        prolang.title = params["title_#{lang.id}"]
        prolang.save
      end
    end

    0.upto(params[:detail_count].to_i) do |detail_count|
      preserved = false
      product.prolangs.each do |prolang|
        if params["service_detail_#{detail_count}_#{prolang.language.id}"] != ""
          preserved = true
        end
      end
      if preserved
        detail = Detail.new
        detail.product_id = product.id
        detail.save
        if params["detail_photo_#{detail_count}"] != nil
          proimage = Proimage.new
          proimage.detail_id = detail.id
          proimage.photo = params["detail_photo_#{detail_count}"]
          proimage.save
        end
        product.prolangs.each do |prolang|
          detailang = Detailang.new
          detailang.prolang_id = prolang.id
          detailang.detail_id = detail.id
          detailang.content = params["service_detail_#{detail_count}_#{prolang.language.id}"]
          detailang.save
        end
      end
    end

    cost = Cost.new
    cost.product_id = product.id
    cost.amount = params[:cost]
    cost.save

    redirect_to :action => "search_result", :controller => "products", :id => product.id


  end
  def manage
    @user = current_user

  end
end
