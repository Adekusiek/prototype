class Event < ActiveRecord::Base
#Association
  #for invitation model
  has_many :invitations, dependent: :destroy
  has_many :going_invitations, ->{where status: "accepted"}, class_name: "Invitation"
  has_many :pending_invitations, ->{where status: "pending"},  class_name: "Invitation"
  has_many :going_users,  through: :going_invitations, source: :user
  has_many :pending_users, through: :pending_invitations, source: :user

  #for friend schedule observation model
  has_many :user_watches, dependent: :destroy
  has_many :watched_users, through: :user_watches, source: :user

  #for comments on event model
  has_many :comments, ->{ order("created_at ASC")}, dependent: :destroy

  #for poster model
  # this part needs to be modified. Give event model colomun "status" to give different event kind
  belongs_to :posterevent, dependent: :destroy
  delegate :poster, to: :posterevent, allow_nil: true
end
