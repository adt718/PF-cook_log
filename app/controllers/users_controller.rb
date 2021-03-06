# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index show edit update destroy]
  before_action :correct_user,   only: %i[edit update]
  before_action :logged_in_user, only: %i[index show edit update destroy
                                          following followers]

  PAGE = 5
  def show
    @user = User.find(params[:id])
    @dishes = @user.dishes.paginate(page: params[:page], per_page: PAGE)
    @log = Log.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'クックログへようこそ！'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールが更新されました！'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    # 管理者ユーザーの場合
    if current_user.admin?
      @user.destroy
      flash[:success] = 'ユーザーの削除に成功しました'
      redirect_to users_url
    # 管理者ユーザーではないが、自分のアカウントの場合
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = '自分のアカウントを削除しました'
      redirect_to root_url
    else
      flash[:danger] = '他人のアカウントは削除できません'
      redirect_to root_url
    end
    @user.destroy
    flash[:success] = 'アカウントを削除しました'
    return redirect_to(root_url) unless logged_in?
  end

  def following
    @title = 'フォロー中'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  # ユーザー新規作成時に許可する属性
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = 'このページへはアクセスできません'
      redirect_to(root_url)
    end
  end
end
