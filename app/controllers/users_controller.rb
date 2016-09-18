class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @going_events = @user.going_events
    @pending_events = @user.pending_events
    @pending_friends = @user.pending_friends
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to user_path(current_user)
  end

  private
  def update_params
    params.require(:user).permit(:family_name, :first_name, :avatar)
  end

end
