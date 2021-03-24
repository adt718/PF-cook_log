# frozen_string_literal: true

class StaticPagesController < ApplicationController
  PAGE = 5
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: PAGE)
      @log = Log.new
    end
  end

  def about
  end

  def terms
  end
end
