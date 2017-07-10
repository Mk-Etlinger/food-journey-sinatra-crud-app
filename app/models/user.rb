class User < ActiveRecord::Base
  has_many :meals
  has_secure_password
  validates_presence_of :password
  validates :username,  uniqueness: true
  validates :email, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z]+\z/,
                                 message: 'only allows letters' }
  validates :password, length: { in: 6..20 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
