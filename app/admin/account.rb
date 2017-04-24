ActiveAdmin.register Account do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  #
  index do
    selectable_column
    id_column
    column :card_brand
    column :card_last4
    column :card_exp_month
    column :card_exp_year
    column :expires_at
    column :created_at
    column :updated_at
  end

end
