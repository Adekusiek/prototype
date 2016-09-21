class InvitationsController < ApplicationController


  def new
      @friends = current_user.friends
      event = Event.find(params[:id])
      gon.url = new_invitation_path(event)  #For javascript
      @events = []
      colorchoice = ['#6EB7DB', '#CE579B', '#FFEE55', '#DA6272', '#8B90BE', '#B5C76B', '#88BCCB', '#DECA98', '#4DAE82', '#E3E3E3']
      temp = 0
      event.watched_users.each do |watched_user|
        watched_user.going_events.each do |going_event|
          going_event.color = colorchoice[temp]
          @events << going_event
        end
        temp += 1
      end
      @events << event
  end

  def create
    Invitation.create(invitation_params)
    UserWatch.find_by(user_id: params[:user_id], event_id: params[:id]).destroy if UserWatch.exists?(user_id: params[:user_id], event_id: params[:id])
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
