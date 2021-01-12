require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET show" do
    subject { user }

    it "does not allow unauthenticated requests" do
      get :show, :params => {  id: 1 , format: :json }
      expect(response.status).to eq(401)
    end

    it "does not allow unauthorized requests" do
      add_authentication_token
      get :show, :params => {  id: user.id + 1, format: :json }
      expect(response.status).to eq(404)
    end

    it "allows authenticated and unauthorized requests" do
      add_authentication_token
      get :show, :params => {  id: user.id , format: :json }
      expect(response.status).to eq(200)
    end
  end
end

def add_authentication_token
  token = "Bearer " + user.auth_token
  request.headers['Authorization'] = token
end
