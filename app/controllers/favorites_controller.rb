# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @favorites = current_user.favorites.paginate(page: params[:page], per_page: 5)
  end

  def create
    @dish = Dish.find(params[:format])
    @user = @dish.user
    current_user.favorite(@dish)
    #    respond_to do |format|
    #     format.html { redirect_to request.referrer || root_url }
    #    format.js
    # end
    # 自分以外のユーザーからお気に入り登録があったときのみ通知を作成
    # if @user != current_user
    #   @user.notifications.create(dish_id: @dish.id, variety: 1,
    #                             from_user_id: current_user.id) # お気に入り登録は通知種別1
    #   @user.update_attribute(:notification, true)
    # end
    @user.create_notification(@dish.id, 1, current_user.id) # お気に入り登録は通知種別1
  end

  def destroy
    @dish = Dish.find(params[:id])
    # @dish = Dish.find(params[:dish_id])
    favorite = Favorite.find_by(user_id: current_user.id, dish_id: @dish.id)
    result = favorite.destroy
    unless request.xhr?
      flash[:success] = 'お気に入りを解除しました。' if result
      redirect_to favorites_path
    end
    # current_user.favorites.find_by(dish_id: @dish.id).destroy
    # respond_to do |format|
    #   format.html { redirect_to request.referrer || root_url }
    #   format.js
  end
end
