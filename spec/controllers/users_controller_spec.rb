require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the show view" do
      get :show, id: user
      expect(response).to render_template :show
    end
  end
end