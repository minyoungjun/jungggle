class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :is_login


  def finish_signup
    @em_array = ["1 ~ 10", "10 ~ 50", "50 ~ 100", "100 ~ 500", "500 ~ 1000", "1000+"]
  end

  def email_confirmation
      @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
      @user.confirmed_at = Time.now
      @user.save
    end
    render :text => "success"
  end

  def company_update

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

    member = Member.new
    member.company_id = company.id
    member.user_id = current_user.id
    member.owner = true
    member.approved = true
    member.save


    redirect_to :controller => "users",
                :action => "company"
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
    
    language = Language.find(params[:language_id])

    comlang = Comlang.new
    comlang.language_id = language.id
    comlang.company_id = company.id
    comlang.name = params[:title]
    if params[:company_introduction] != nil
      comdocu = Comdocument.new
      comdocu.comlang_id = comlang.id
      comdocu.saved_name = SecureRandom.hex(10) +"." + params["company_introduction"].original_filename.split('.').last
      comdocu.original_name = params["company_introduction"].original_filename
      f =  File.open(Rails.root.join("uploads", comdocu.saved_name), "wb")
      f.write(params[:company_introduction].read)
      f.close
      comdocu.save
    end
    comlang.save

    member = Member.new
    member.company_id = company.id
    member.user_id = current_user.id
    member.owner = true
    member.approved = true
    member.save
    
    if params[:company_logo] != nil
      company.logo = params[:company_logo]
      company.save
    end

    params[:client].each do |client_file|
      client = Comclient.new
      client.company_id = company.id
      client.logo = client_file.last
      client.save
    end



    redirect_to :controller => "users",
                :action => "company"

  end

  def confirm
    this_user = current_user
    if !(current_user.email_confirmed)
      this_user.email_confirmed = true
      this_user.save
      this_user.update(user_params)
      User.send_confirmation_email(this_user.id)
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
