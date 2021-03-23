# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists.paginate(page: params[:page], per_page: 5)
    @log = Log.new
    dish_ids = []
    @lists.each do |list|
      dish_ids.append(list.dish_id)
    # dish_ids = @lists.map do |list| list.dish_id
    end
    @dishes = Dish.where(id: dish_ids)
  end

  def create
    @dish = Dish.find(params[:dish_id])
    @user = @dish.user
    current_user.list(@dish)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @dish = list.dish
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
