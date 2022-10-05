# frozen_string_literal: true

module Api
  module V1
    # Order Resource
    class OrderResource < JSONAPI::Resource
      caching
      attributes :user_id, :delivered

      paginator :paged
    end
  end
end
