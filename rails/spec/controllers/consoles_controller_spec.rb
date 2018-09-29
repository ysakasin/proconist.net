require 'rails_helper'

RSpec.describe ConsolesController, type: :controller do
  describe '#index' do
    context 'not logged in' do
      it 'should redirect to sign_in' do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end
