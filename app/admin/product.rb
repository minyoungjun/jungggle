ActiveAdmin.register Product do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
 permit_params :user_id, :language_id, :country_id, :marketingtype_id, :company_id, :name, :service_detail, :saved, :minimum_budget, :status
   #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
