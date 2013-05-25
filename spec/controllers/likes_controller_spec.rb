require 'spec_helper'

describe LikesController do
  let(:user) { create(:user) }

  describe "POST create" do
    before(:each) do
      sign_in user
      @inspiration = create(:inspiration)
      @stubbed_user = create(:user)
    end

    context "when current_user is not @inspiration.user" do
      it "creates a new Like" do
        expect {
          controller.stub!(:current_user).and_return(@stubbed_user)
          assert_not_equal controller.current_user, @inspiration.user
          post :create, inspiration_id: @inspiration, like: attributes_for(:like)
        }.to change(Like, :count).by(1)
      end
    end

    context "when current_user is @inspiration.user" do
      it "does not create a new Like" do
        expect {
          controller.stub!(:current_user).and_return(@inspiration.user)
          assert_equal controller.current_user, @inspiration.user
          post :create, inspiration_id: @inspiration, like: attributes_for(:like)
        }.to_not change(Like, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      sign_in user
      @user = create(:user)
      @challenge = create(:challenge)
      @inspiration = create(:inspiration)
      @like = create(:like, user: @user, inspiration: @inspiration)
    end

    it "assigns the requested inspiration as @inspiration" do
      controller.stub!(:current_user).and_return(@user)
      assert_not_equal @user, @inspiration.user
      delete :destroy, inspiration_id: @inspiration, id: @like
      expect(assigns(:inspiration)).to eq(@inspiration)
    end

    it "destroys the requested like" do
      expect{
        controller.stub!(:current_user).and_return(@user)
        assert_not_equal controller.current_user, @inspiration.user
        delete :destroy, inspiration_id: @inspiration, id: @like
      }.to change(Like, :count).by(-1)
    end
  end
end
