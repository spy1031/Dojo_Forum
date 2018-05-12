class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def update
    @user = User.find(params[:id])
    @friendship = current_user.friend_invites.find_by(user_id: @user.id)
    @friendship.status = params[:status]
    @friendship.save!

    render :json => {:user_id => @user.id}
  end

  def create
    @user = User.find(params[:user_id])
    case current_user.friend_state(@user)
    when 1 #user already send invite
      @friendship = @user.friend_requests.find_by(friend_id: current_user)
      @friendship.status = 3
      @friendship.save!
      render :json => {status: 3}
    when 0
      @friendship = current_user.friendships.build(friend_id: params[:user_id], status: 2)
      @friendship.save!
      render :json => {:status => 2, :user_id => params[:user_id]}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @friendship = current_user.friend_requests.find_by(friend_id: @user.id)
    @friendship.destroy

    render :json => {:status => 0, :user_id => params[:id] }
  end

end
