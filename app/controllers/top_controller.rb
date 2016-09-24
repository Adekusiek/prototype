class TopController < ApplicationController

  def index
    @rposters = Poster.order(created_at: :DESC).limit(6)
    @likedposters = Poster.order(created_at: :ASC).limit(6)
  end
end
