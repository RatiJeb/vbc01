class User < ApplicationRecord
    has_one :profile

    belongs_to :city

    validates :email, :username, presence: true
    validates :pin, length: {minimum:11, maximum:11}, presence: true, uniqueness: true
end
