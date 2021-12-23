class SendEmailJob < ApplicationJob
  queue_as :user

  rescue_from StandardError do |ex|
    binding.pry
  end

  retry_on ActiveRecord::RecordNotFound

  def perform(*args)
    user = args.first

    UserMailer.with(app_name: 'My Todo App').success_registration_email(user).deliver_now
  end
end
