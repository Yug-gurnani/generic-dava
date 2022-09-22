# frozen_string_literal: true

Rails.application.routes.draw do
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
          post :update_products_in_cart
          get :cart_details
        end
      end
      jsonapi_resources :products, only: %i[show index create update]
    end
  end
end
