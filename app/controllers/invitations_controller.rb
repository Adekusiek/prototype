class InvitationsController < ApplicationController
  def index
    # @goingusers = Event.find(params[:id]).invitations.where(status: "accepted").???
    # @invitedusers = Event.find(params[:id]).invitations.
  end

  def new
      @friends = current_user.friends
  end

  def show
  end

  def create
    Invitation.create(invitation_params)
    redirect_to invitations_path(params[:id])
  end

  def accept
    invitation = current_user.invitations.find_by(event_id: params[:id], status: "pending")
    invitation.update(status: "accepted")
    redirect_to root_path
  end

  def decline
    invitation = current_user.invitations.find_by(event_id: params[:id], status: "pending")
    invitation.update(status: "declined")
    redirect_to root_path
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
