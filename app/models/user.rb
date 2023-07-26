class User < ApplicationRecord
    has_many :articles, dependent: :destroy

    before_save {self.email = email.downcase}
    validates :username, presence: true, 
              length: {minimum: 3, maximum: 25}, 
              uniqueness: {case_sensitive: false}
    validates :email, presence: true ,
              length: { maximum: 103 },
              uniqueness: {case_sensitive: false},
              format: { with: /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/i , message: "Not a valid email address"}
    has_secure_password
end