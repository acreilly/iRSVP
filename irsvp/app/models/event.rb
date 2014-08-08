class Event < ActiveRecord::Base
  attr_accessible :title, :location, :description, :event_start, :event_finish, :user_id, :latitude, :longitude

  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :attendees, class_name: 'User'

  validates :title, :event_start, presence: true
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past

    if (event_start.present? && event_start < Date.today) || (event_finish.present? && event_finish < Date.today)

      errors.add(:event_start, "can't be in the past")
      errors.add(:event_finish, "can't be in the past")
    end
  end
end