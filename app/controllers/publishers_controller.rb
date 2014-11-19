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
    product.company_id = current_user.member.company.id
    product.status = 1 #0: off , 1:on, 2:etc
    
    if (10 < params[:marketing_id].to_i) && (params[:marketing_id].to_i < 60)
      if params[:platform].to_i != 0
        product.marketingtype_id = (params[:marketing_id].to_i + params[:platform].to_i + 1).to_i
      else
        product.marketingtype_id = params[:marketing_id]
      end
    else
      product.marketingtype_id = params[:marketing_id]
    end

    if params[:minimum_budget] != nil
      product.minimum_budget = params[:minimum_budget]
    end

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
    
    if params[:cost_type].to_i == 0
      cost = Cost.new
      cost.product_id = product.id
      cost.money  = params[:cost].first.last
      cost.save
    else
      params[:cost].each do |key, value|
        cost = Cost.new
        cost.product_id = product.id
        cost.money = value
        cost.save
      end
    end
    if params[:country] != nil
      params[:country].each do |key, value|
        procon = Procon.new
        procon.product_id = product.id
        procon.country_id = value
        procon.save
      end
    end

    if params[:prodocu] != nil
      params[:prodocu].each do |key, prodocu_language|
        prodocu_language.each do |num, value|
          prodocument = Prodocument.new
          prodocument.prolang_id = product.prolangs.where(:language_id => key).first.id
          prodocument.saved_name = SecureRandom.hex(6) + "." + value.original_filename.split('.').last
          f = File.open(Rails.root.join("uploads", prodocument.saved_name), "wb")
          prodocument.original_name = value.original_filename
          f.write(value.read)
          f.close
          prodocument.name = params[:attach_name]["#{key}"]["#{num}"]
          prodocument.save
        end
      end
    end


    redirect_to :action => "search_detail", :controller => "products", :id => product.id


  end
  def manage
    @user = current_user

  end
end
