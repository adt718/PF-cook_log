# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'お料理登録', type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_dish.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }
  let!(:other_user) { create(:user) }
  context 'ログインしているユーザーの場合' do
    before do
      login_for_request(user)
      get new_dish_path
    end

    it 'レスポンスが正常に表示されること' do
      login_for_request(user)
      get new_dish_path
      expect(response).to have_http_status '200'
      expect(response).to render_template('dishes/new')
    end
    it 'レスポンスが正常に表示されること' do
      expect(response).to have_http_status '200'
      expect(response).to render_template('dishes/show')
    end
    context '材料有りの料理登録' do
      it '有効な料理データで登録できること' do
        expect do
          post dishes_path, params: { dish: { name: 'イカの塩焼き',
                                              description: '冬に食べたくなる、身体が温まる料理です',
                                              portion: 1.5,
                                              tips: 'ピリッと辛めに味付けするのがオススメ',
                                              reference: 'https://cookpad.com/recipe/2798655',
                                              required_time: 30,
                                              popularity: 5,
                                              picture: picture,
                                              ingredients_attributes: [
                                                name: 'じゃがいも',
                                                quantity: '2個'
                                              ] } }
        end.to change(Dish, :count).by(1)
        redirect_to Dish.first
        follow_redirect!
        expect(response).to render_template('dishes/show')
      end

      it '材料のデータも同時に増えること' do
        expect do
          post dishes_path, params: { dish: { name: 'イカの塩焼き',
                                              ingredients_attributes: [
                                                name: 'じゃがいも',
                                                quantity: '2個'
                                              ] } }
        end.to change(Ingredient, :count).by(1)
      end

      it '無効な料理データでは登録できないこと' do
        expect do
          post dishes_path, params: { dish: { name: '',
                                              description: '冬に食べたくなる、身体が温まる料理です',
                                              portion: 1.5,
                                              tips: 'ピリッと辛めに味付けするのがオススメ',
                                              reference: 'https://cookpad.com/recipe/2798655',
                                              required_time: 30,
                                              popularity: 5,
                                              picture: picture,
                                              ingredients_attributes: [
                                                name: 'じゃがいも',
                                                quantity: '2個'
                                              ] } }
        end.not_to change(Dish, :count)
        expect(response).to render_template('dishes/new')
      end
    end

    context '材料無しの料理登録' do
      it '正常に完了すること' do
        expect do
          post dishes_path, params: { dish: { name: 'イカの塩焼き' } }
        end.to change(Dish, :count).by(1)
      end

      it '材料のデータは増えないこと' do
        expect do
          post dishes_path, params: { dish: { name: 'イカの塩焼き' } }
        end.not_to change(Ingredient, :count)
      end

      context 'ログインしていないユーザーの場合' do
        it 'ログイン画面にリダイレクトすること' do
          get new_dish_path
          expect(response).to have_http_status '302'
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end
