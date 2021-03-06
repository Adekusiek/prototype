class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  validates :nickname, uniqueness: true

# Association
  #for friendship model
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships,
            after_add: :create_complement_friendship
  has_many :friendrequests, dependent: :destroy
  has_many :pending_friendrequests, ->{where status: "pending"}, class_name: "Friendrequest", foreign_key: "friend_id"
  has_many :pending_friends, through: :pending_friendrequests, source: :user

  #for event invitation model
  has_many :invitations, dependent: :destroy
  has_many :going_invitations, ->{where status: "accepted"}, class_name: "Invitation"
  has_many :pending_invitations, ->{where status: "pending"}, class_name: "Invitation"
  has_many :going_events, through: :going_invitations, source: :event
  has_many :pending_events, through: :pending_invitations, source: :event

  #for friend schedule obervation model
  has_many :user_watches, dependent: :destroy

  #for comments on event model
  has_many :comments, dependent: :destroy

# paperclip configuration
  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>"}
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]


# Class methods
  def name
      "#{family_name} #{first_name}"
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end



private
  def create_complement_friendship(friend)
    friend.friends << self  unless friend.friends.include?(self)
  end
end
