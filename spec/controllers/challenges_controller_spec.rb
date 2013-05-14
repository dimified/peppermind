require 'spec_helper'

describe ChallengesController do
  let(:user) { create(:user) }

  describe "GET index" do
    it "assigns all challenges as @challenges" do
      challenge = create(:challenge)
      get :index
      expect(assigns(:challenges)).to eq [challenge]
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

    it "assigns the requested challenge as @challenge" do
      challenge = create(:challenge)
      get :show, id: challenge
      assigns(:challenge).should eq(challenge)
    end

    it "renders the :show view" do
      challenge = create(:challenge)
      get :show, id: challenge
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in user
    end

    it "assigns a new challenge as @challenge" do
      get :new
      expect(assigns(:challenge)).to be_a_new(Challenge)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    before(:each) do
      sign_in user
    end

    it "assigns the requested challenge as @challenge" do
      challenge = create(:challenge)
      get :edit, id: challenge
      expect(assigns(:challenge)).to eq(challenge)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in user
    end

    context "with valid attributes" do
      it "creates a new Challenge" do
        expect {
          post :create, challenge: attributes_for(:challenge)
        }.to change(Challenge, :count).by(1)
        expect(:challenge)
      end

      it "assigns a newly created challenge as @challenge" do
        post :create, challenge: attributes_for(:challenge)
        expect(assigns(:challenge)).to be_a(Challenge)
      end

      it "redirects to the Challenge Steps Path" do
        post :create, challenge: attributes_for(:challenge)
        expect(response).to redirect_to(idea_steps_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new challenge" do
        expect{
          post :create, challenge: attributes_for(:invalid_challenge)
        }.to_not change(Challenge, :count)
      end
      
      it "re-renders the :new template" do 
        post :create, challenge: attributes_for(:invalid_challenge)
        expect(response).to render_template :new
      end 
    end
  end

  describe "PUT update" do
    before(:each) do
      @challenge = create(:challenge)
      sign_in user
    end

    it "locates the requested @challenge" do
      put :update, id: @challenge, challenge: attributes_for(:challenge)
      expect(assigns(:challenge)).to eq(@challenge)
    end

    context "with valid attributes" do
      it "updates the requested challenge" do
        put :update, id: @challenge, challenge: attributes_for(:challenge, title: "New title for challenge")
        @challenge.reload
        expect(@challenge.title).to eq("New title for challenge")
      end

      it "redirects to the updated challenge" do
        put :update, id: @challenge, challenge: attributes_for(:challenge)
        expect(response).to redirect_to @challenge
      end
    end

    context "with invalid attributes" do
      it "does not update the requested challenge" do
        put :update, id: @challenge, user: attributes_for(:challenge, title: "New title for challenge", description: nil)
        @challenge.reload
        expect(@challenge.title).to_not eq("New title for challenge")
      end

      it "re-renders the :edit template" do
        put :update, id: @challenge, challenge: attributes_for(:invalid_challenge)
        expect(response).to render_template :edit
      end
    end
  end

  describe'DELETE destroy' do 
    before :each do
      @challenge = create(:challenge)
      sign_in user
    end

    it "destroys the requested challenge" do
      expect{
        delete :destroy, id: @challenge
      }.to change(Challenge, :count).by(-1)
    end
    
    it "redirects to challenges#index" do
      delete :destroy, id: @challenge
      expect(response).to redirect_to challenges_url
    end
  end
end