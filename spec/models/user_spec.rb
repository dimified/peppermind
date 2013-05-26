require 'spec_helper'

describe User do
	before(:each) do
		@user = create(:user)
	end

	it "has a valid factory" do
	  expect(@user).to be_valid
	end

	it "is invalid with a duplicate email address" do
		expect(build(:user, email: @user.email)).to_not be_valid
	end

	it "is invalid with a duplicate display name" do
		expect(build(:user, display_name: @user.display_name)).to_not be_valid
	end

	it "is invalid when password is less than 8 characters" do
		expect(build(:user, password: "gravity")).to_not be_valid
	end

  it "increments user points" do
    expect {
      @user.add_points
    }.to change(@user, :points).by(1)
  end

  it "decrements user points" do
    expect {
      @user.remove_points
    }.to change(@user, :points).by(-1)
  end

  it "decrements only until 0 points" do
  	@user.remove_points(points: 10)
    expect(@user.points).to eq(0)
  end

  it "changes the level of user from rookie to seeker" do
		user = create(:user, points: 100)
		assert_equal(user.level, :rookie)
		expect {
			user.update_user_level
		}.to change(user, :level).from(:rookie).to(:seeker)
	end

  it "changes the level of user from seeker to rookie" do
		user = create(:user, points: 99)
		user.level = :seeker
		assert_equal(user.level, :seeker)
		assert_equal(user.points, 99)
		expect {
			user.update_user_level
		}.to change(user, :level).from(:seeker).to(:rookie)
	end

	it "changes the level of user from seeker to inspirer" do
		user = create(:user, points: 200)
		user.level = :seeker
		assert_equal(user.level, :seeker)
		assert_equal(user.points, 200)
		expect {
			user.update_user_level
		}.to change(user, :level).from(:seeker).to(:inspirer)
	end

  it "changes the level of user from inspirer to seeker" do
		user = create(:user, points: 199)
		user.level = :inspirer
		assert_equal(user.level, :inspirer)
		assert_equal(user.points, 199)
		expect {
			user.update_user_level
		}.to change(user, :level).from(:inspirer).to(:seeker)
	end

	it "changes the level of user from inspirer to solver" do
		user = create(:user, points: 300)
		user.level = :inspirer
		assert_equal(user.level, :inspirer)
		assert_equal(user.points, 300)
		expect {
			user.update_user_level
		}.to change(user, :level).from(:inspirer).to(:solver)
	end

  it "changes the level of user from solver to inspirer" do
		user = create(:user, points: 299)
		user.level = :solver
		assert_equal(user.level, :solver)
		assert_equal(user.points, 299)
		expect {
			user.update_user_level
		}.to change(user, :level).from(:solver).to(:inspirer)
	end
end

