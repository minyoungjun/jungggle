require 'open-uri'

class ProductsController < ApplicationController

  def search

    @products_array = Array.new
    order_number = 0

    if params[:cost_from] != nil && params[:cost_to] != nil
      @products_array[order_number] = Array.new

      Cost.where("money >= ? AND money <= ?", params[:cost_from].to_f, params[:cost_to].to_f).each do |cost|
        @products_array[order_number] << cost.product
      end
        
    elsif params[:cost_from] != nil #최소만 설정돼있음 얼마이상
      Cost.where("money >= ?", params[:cost_from].to_f)

    elsif params[:cost_to] != nil #최대금액만있음

    else

    end

    order_number = order_number + 1

    if params[:marketing_type].to_i != 0


    end

  end
  def attachment
    prodocument = Prodocument.find(params[:id])

  send_data open(Rails.root.join("uploads", prodocument.saved_name)).read, :filename => prodocument.original_name, :type => "multipart/related"

  end
  def search_detail

    @product = Product.find(params[:id])
    @company = @product.company
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
