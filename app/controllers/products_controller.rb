require 'open-uri'

class ProductsController < ApplicationController
  

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
