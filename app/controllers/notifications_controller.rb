class NotificationsController < ApplicationController
  before_action :logged_in_user
  def index
    # current_userに対する通知の集合を取得
    @notifications = current_user.notifications.paginate(page: params[:page], per_page: 5)
    # 一度indexページを開いたら、ユーザーの「通知フラグ」を削除
    current_user.update_attribute(:notification, false)
  end
  def destroy_all
    #通知を全削除
      @notifications = current_user.notifications.destroy_all
      redirect_to notifications_path
  end

end
