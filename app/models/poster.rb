class Poster < ActiveRecord::Base
  has_many :posterevents, dependent: :destroy
  has_many :events, through: :posterevents
end
