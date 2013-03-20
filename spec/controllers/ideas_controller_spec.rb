require 'spec_helper'

describe IdeasController do
  let(:user) { create(:user) }

  describe "GET index" do
    it "assigns all ideas as @ideas" do
      idea = create(:idea)
      get :index
      expect(assigns(:ideas)).to eq [idea]
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    it "assigns the requested idea as @idea" do
      idea = create(:idea)
      get :show, id: idea
      assigns(:idea).should eq(idea)
    end

    it "renders the :show view" do
      idea = create(:idea)
      get :show, id: idea
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    it "assigns a new idea as @idea" do
      get :new
      expect(assigns(:idea)).to be_a_new(Idea)
    end

    it "renders the :new template" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    it "assigns the requested idea as @idea" do
      idea = create(:idea)
      get :edit, id: idea
      expect(assigns(:idea)).to eq(idea)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in user
    end

    context "with valid params" do
      it "creates a new Idea" do
        expect {
          post :create, idea: attributes_for(:idea)
        }.to change(Idea, :count).by(1)
        expect(:idea)
      end

      it "assigns a newly created idea as @idea" do
        post :create, idea: attributes_for(:idea)
        expect(assigns(:idea)).to be_a(Idea)
      end

      it "redirects to the Idea Steps Path" do
        post :create, idea: attributes_for(:idea)
        expect(response).to redirect_to(idea_steps_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new idea" do
        expect{
          post :create, idea: attributes_for(:invalid_idea)
        }.to_not change(Idea, :count)
      end
      
      it "re-renders the :new template" do 
        post :create, idea: attributes_for(:invalid_idea) 
        expect(response).to render_template :new
      end 
    end
  end

  describe "PUT update" do
    before(:each) do
      @idea = create(:idea)
      sign_in user
    end

    it "locates the requested @idea" do
      put :update, id: @idea, idea: attributes_for(:idea)
      expect(assigns(:idea)).to eq(@idea)
    end

    context "with valid attributes" do
      it "updates the requested idea" do
        put :update, id: @idea, idea: attributes_for(:idea, title: "New title for idea")
        @idea.reload
        expect(@idea.title).to eq("New title for idea") 
      end

      it "redirects to the updated idea" do
        put :update, id: @idea, idea: attributes_for(:idea)
        expect(response).to redirect_to @idea
      end
    end

    context "with invalid attributes" do
      it "does not update the requested idea" do
        put :update, id: @idea, user: attributes_for(:idea, title: "New title for idea", summary: nil)
        @idea.reload
        expect(@idea.title).to_not eq("New title for idea")
      end

      it "re-renders the :edit template" do
        put :update, id: @idea, idea: attributes_for(:invalid_idea)
        expect(response).to render_template :edit
      end
    end
  end

  describe'DELETE destroy' do 
    before :each do
      @idea = create(:idea)
      sign_in user
    end

    it "destroys the requested idea" do 
      expect{
        delete :destroy, id: @idea
      }.to change(Idea, :count).by(-1)
    end
    
    it "redirects to ideas#index" do 
      delete :destroy, id: @idea 
      expect(response).to redirect_to ideas_url
    end
  end
end