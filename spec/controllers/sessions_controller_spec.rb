require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    context 'exists operator' do
      let!(:operator) do
        Fabricate(:operator,
                  identifier: 'unasuke',
                  name: 'うなすけ',
                  password_digest: BCrypt::Password.create('password'))
      end

      it 'should redierct to console' do
        post :create, params: { session: { identifier: 'unasuke', password: 'password' } }
        expect(response).to redirect_to(console_path)
      end
    end

    context 'unexsits operator' do
      it 'should redierct to sign_in' do
        post :create, params: { session: { identifier: 'unasuke', password: 'password' } }
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe '#destroy' do
    context 'logged_in' do
      let!(:operator) do
        Fabricate(:operator,
                  identifier: 'unasuke',
                  name: 'うなすけ',
                  password_digest: BCrypt::Password.create('password'))
      end

      it 'should delete operator from session' do
        post :create, params: { session: { identifier: 'unasuke', password: 'password' } }
        delete :destroy
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
