# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    # flash_success  'コメントを追加しました！'
	   #  #flash[:danger] = '空のコメントは投稿できません。'
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @log = Log.new
    end
  end

  def about
  end

  def terms
  end
end
