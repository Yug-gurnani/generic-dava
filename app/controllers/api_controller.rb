class ApiController < ActionController::API
  include ApiRenderConcern
  before_action :authenticate_user!, except: :login
  before_action :check_verified_user, except: %i[login verify_user]

  private

  def check_verified_user
    api_render(401, { message: 'User Not Verified!' }) unless verified_user?
  end

  def admin_auth
    render_unauthorized unless current_user.admin?
  end

  def verified_user?
    current_user.verified?
  end
end
