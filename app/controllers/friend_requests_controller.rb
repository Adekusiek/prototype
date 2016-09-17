class FriendRequestsController < ApplicationController


def create
    current_user.friendrequests.create(status: "pending", friend_id: params[:friend_id])
    redirect_to users_path
end

def update
    friendrequest = Friendrequest.find_by(user_id: params[:id], friend_id: current_user.id)
    friendrequest.accept
    redirect_to users_path
end

def destroy
    friendrequest = Friendrequest.find_by(user_id: params[:id], friend_id: current_user.id)
    friendrequest.decline
    redirect_to users_path
end

end
