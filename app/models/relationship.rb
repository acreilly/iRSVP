class Relationship < ActiveRecord::Base
  belongs_to :user
  # belongs_to :event
  belongs_to :follower, :class_name => 'User'
  # belongs_to :event_follower, :class_name => 'Event'
end