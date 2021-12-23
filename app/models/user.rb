class User < ApplicationRecord
  after_commit :send_welcome_mail, on: :create
  has_one :profile

  belongs_to :city

  validates :email, :username, presence: true
  validates :pin, length: {minimum:11, maximum:11}, presence: true, uniqueness: true

  def send_welcome_mail
    SendEmailJob.set(wait: 1.minute).perform_later(self)
  end
end
