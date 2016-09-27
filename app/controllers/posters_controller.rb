class PostersController < ApplicationController
  def show
    @poster = Poster.find(params[:id])
    @event = Event.new
  end

  def create
    poster = Poster.find(params[:id])
    poster.events.create(event_params)
    redirect_to user_path(current_user)
  end

  private
  def event_params
    params.permit(:title, :start, :end, :allDay, :description)
  end
end
