class Friendrequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_save :created_friendship

def accept
  update_attributes(:status  => 'accepted')
end

def decline
  update_attributes(:status  => 'declined')
end

private
  def created_friendship
    self.user.friends << self.friend  if status_changed? && status == 'accepted'
  end

end
