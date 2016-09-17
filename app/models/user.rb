class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #  , :confirmable

  validates :nickname, uniqueness: true

# Association
  has_many :friendships
  has_many :friends, through: :friendships,
            after_add: :create_complement_friendship
  has_many :friendrequests
  has_many :pending_friends, through: :friendrequests, source: :friend

# paperclip configuration
  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>"}
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]


# Class methods
  def name
      "#{family_name} #{first_name}"
  end

private
  def create_complement_friendship(friend)
    friend.friends << self  unless friend.friends.include?(self)
  end
end
