class FriendshipsController < ApplicationController
  def index
  end

  def destroy
      friend = User.find(params[:id])
      current_user.friendships.find_by(friend_id: friend.id).destroy
      friend.friendships.find_by(friend_id: current_user.id).destroy
      current_user.friendrequests.find_by(friend_id: friend.id).destroy if current_user.friendrequests.find_by(friend_id: friend.id)
      friend.friendrequests.find_by(friend_id: current_user.id).destroy if friend.friendrequests.find_by(friend_id: current_user.id)
      redirect_to users_path
  end
end
