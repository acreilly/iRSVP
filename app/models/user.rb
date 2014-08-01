require 'bcrypt'

class User < ActiveRecord::Base

  has_many :relationships
  has_many :followers, through: :relationships

  has_many :followee_relationships, :foreign_key => "follower_id", :class_name => "Relationship"
  has_many :followings, through: :followee_relationships, source: :user

  has_many :events
  has_and_belongs_to_many :attended_events, class_name: 'Event'


  # validates :first_name, :last_name, :birthday, :email, :username, :password, presence: true
  # validates :email, :username, uniqueness: true
  # validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: "only allow valid email addresses"}
  validate :user_age_validation

  def user_age_validation
    if birthday + 18.years > Date.today
      errors.add(:birthday, "under 18")
    end
  end

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
