class InvitationsController < ApplicationController


  def new
      @friends = current_user.friends
      event = Event.find(params[:id])
      @events = []
      event.watched_users.each do |watched_user|
        @events += watched_user.going_events
      end
      gon.event_id = event.id  #For javascript
  end

  def create
    Invitation.create(invitation_params)
    redirect_to new_invitation_path(params[:id])
  end

  def accept
    invitation = current_user.invitations.find_by(event_id: params[:id], status: "pending")
    invitation.update(status: "accepted")
    redirect_to event_path(params[:id])
  end

  def decline
    invitation = current_user.invitations.find_by(event_id: params[:id], status: "pending")
    invitation.update(status: "declined")
    redirect_to event_path(params[:id])
  end

  def destroy
    invitation = current_user.invitations.find_by(event_id: params[:id], status: "accepted")
    invitation.destroy
    redirect_to root_path
  end

  private
  def invitation_params
    params.permit(:user_id).merge(event_id: params[:id])
  end
end
