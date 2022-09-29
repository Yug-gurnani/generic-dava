ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :delivered
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :delivered]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.all.collect { |user| [user.name, user.id] }
      f.input :delivered
      # f.input :catalog, :as => :select, :input_html => {'data-option-dependent' => true, 'data-option-url' => '/products/:catalogs_product_product_id/catalogs', 'data-option-observed' => 'catalogs_product_product_id'}, :collection => (resource.product ? resource.product.category.catalogs.collect {|catalog| [catalog.attr_name, catalog.id]} : [])
    end
    f.actions
  end
  
end
