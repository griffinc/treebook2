require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:griffin).profile_name

  	assert !user.save
	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
	 user = User.new(first_name: 'Griffin', last_name: 'Cole', email: 'gdcole@vt.edu')
   user.password = user.password_confirmation = 'password'

 	 user.profile_name = "My Profile with Spaces"

	 assert !user.save
	 assert !user.errors[:profile_name].empty?
	 assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

 test "a user can have a correctly formatted profile name" do
   user = User.new(first_name: 'Griffin', last_name: 'Cole', email: 'gdcole@vt.edu')
   user.password = user.password_confirmation = 'password'

   user.profile_name = 'griffincole1'
   assert user.valid?
 end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:griffin).friends
    end
  end 


  test "that creating friendshups on a user works" do
      users(:griffin).friends << users(:michelle)
      users(:griffin).friends.reload
      assert users(:griffin).friends.include?(users(:michelle))
  end 
end
