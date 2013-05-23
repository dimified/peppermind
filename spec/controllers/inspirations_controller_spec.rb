require 'spec_helper'

describe InspirationsController do
  let(:user) { create(:user) }

  describe "GET index" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
    end

    it "assigns all inspirations as @inspirations" do
      inspiration = create(:inspiration)
      get :index, challenge_id: @challenge
      expect(assigns(:inspirations)).to eq([inspiration])
    end

    it "renders the index template" do
      get :index, challenge_id: @challenge
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
      @inspiration = create(:inspiration) 
    end

    it "assigns the requested inspiration as @inspiration" do
      get :show, challenge_id: @challenge, id: @inspiration
      expect(assigns(:inspiration)).to eq(@inspiration)
    end

    it "renders the show template" do
      get :show, challenge_id: @challenge, id: @inspiration
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
    end

    it "assigns a new inspiration as @inspiration" do
      get :new, challenge_id: @challenge
      expect(assigns(:inspiration)).to be_a_new(Inspiration)
    end

    it "renders the new template" do
      get :new, challenge_id: @challenge
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
      @inspiration = create(:inspiration)
  end

    it "assigns the requested inspiration as @inspiration" do
      get :edit, challenge_id: @challenge, id: @inspiration
      expect(assigns(:inspiration)).to eq(@inspiration)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
    end

    context "with valid attributes" do
      it "creates a new Inspiration" do
        expect {
          post :create, challenge_id: @challenge, inspiration: attributes_for(:inspiration)
        }.to change(Inspiration, :count).by(1)
      end

      it "redirects to the Challenge Inspiration Path" do
        post :create, challenge_id: @challenge, inspiration: attributes_for(:inspiration)
        expect(response).to redirect_to(challenge_inspiration_path(@challenge, 1))
      end
    end

    context "with invalid attributes" do
      it "does not create a new inspiration" do
        expect{
          post :create, challenge_id: @challenge, inspiration: attributes_for(:invalid_inspiration)
        }.to_not change(Inspiration, :count)
      end
      
      it "re-renders the new template" do 
        post :create, challenge_id: @challenge, inspiration: attributes_for(:invalid_inspiration)
        expect(response).to render_template :new
      end 
    end
  end

  # describe "PUT update" do
  #   before(:each) do
  #     sign_in user
  #     @challenge = create(:challenge)
  #     @inspiration = create(:inspiration)
  #   end

  #   it "locates the requested @inspiration" do
  #     put :update, challenge_id: @challenge, id: @inspiration, inspiration: attributes_for(:inspiration)
  #     expect(assigns(:inspiration)).to eq(@inspiration)
  #   end

  #   context "with valid attributes" do
  #     it "updates the requested inspiration" do
  #       put :update, challenge_id: @challenge, id: @inspiration, inspiration: attributes_for(:inspiration, description: "New description")
  #       @inspiration.reload
  #       expect(@inspiration.description).to eq("New description")
  #     end

  #     it "redirects to the Challenge Inspiration Path" do
  #       put :update, challenge_id: @challenge, id: @inspiration, inspiration: attributes_for(:inspiration)
  #       expect(response).to redirect_to challenge_inspiration_path(@challenge, 1)
  #     end
  #   end

  #   context "with invalid attributes" do
  #     it "does not update the requested inspiration" do
  #       put :update, challenge_id: @challenge, id: @inspiration, inspiration: attributes_for(:inspiration, description: "New description", like: nil)
  #       @inspiration.reload
  #       expect(@inspiration.description).to_not eq("New description")
  #     end
  #   end
  # end

  # describe'DELETE destroy' do 
  #   before :each do
  #     sign_in user
  #     @challenge = create(:challenge)
  #     @inspiration = create(:inspiration)
  #   end

  #   it "destroys the requested inspiration" do
  #     expect{
  #       delete :destroy, challenge_id: @challenge, id: @inspiration
  #     }.to change(Inspiration, :count).by(-1)
  #   end
    
  #   it "redirects to Challenge Path" do
  #     delete :destroy, challenge_id: @challenge, id: @inspiration
  #     expect(response).to redirect_to challenge_path(@challenge)
  #   end
  # end
end