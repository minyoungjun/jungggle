class HomeController < ApplicationController
  autocomplete :company, :name, :full => true
  
  def account_company_profile

    @selected = "company"
    if current_user.member != nil
      @company = current_user.member.company
    end

  end
  def account_member
    @selected = "member"

  end
  def company_update

    if params[:first_time] == "on" && Company.where(:name => params[:company_name]).count == 0
        company = Company.new
        company.name = params[:company_name]
        company.location = params[:located_in]
        company.num_employee = params[:number_of_employee]
        company.website = params[:website]
        company.introduction = params[:company_introduction]
        if params[:upload] != nil
          company.logo = params[:upload]
        end
        company.save
    elsif params[:first_time] != "on" && Company.where(:name => params[:company_name]).count == 0
      render :text => "wow"
    else
      company = Company.where(:name => params[:company_name]).first
    end

    if current_user.member == nil
      member = Member.new
    else
      member = current_user.member
    end
    member.user_id = current_user.id
    member.company_id = company.id
    member.save

    redirect_to :back

  end

  def main
  end

  def who
  end

  def aboutus
  end

  def contact
  end

  def faq
  end

  def how
  end
 private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:logo_id, :logo, :logo_file_name)
    end
end
