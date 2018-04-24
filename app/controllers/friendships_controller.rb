class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    case current_user.friend?(@use)
    when 3 

    when 2

    when 1
      @friendship = @user.friend_request.find(friend_id: current_user)
      @friendship.status = 3
      @friendship.save!
      render :json => {status: 3}
    when 0
      @friendship = current_user.friendships.build(friend_id: params[:user_id], status: 2)
      @friendship.save!
      render :json => {status: 2}
    end
    
  end


end
