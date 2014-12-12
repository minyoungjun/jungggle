class PublishersController < ApplicationController
  before_filter :is_login
  before_filter :sns_confirmed
  before_filter :is_confirmed
  before_filter :company_confirmed

  def destroy_service
    product = Product.where(:id => params[:id], :company_id => Member.where(:user_id => current_user.id, :approved => true).first.company.id).first
    product.destroy
    redirect_to :controller => "publishers", :action => "manage"

  end

  def edit_process

    product = Product.where(:id => params[:product_id], :company_id => Member.where(:user_id => current_user.id, :approved => true).first.company.id).first
    
    if ((10 < params[:marketing_id].to_i) && (params[:marketing_id].to_i < 60) ) || params[:marketing_id].to_i == 90
      if params[:platform].to_i != 0
        product.marketingtype_id = (params[:marketing_id].to_i + params[:platform].to_i + 1).to_i
      else
        product.marketingtype_id = params[:marketing_id]
      end
    else
      product.marketingtype_id = params[:marketing_id]
    end

    product.minimum_budget = params[:minimum_budget]

    product.save
    Language.all.each do |lang|
      if params["lang_#{lang.id}"] != nil
        if product.prolangs.where(:language_id => lang.id).count != 0
          prolang = product.prolangs.where(:language_id => lang.id).first
          prolang.language_id = lang.id
          prolang.product_id = product.id
          prolang.title = params["title_#{lang.id}"]
          prolang.save
        else
          prolang = Prolang.new
          prolang.language_id = lang.id
          prolang.product_id = product.id
          prolang.title = params["title_#{lang.id}"]
          prolang.save

          product.details.each do |detail|
            detailang = Detailang.new
            detailang.prolang_id = prolang.id
            detailang.detail_id = detail.id
            detailang.content = params["has_detail_#{detail.id}_#{lang.id}"]
            detailang.save
          end
        end
      else
        product.prolangs.where(:language_id => lang.id).each do |prolang|
          prolang.delete
        end
      end
    end
    
    product.details.each do |detail|
      if params["has_detail_photo_#{detail.id}"] != nil
        if detail.proimages.count != 0
          detail_proimage = detail.proimages.first
        else
          detail_proimage = Proimage.new
          detail_proimage.detail_id = detail.id
        end
        detail_proimage.photo = params["has_detail_photo_#{detail.id}"]
        detail_proimage.save
      end

      detail.detailangs.each do |detailang|
        detailang.content = params["has_detail_#{detail.id}_#{detailang.prolang.language_id}"]
        detailang.save

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
    if params[:cost] != nil
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
    if params[:delete_cost] != nil
      params[:delete_cost].each do |key, value|
        product.costs.where(:id => key).each do |cost|
          cost.delete
        end
      end
    end
    if params[:has_country] != nil
      params[:has_country].each do |key, value|
        product.procons.where(:id => key).each do |procon|
          procon.country_id = value
          procon.save
        end
      end
    end
    if params[:delete_detail] != nil
      params[:delete_detail].each do |key, value|
        product.details.where(:id => key).each do |detail|
          detail.delete
        end
      end
    end

    if params[:country_delete] != nil
      params[:country_delete].each do |key, value|
        product.procons.where(:id => key).each do |procon|
          procon.delete
        end
      end
    end
    if params[:has_attach_name] != nil
      params[:has_attach_name].each do |key, value|
        product.prolangs.each do |prolang|
          prolang.prodocuments.where(:id => key).each do |prodocument|
            prodocument.name = value
            prodocument.save
          end
        end
      end
    end


    if params[:has_attach] != nil

      params[:has_attach].each do |key, value|
        product.prolangs.each do |prolang|
          prolang.prodocuments.where(:id => key).each do |prodocument|
            prodocument.delete
          end
        end
      end

    end

    redirect_to :action => "search_detail", :controller => "products", :id => product.id




  end
  def edit
    @product = Product.find(params[:id])
    unless current_user.member.approved && current_user.member.company.id == @product.company_id
      redirect_to "/users/company"
    end

  end
  def create
    logger.debug "==" + current_user.member.inspect
    if current_user.member == nil
      redirect_to "users/company"
    else
      @languages = Language.all
      @marketing = Marketingtype.where(:filter => 1)
      @countries = Country.all
      @payments = Payment.all
    end
  end

  def create_process

    product = Product.new
    product.company_id = current_user.member.company.id
    product.status = 1 #0: off , 1:on, 2:etc
    
    if ((10 < params[:marketing_id].to_i) && (params[:marketing_id].to_i < 60)) || params[:marketing_id].to_i == 90
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
    if current_user.member != nil && current_user.member.approved
      @services = current_user.member.company.products

    else
    end

  end
end
