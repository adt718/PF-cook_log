# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'コメント機能', type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish) }
  let!(:comment) { create(:comment, user_id: user.id, dish: dish) }
  let!(:other_user) { create(:user) }

  context 'コメントの登録' do
    context 'ログインしている場合' do
      before do
        login_for_request(user)
      end

      it '有効な内容のコメントが登録できること' do
        expect do
          post comments_path, params: { dish_id: dish.id,
                                        comment: { content: '最高です！' } }
        end.to change(dish.comments, :count).by(1)
      end

      it '無効な内容のコメントが登録できないこと' do
        expect do
          post comments_path, params: { dish_id: dish.id,
                                        comment: { content: '' } }
        end.not_to change(dish.comments, :count)
      end
    end

    context 'ログインしていない場合' do
      it 'コメントは登録できず、ログインページへリダイレクトすること' do
        expect do
          post comments_path, params: { dish_id: dish.id,
                                        comment: { content: '最高です！' } }
        end.not_to change(dish.comments, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context 'コメントの削除' do
    context 'ログインしている場合' do
      context 'コメントを作成したユーザーである場合' do
        it 'コメントの削除ができること' do
          login_for_request(user)
          expect do
            delete comment_path(comment)
          end.to change(dish.comments, :count).by(-1)
        end
      end
    end

    context 'コメントを作成したユーザーでない場合' do
      it 'コメントの削除はできないこと' do
        login_for_request(other_user)
        expect do
          　 delete comment_path(comment)
          　
        end .not_to change(dish.comments, :count)
      end
    end

    context 'ログインしていない場合' do
      it 'コメントの削除はできず、ログインページへリダイレクトすること' do
        expect do
          delete comment_path(comment)
        end.not_to change(dish.comments, :count)
      end
    end
  end
end
