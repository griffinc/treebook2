require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a friendship works without raising an exception" do
		assert_nothing_raised do
			UserFriendship.create user: users(:griffin), friend: users(:michelle)
		end
	end

	test "that creating a friendship based on a user id and friend id works" do
		UserFriendship.create user: users(:griffin), friend: users(:michelle)
		assert users(:griffin).friends.include?(users(:michelle))
	end
end


