class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    can [:manage], Friendship, :user_id => user.friendships.collect(&:friend_id) << user.id
    can [:index, :show], User
    can [:index, :create], Article
    can [:show], Article, :user_id => user.friendships.collect(&:friend_id) << user.id
    can [:update, :destroy], Article, :user_id => user.id
  end
end

