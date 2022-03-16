# User model
class User < ApplicationRecord
  has_many :temperatures, dependent: :destroy

  validates :email,
            format:     { with: /\A(\S+)@(.+)\.(\S+)\z/ },
            uniqueness: { case_sensitive: false },
            length:     { minimum: 4 }
end
