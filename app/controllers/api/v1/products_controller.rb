# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      include JSONAPI::ActsAsResourceController
      before_action :admin_auth, only: %i[create update]

      def recommendation
        render_success({ products: Product.where(id: Product.all.ids.sample(4)) })
      end
    end
  end
end
