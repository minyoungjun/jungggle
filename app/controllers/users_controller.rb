class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :is_login, except: [:email_confirmation, :company_parse]
  before_filter :sns_confirmed, except: [:confirm, :signup_process, :email_confirmation, :company_parse]
  before_filter :is_confirmed, except: [:confirm, :signup_process, :email_confirmation, :finish_signup, :signup_company, :company, :members, :company_parse, :discard_member, :reconfirm ]


  def privilege
    member = Member.find(params[:id])
    if member.company.members.where(:owner => true).first.user_id == current_user.id
      member.owner = true
      member.save

    end
    redirect_to :action => "members"
  end
  def delete_member
    member = Member.find(params[:id])
    if member.company.members.where(:owner => true).first.user_id == current_user.id
      member.delete
    end
    redirect_to :action => "members"
  end

  def approve
    member = Member.find(params[:id])
    if member.company.members.where(:user_id => current_user, :approved => true).count > 0
      if params[:approve].to_i == 1
        member.approved = true
        member.save

        member.user.usernotis.where(:notification_id => 6).each do |usernoti|
          usernoti.delete
        end
      else
        member.delete
        member.user.user_notify(3)
      end
    end
    redirect_to :action => "members"
  end

  def discard_member
    unless  current_user.member.approved
      member_user = current_user.member
      member_user.delete
    end
    redirect_to :action => "company"
  end

  def company_parse
    comlang = Comlang.find(params[:id])
    company = comlang.company
    render :json => ["#{comlang.language.name}","#{company.country.name}","#{company.num_employee}","#{company.website}","#{comlang.introduction}"]

  end
  def members

    @selected = "member"
    if current_user.member == nil
      current_user.user_notify(3)
      redirect_to :action => "company"
    elsif !(current_user.member.approved)
      @company = current_user.member.company
      current_user.user_notify(6)
    else
      @company = current_user.member.company
    end

  end

  def finish_signup
    @em_array = ["1 ~ 10", "10 ~ 50", "50 ~ 100", "100 ~ 500", "500 ~ 1000", "1000+"]
  end

  def email_confirmation
      @user = User.find(params[:id])
    if @user.confirmed_at != nil
      render :text => "Your Email is confirmed already!"
    elsif @user.confirmation_token == params[:token]
      @user.confirmed_at = Time.now
      @user.save
      @user.usernotis.where(:notification_id => 1).each do |usernoti|
        usernoti.is_deleted = true
        usernoti.save
      end
      @user.send_welcome_email
    else
      render :text => "fail"
    end
  end

  def company_update

    if params[:comlang_id].to_i != 0 && !(current_user.is_admin)
      company = Comlang.find(params[:comlang_id]).company
      member = Member.new
      member.company_id = company.id
      member.user_id = current_user.id
      member.approved = false
      member.save
      current_user.usernotis.where(:notification_id => 3).each do |usernoti|
        usernoti.delete
      end
      current_user.user_notify(6)

    else

      if current_user.member != nil && current_user.member.approved
        company = current_user.member.company
      else
        company = Company.new
        current_user.usernotis.where(:notification_id => 3).each do |usernoti|
          usernoti.is_deleted = true
          usernoti.save
        end
      end
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
      
      unless current_user.is_admin 

        if current_user.member == nil
          member = Member.new
        else
          member = current_user.member
        end
        member.company_id = company.id
        member.user_id = current_user.id
        member.owner = true
        member.approved = true
        member.save
      end

    end

    redirect_to :controller => "users",
                :action => "company"
  end

  def company
    @selected = "company"
    if current_user.member == nil

      @has_company = false

    else
      @company = current_user.member.company
      if current_user.member.approved
        @has_company = true
      else
        @has_company = false
        redirect_to :action => "members"

      end
    end
      @em_array = ["1 ~ 10", "10 ~ 50", "50 ~ 100", "100 ~ 500", "500 ~ 1000", "1000+"]
  end

  def signup_company
    if params[:comlang_id].to_i != 0
      company = Comlang.find(params[:comlang_id]).company
      member = Member.new
      member.company_id = company.id
      member.user_id = current_user.id
      member.approved = false
      member.save
      current_user.user_notify(6)
    else
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
      comlang.introduction = params[:company_introduction]
      comlang.save
      if params[:company_introduction_file] != nil
        comdocu = Comdocument.new
        comdocu.comlang_id = comlang.id
        comdocu.saved_name = SecureRandom.hex(10) +"." + params["company_introduction_file"].original_filename.split('.').last
        comdocu.original_name = params["company_introduction_file"].original_filename
        f =  File.open(Rails.root.join("uploads", comdocu.saved_name), "wb")
        f.write(params[:company_introduction_file].read)
        f.close
        comdocu.save
      end

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
      if params[:client] != nil
        params[:client].each do |client_file|
          client = Comclient.new
          client.company_id = company.id
          client.logo = client_file.last
          client.save
        end
      end
    end
    redirect_to :root

  end

  def reconfirm
    if current_user.confirmed_at == nil
      @already = false
      User.send_confirmation_email(current_user.id)
    else
      @already = true
    end
  end

  def confirm
    this_user = current_user
    if !(current_user.email_confirmed)
      if this_user.update(user_params)
        this_user.email_confirmed = true
        this_user.save
        this_user.usernotis.where(:notification_id => 5).each do |usernoti|
          usernoti.is_deleted = true
          usernoti.save
        end
        this_user.user_notify(1)

        User.send_confirmation_email(this_user.id)
        sign_in(this_user, :bypass => true)
      end
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
