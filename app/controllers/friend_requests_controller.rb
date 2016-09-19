class FriendRequestsController < ApplicationController


def create
    current_user.friendrequests.create(status: "pending", friend_id: params[:friend_id])
    redirect_to :back
end

def update
    friendrequest = Friendrequest.find_by(user_id: params[:id], friend_id: current_user.id)
    friendrequest.accept
    redirect_to :back
end

def destroy
    friendrequest = Friendrequest.find_by(user_id: params[:id], friend_id: current_user.id)
    if friendrequest.status == "pending"
      friendrequest.decline
    else
      friendrequest.destroy
    end
    redirect_to :back
end

end
