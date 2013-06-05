require 'spec_helper'

class SomeHocusPocusClass; end

describe ChallengesController do
  let(:user) { create(:user) }

  describe "GET index" do
    it "assigns all challenge as @challenges" do
      challenge = create(:challenge)
      get :index
      expect(assigns(:challenges)).to eq([challenge])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    before(:each) do
      @challenge = create(:challenge)
    end

    it "assigns the requested challenge as @challenge" do
      get :show, id: @challenge
      expect(assigns(:challenge)).to eq(@challenge)
    end

    it "assigns the inspirations as @inspirations" do
      inspiration = create(:inspiration, challenge: @challenge)
      get :show, id: @challenge
      expect(assigns(:inspirations)).to eq([inspiration])
    end

    it "renders the show template" do
      get :show, id: @challenge
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
    end

    it "assigns a new challenge as @challenge" do
      get :new
      expect(assigns(:challenge)).to be_a_new(Challenge)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
    end

    it "assigns the requested challenge as @challenge" do
      get :edit, id: @challenge
      expect(assigns(:challenge)).to eq(@challenge)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in user
    end

    context "with valid attributes" do
      it "creates a new challenge" do
        expect {
          post :create, challenge: attributes_for(:challenge)
        }.to change(Challenge, :count).by(1)
      end

      it "redirects to the new_challenge_inspiration_path" do
        post :create, challenge: attributes_for(:challenge)
        expect(response).to redirect_to(new_challenge_inspiration_path(1))
      end
    end

    context "with invalid attributes" do
      it "does not create a new challenge" do
        expect{
          post :create, challenge: attributes_for(:invalid_challenge)
        }.to_not change(Challenge, :count)
      end
      
      it "re-renders the :new path" do
        post :create, challenge: attributes_for(:invalid_challenge)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET access_denied" do
    before do
      def controller.index
        raise Mongoid::Errors::DocumentNotFound.new SomeHocusPocusClass, {}
      end
    end

    it "redirects to challenges path" do 
      get :index
      expect(response).to redirect_to(challenges_path)
    end
  end
end