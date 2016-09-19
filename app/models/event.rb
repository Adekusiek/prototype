class Event < ActiveRecord::Base
  has_many :invitations, dependent: :destroy
  has_many :going_invitations, ->{where status: "accepted"}, class_name: "Invitation"
  has_many :pending_invitations, ->{where status: "pending"},  class_name: "Invitation"
  has_many :going_users,  through: :going_invitations, source: :user
  has_many :pending_users, through: :pending_invitations, source: :user

end
