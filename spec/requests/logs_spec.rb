# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ログ機能', type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let!(:log) { create(:log, dish: dish) }
  let!(:other_user) { create(:user) }

  context 'ログ登録' do
    context 'ログインしている場合' do
      context '料理を作成したユーザーである場合' do
        before do
          login_for_request(user)
        end

        it '有効なログが登録できること' do
          expect do
            post logs_path, params: { dish_id: dish.id,
                                      log: { content: '良い味付けで作れた' } }
          end.to change(dish.logs, :count).by(1)
          expect(response).to redirect_to dish_path(dish)
        end

        it '無効なログが登録できないこと' do
          expect do
            post logs_path, params: { dish_id: nil,
                                      log: { content: '良い味付けで作れた' } }
          end.not_to change(dish.logs, :count)
        end
      end

      context '料理を作成したユーザーでない場合' do
        it 'ログ登録できず、トップページへリダイレクトすること' do
          login_for_request(other_user)
          expect do
            post logs_path, params: { dish_id: dish.id,
                                      log: { content: '良い味付けで作れた' } }
          end.not_to change(dish.logs, :count)
          expect(response).to redirect_to root_path
        end
        context 'ログインしていない場合' do
          it 'ログ登録できず、ログインページへリダイレクトすること' do
            expect do
              post logs_path, params: { dish_id: dish.id,
                                        log: { content: '良い味付けで作れた' } }
            end.not_to change(dish.logs, :count)
            expect(response).to redirect_to login_path
          end
        end
      end

      context 'ログ削除' do
        context 'ログインしている場合' do
          context 'ログを作成したユーザーである場合' do
            it 'ログ削除ができること' do
              login_for_request(user)
              expect do
                delete log_path(log)
              end.to change(dish.logs, :count).by(-1)
            end
          end

          context 'ログを作成したユーザーでない場合' do
            it 'ログ削除はできず、料理詳細ページへリダイレクトすること' do
              login_for_request(other_user)
              expect do
                delete log_path(log)
              end.not_to change(dish.logs, :count)
              expect(response).to redirect_to dish_path(dish)
            end
          end

          context 'ログインしていない場合' do
            it 'ログ削除はできず、ログインページへリダイレクトすること' do
              expect do
                delete log_path(log)
              end.not_to change(dish.logs, :count)
              expect(response).to redirect_to login_path
            end
          end
        end
      end
    end
  end
end
