require 'open-uri'

class ProductsController < ApplicationController


  def search_company

    @company = Company.find(params[:id])

    @products = @company.products.order('created_at ASC')

  end

  def search

    @products_array = Array.new
    
    0.upto(2) do |x|
      @products_array[x] = Array.new
    end

    order_number = 0
    if params[:cost_from] != "" && params[:cost_to] != ""

      Cost.where("money >= ? AND money <= ?", params[:cost_from].to_f, params[:cost_to].to_f).each do |cost|
        @products_array[order_number] << cost.product
      end
        
    elsif params[:cost_from] != nil #최소만 설정돼있음 얼마이상

      Cost.where("money >= ?", params[:cost_from].to_f).each do |cost|
        @products_array[order_number] << cost.product
      end

    elsif params[:cost_to] != nil #최대금액만있음

      Cost.where("money <= ?", params[:cost_from].to_f).each do |cost|
        @products_array[order_number] << cost.product
      end

    else
      @products_array[order_number] = Product.all
    end

    order_number = order_number + 1

    if params[:marketing].to_i != 1

      if (10 < params[:marketing].to_i) && (params[:marketing].to_i < 60)
        if params[:platform].to_i != 0
          @marketing = Marketingtype.find(params[:marketing].to_i + params[:platform].to_i + 1)
        else
          @marketing = Marketingtype.find(params[:marketing])
        end
      else
        @marketing = Marketingtype.find(params[:marketing])
      end
      @marketing.subtypes.each do |subtype|
        
        subtype.products.each do |product|

          @products_array[order_number] <<  product
        end
      end
    else
      @products_array[order_number] = Product.all
    end
    order_number = order_number + 1

    if params[:country].to_i != 0
      @country = Country.find(params[:country])
      @country.procons.each do |procon|
        @products_array[order_number] << procon.product
      end
    else
      @products_array[order_number] = Product.all
    end

    @products = (@products_array[0] & @products_array[1] & @products_array[2] ).sort_by(&:updated_at).reverse


  end
  def comdocument

    comdocument = Comdocument.find(params[:id])

  send_data open(Rails.root.join("uploads", comdocument.saved_name)).read, :filename => comdocument.original_name, :type => "multipart/related"
  end

  def attachment
    prodocument = Prodocument.find(params[:id])

  send_data open(Rails.root.join("uploads", prodocument.saved_name)).read, :filename => prodocument.original_name, :type => "multipart/related"

  end
  def search_detail


    @product = Product.find(params[:id])
    @company = @product.company

    @country = Country.where("lower(name) = ?", params[:country].downcase.gsub('_', ' ')).first
    if @country.procons.where(:product_id => @product.id).count == 0
      @country = @product.procons.first.country
    end

    @products = Array.new
    @products << @product
    same_marketing = @company.products.where(:marketingtype => @product.marketingtype_id)
    same_marketing.each do |product|
      if product.procons.where(:country_id => @country_id).count != 0
        @products << product
      end
    end
    @products.uniq!

    @prolangs = Array.new
    @products.each do |product|
      product.prolangs.each do |prolang|
        @prolangs << prolang.language
      end
    end
    @prolangs.uniq!


    @countries = Array.new
    @company.products.each do |product|
      product.procons.each do |procon|
        @countries << [ product , procon.country ]
      end
    end
    @countries.uniq! { |s| s.last } 
    
  end

  def search_result
    @product = Product.find(params[:id])
    @company = @product.company

  end
  def cart
    @user = current_user
    
  end
  def add_cart
    if Cart.where("user_id" => current_user.id, "product_id"=> params[:id].to_i).count == 0
      cart = Cart.new
      cart.product_id = params[:id]
      cart.user_id = current_user.id
      cart.save
      render :json => ["success"]
    else
      render :json => ["fail"]
    end

  end
end
