class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
 #before_action :authenticate_user!
 protect_from_forgery with: :exception
 include SessionsHelper
 protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
