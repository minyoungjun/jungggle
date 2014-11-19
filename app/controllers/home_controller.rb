class HomeController < ApplicationController
  autocomplete :company, :name, :full => true
  before_action :is_login, only: [:account_company_profile, :account_member, :company_update]
  
  def account_company_profile

    @selected = "company"
    if current_user.member != nil
      @company = current_user.member.company
    end

  end
  def account_member
    @selected = "member"

  end

  def main
    @main = true
    @countries = Country.able_list

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
