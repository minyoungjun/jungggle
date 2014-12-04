class ManagesController < ApplicationController
  before_filter :is_login
  before_filter :is_admin
    
  def destroy_service
    product = Product.find(params[:id])
    product.destroy
    redirect_to :controller => "manages", :action => "services"

  end

  def edit_process

    product = Product.find(params[:product_id])
    
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

  def edit_service
    @product = Product.find(params[:id])
  end
  def create_process
    product = Product.new
    product.company_id =  params[:company_id]
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
  def services
    @services = Product.all
  end

  def company_profile
    @has_company = true
    @company = Company.find(params[:id])
    @em_array = ["1 ~ 10", "10 ~ 50", "50 ~ 100", "100 ~ 500", "500 ~ 1000", "1000+"]

  end
  def company_update
    company = Company.find(params[:id])
    company.num_employee = params[:employee]
    company.website = params[:website]
    company.country_id = params[:country]
    company.save


    if params[:company_logo] != nil
      company.logo = params[:company_logo]
      company.save
    end
    if params[:client] != nil
      params[:client].each do |client_file|
        client = Comclient.new
        client.company_id = company.id
        client.logo = client_file.last
        client.save
      end
    end
    
    Language.all.each do |lang|
      if params["lang_#{lang.id}"] != nil
        if company.comlangs.where(:language_id => lang.id).count != 0
          comlang = company.comlangs.where(:language_id => lang.id).first
        else
          comlang = Comlang.new
        end
        comlang.language_id = lang.id
        comlang.company_id = company.id
        comlang.name = params["title_#{lang.id}"]
        comlang.introduction = params["introduction_#{lang.id}"]
        comlang.save
        if params[:company_introduction] != nil
          comdocu_params = params[:company_introduction]["#{lang.id}"]
          if comdocu_params != nil
            comdocu = Comdocument.new
            comdocu.comlang_id = comlang.id
            comdocu.saved_name = SecureRandom.hex(10) + "." + comdocu_params.original_filename.split('.').last
            comdocu.original_name = comdocu_params.original_filename
            f =  File.open(Rails.root.join("uploads", comdocu.saved_name), "wb")
            f.write(comdocu_params.read)
            f.close
            comdocu.save
          end
        end
      end


    end


    redirect_to :controller => "manages",
                :action => "company_profile",
                :id => company.id




  end
  def companies
    @company = Company.all


  end
end
