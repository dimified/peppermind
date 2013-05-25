require 'spec_helper'

describe DitosController do
  let(:user) { create(:user) }

  describe "POST create" do
    before(:each) do
      sign_in user
      @challenge = create(:challenge)
      @stubbed_user = create(:user)
    end

    context "when current_user is not @challenge.user" do
      it "creates a new Dito" do
        expect {
          controller.stub!(:current_user).and_return(@stubbed_user)
          assert_not_equal controller.current_user, @challenge.user
          post :create, challenge_id: @challenge, dito: attributes_for(:dito)
        }.to change(Dito, :count).by(1)
      end
    end

    context "when current_user is @challenge.user" do
      it "does not create a new Dito" do
        expect {
          controller.stub!(:current_user).and_return(@challenge.user)
          assert_equal controller.current_user, @challenge.user
          post :create, challenge_id: @challenge, dito: attributes_for(:dito)
        }.to_not change(Dito, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      sign_in user
      @user = create(:user)
      @challenge = create(:challenge)
      @dito = create(:dito, user: @user, challenge: @challenge)
    end

    it "assigns the requested challenge as @challenge" do
      delete :destroy, challenge_id: @challenge, id: @dito
      expect(assigns(:challenge)).to eq(@challenge)
    end

    it "destroys the requested dito" do
      expect{
        controller.stub!(:current_user).and_return(@user)
        assert_not_equal controller.current_user, @challenge.user
        delete :destroy, challenge_id: @challenge, id: @dito
      }.to change(Dito, :count).by(-1)
    end
  end
end
