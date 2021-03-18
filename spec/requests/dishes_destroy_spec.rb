# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '料理の削除', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context 'ログインしていて、自分の料理を削除する場合' do
    it '処理が成功し、トップページにリダイレクトすること' do
      login_for_request(user)
      expect do
        delete dish_path(dish)
      end.to change(Dish, :count).by(-1)
      redirect_to user_path(user)
      follow_redirect!
      expect(response).to render_template('static_pages/home')
    end
  end

  context 'ログインしていて、他人の料理を削除する場合' do
    it '処理が失敗し、トップページへリダイレクトすること' do
      login_for_request(other_user)
      expect do
        delete dish_path(dish)
      end.not_to change(Dish, :count)
      expect(response).to have_http_status '302'
      expect(response).to redirect_to root_path
    end
  end

  context 'ログインしていない場合' do
    it 'ログインページへリダイレクトすること' do
      expect do
        delete dish_path(dish)
      end.not_to change(Dish, :count)
      expect(response).to have_http_status '302'
      expect(response).to redirect_to login_path
    end
  end
end
