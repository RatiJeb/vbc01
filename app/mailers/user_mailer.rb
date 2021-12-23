class UserMailer < ApplicationMailer
  default from: 'todoapp@example.com'
  
  def success_registration_email(user)
    @app_name = params[:app_name] || 'Todo App'
    @user = user
    @profile = user.profile

    attachments['filename.png'] = File.read(File.join(Rails.root, 'public/imagine.png'))
    
    mail(subject: 'Welcome', to: email_address_with_name(@user.email, @profile.full_name))
  end
end
