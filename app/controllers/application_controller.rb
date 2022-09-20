# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include ApiRenderConcern
  before_action :authenticate_user!

  private

  def admin_auth
    render_unauthorized unless current_user.admin?
  end

  def verified_user?
    current_user.verified?
  end
end
