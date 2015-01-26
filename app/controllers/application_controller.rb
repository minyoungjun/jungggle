class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def cost_params
    params[:cost_from] = params[:cost_from].gsub(',','').to_f
    params[:cost_to] = params[:cost_to].gsub(',','').to_f
  end

  def is_product_controller
    @is_product_controller = 1
  end
  def is_admin
    unless user_signed_in? && current_user.is_admin
      redirect_to "/users/sign_in"
    end
  end
  def is_login
    unless user_signed_in?
      redirect_to "/users/sign_in" 
    end
      
  end

  def is_confirmed
    if current_user.confirmed_at == nil
      if current_user.usernotis.where(:notification_id => 1, :is_deleted => false).count == 0
        current_user.user_notify(1)
      end
      redirect_to "/"
    end
  end

  def sns_confirmed
    
    unless current_user.email_confirmed
      current_user.user_notify(5)
      redirect_to :controller => "users",
                  :action => "signup_process"
    end
  end

  def company_confirmed

    if current_user.member == nil && !current_user.is_admin
      current_user.user_notify(3)
      redirect_to :controller => "users",
                  :action => "company"
      
    elsif !current_user.is_admin && !(current_user.member.approved)

      current_user.user_notify(6)
      redirect_to :root
      
    end
  end


  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
end
