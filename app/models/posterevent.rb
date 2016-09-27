class Posterevent < ActiveRecord::Base
  belongs_to :poster
  belongs_to :event
end
