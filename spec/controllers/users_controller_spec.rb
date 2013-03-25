require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }

  before(:each) do
    controller.stub(:authenticate_user!).and_return true
  end

  describe "GET index" do
    it "assigns all users as @users" do
      get :index
      expect(assigns(:users)).to eq [user]
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    before(:each) do
      sign_in user
    end

    it "assigns the requested user as @user" do
      get :show
      expect(assigns(:user)).to eq(user)
    end

    it "renders the :show view" do
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, id: user
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to(User.last)
      end
    end
  end

  describe "PUT update" do
    before :each do
      @user = create(:user)
    end

    it "locates the requested @user" do
      put :update, id: @user, user: attributes_for(:user)
      expect(assigns(:user)).to eq(@user)
    end

    context "with valid attributes" do
      it "updates the requested user" do
        put :update, id: @user, user: attributes_for(:user, display_name: "isaacnewton")
        @user.reload
        expect(@user.display_name).to eq("isaacnewton") 
      end

      it "redirects to the updated user" do
        put :update, id: @user, user: attributes_for(:user)
        expect(response).to redirect_to @user
      end
    end

    context "with invalid params" do
      it "does not update the requested user" do
        put :update, id: @user, user: attributes_for(:user, display_name: "isaacnewton", email: nil)
        @user.reload
        expect(@user.display_name).to_not eq("isaacnewton")
      end

      it "re-renders the :edit template" do
        put :update, id: @user, user: attributes_for(:invalid_user)
        expect(response).to render_template :edit
      end
    end
  end

  describe'DELETE destroy' do 
    before :each do
      @user = create(:user)
    end

    it "destroys the requested user" do 
      expect{
        delete :destroy, id: @user
      }.to change(User, :count).by(-1)
    end
    
    it "redirects to users#index" do
      delete :destroy, id: @user 
      expect(response).to redirect_to users_url
    end
  end
end