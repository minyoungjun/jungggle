class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :is_login

  def company_update


  end

  def finish_signup
    @em_array = ["1 ~ 10", "10 ~ 50", "50 ~ 100", "100 ~ 500", "500 ~ 1000", "1000+"]
  end


  def company
    if current_user.member == nil || !(current_user.member.approved)

      @has_company = false
    else
      @has_company = true
      @company = current_user.member.company
    end

      @em_array = ["1 ~ 10", "10 ~ 50", "50 ~ 100", "100 ~ 500", "500 ~ 1000", "1000+"]

  end


  def signup_company

    company = Company.new
    company.num_employee = params[:employee]
    company.website = params[:website]
    company.country_id = params[:country]
    company.save
    
    Language.all.each do |lang|
      if params["lang_#{lang.id}"] != nil
        comlang = Comlang.new
        comlang.language_id = lang.id
        comlang.company_id = company.id
        comlang.name = params["title_#{lang.id}"]
        comlang.introduction = params["introduction_#{lang.id}"]
        comlang.save
      end
    end

    member = Member.new
    member.company_id = company.id
    member.user_id = current_user.id
    member.owner = true
    member.approved = true
    member.save


    redirect_to :controller => "users",
                :action => "company"

  end

  def confirm
    this_user = current_user
    if !(current_user.email_confirmed)
      this_user.email_confirmed = true
      this_user.confirmation_token = SecureRandom.hex(6)
      this_user.save
      this_user.update(user_params)
      sign_in(this_user, :bypass => true)

    end
    redirect_to "/users/finish_signup"
  end
  def signup_process
    @user = current_user
  end

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [:first_name, :last_name, :email, :news_mailing] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
