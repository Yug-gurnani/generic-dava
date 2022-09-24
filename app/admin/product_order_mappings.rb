ActiveAdmin.register ProductOrderMapping do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :order_id, :product_id, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_id, :product_id, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs do
      f.input :order_id, as: :select, collection: Order.all.collect { |order| ["#{order.user.first_name} #{order.user.last_name} Order_id: #{order.id}", order.id] }
      f.input :product_id, as: :select, collection: Product.all.collect { |product| [product.name, product.id] }
      f.input :quantity
      # f.input :catalog, :as => :select, :input_html => {'data-option-dependent' => true, 'data-option-url' => '/products/:catalogs_product_product_id/catalogs', 'data-option-observed' => 'catalogs_product_product_id'}, :collection => (resource.product ? resource.product.category.catalogs.collect {|catalog| [catalog.attr_name, catalog.id]} : [])
    end
    f.actions
  end
end
