class UserWatchesController < ApplicationController
  def add
    UserWatch.create(user_id: params[:user_id], event_id: params[:id])
    redirect_to new_invitation_path(params[:id])
  end

  def remove
    UserWatch.find_by(user_id: params[:user_id], event_id: params[:id]).destroy
    redirect_to new_invitation_path(params[:id])
  end
end
