class PasswordMailer < ActionMailer::Base
  default from: "atencion@simapro.com"

  def send_password(user, password)
    @user = user
    @password = password
    @host = 'http://simapro.com'
    mail(to: user.email, subject: 'Registro de Usuario - Simapro')
  end
end
