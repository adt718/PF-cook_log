# frozen_string_literal: true

class DishesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: %i[edit update]

  def index
    @log = Log.new
    @dishes = Dish.all.paginate(page: params[:page], per_page: 5)
    # CSV出力時のファイル名指定
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string,
                  filename: "みんなの料理一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv"
      end
    end
  end

  def show
    @dish = Dish.find(params[:id])
    @comment = Comment.new
    @log = Log.new
  end

  def new
    @dish = Dish.new
    @dish.ingredients.build
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      flash[:success] = '料理情報が更新されました！'
      redirect_to @dish
    else
      render 'edit'
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    if current_user.admin? || current_user?(@dish.user)
      @dish.destroy
      flash[:success] = '料理が削除されました'
      redirect_to request.referrer == user_url(@dish.user) ? user_url(@dish.user) : root_url
    else
      flash[:danger] = '他人の料理は削除できません'
      redirect_to root_url
    end
  end

  def create
    @dish = current_user.dishes.build(dish_params)
    if @dish.save
      flash[:success] = '料理が登録されました！'
      Log.create(dish_id: @dish.id, content: @dish.cook_memo)
      # current_user.list(@dish))
      redirect_to dish_path(@dish.id)
    else
      render 'dishes/new'
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :description, :portion, :tips,
                                 :reference, :required_time, :popularity, :cook_memo, :picture,
                                 ingredients_attributes: %i[id name quantity])
  end

  def correct_user
    # 現在のユーザーが更新対象の料理を保有しているかどうか確認
    @dish = current_user.dishes.find_by(id: params[:id])
    redirect_to root_url if @dish.nil?
  end
end
