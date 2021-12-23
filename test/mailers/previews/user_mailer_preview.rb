# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def success_registration_email
    app_name = 'Mailer Preview'
    user = User.first

    UserMailer.with(app_name: app_name).success_registration_email(user).deliver_now
  end
end
