class UserMailer < ActionMailer::Base

  default from: 'welcome@wyshme.com'

  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    @url = 'www.wyshme.herokuapp.com'
    mail(to: email_with_name, subject: 'Welcome to WyshMe!')
  end
end
