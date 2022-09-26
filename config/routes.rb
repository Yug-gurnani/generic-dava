# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }
  namespace :api do
    namespace :v1 do
      jsonapi_resources :users do
        collection do
          post :verify_user
          get :cart_details
          post :update_products_in_cart
        end
      end
      jsonapi_resources :products, only: %i[show index create update]
      jsonapi_resources :orders
    end
  end
end
