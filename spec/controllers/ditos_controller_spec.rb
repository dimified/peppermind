require 'spec_helper'

describe DitosController do
  let(:user) { create(:user) }

  describe "GET index" do
    before(:each) do
      sign_in user
    end

    it "assigns all ditos as @ditos" do
      dito = create(:dito)
      get :index
      expect(assigns(:ditos)).to eq([dito])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    before(:each) do
      sign_in user
      @dito = create(:dito) 
    end

    it "assigns the requested dito as @dito" do
      get :show, id: @dito
      expect(assigns(:dito)).to eq(@dito)
    end

    it "renders the show template" do
      get :show, id: @dito
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in user
      @dito = create(:dito)
    end

    it "assigns a new dito as @dito" do
      get :new
      expect(assigns(:dito)).to be_a_new(Dito)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    before(:each) do
      sign_in user
      @dito = create(:dito)
    end

    it "assigns the requested challenge as @challenge" do
      get :edit, id: @dito
      expect(assigns(:dito)).to eq(@dito)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
      @user = @challenge.user
    end

    context "with valid attributes" do
      it "creates a new Dito" do
        expect {
          post :create, challenge_id: @challenge, dito: attributes_for(:dito)
        }.to change(Dito, :count).by(1)
      end

      it "increments user points" do
        

      end
    end
  end
end
