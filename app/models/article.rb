class Article < ActiveRecord::Base
    include Visible
    has_many :comments, dependent: :destroy

    validates :title, presence: true, length: {minimum: 3 , maximum:50}
    validates :description, presence: true, length: {minimum: 10 , maximum:300}
    
end