class User < ActiveRecord::Base
    has_many :meals
    has_secure_password
    validates_presence_of :password
    validates :username,  uniqueness: true
    validates :email, uniqueness: true
    validates :username, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

    def slug
        self.username.gsub(" ", "-")    
    end

    def self.find_by_slug(slug)
        username = slug.gsub("-", " ")
        self.find_by(username: username)
    end
end
