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
    
    if params[:marketingtype_id].to_i > 15 && params[:marketingtype_id].to_i < 62
      product.marketingtype_id = params[:marketingtype_id].to_i + params[:platform].to_i + 1
    else
      product.marketingtype_id = params[:marketing_id]
    end

    product.status = 1 #0: off , 1:on, 2:etc

    if params[:budget] != nil
      product.minimum_budget = params[:budget]
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
    
    0.upto(params[:cost_count].to_i) do |cost_count|
      cost = Cost.new
      cost.product_id = product.id
      cost.amount = params["cost_#{cost_count}"]
      cost.save
    end
    0.upto(params[:country_count].to_i) do |country_count|
      if params["country_#{country_count}"]!= nil
        procon = Procon.new
        procon.product_id = product.id
        procon.country_id = params["country_#{country_count}"]
        procon.save
      end
    end
    0.upto(params[:docu_count].to_i) do |docu_count|
      if params["docufile_#{docu_count}"] != nil
        prodocument = Prodocument.new
        prodocument.product_id = product.id
        prodocument.name = params["docuname_#{docu_count}"]
        prodocument.saved_name = SecureRandom.hex(6) + "." + params["docufile_#{docu_count}"].original_filename.split('.').last
        f = File.open(Rails.root.join("uploads", prodocument.saved_name), "wb")
        prodocument.original_name = params["docufile_#{docu_count}"].original_filename
        f.write(params["docufile_#{docu_count}"].read)
        f.close
        prodocument.save

      end
    end

    redirect_to :action => "search_result", :controller => "products", :id => product.id


  end
  def manage
    @user = current_user

  end
end
