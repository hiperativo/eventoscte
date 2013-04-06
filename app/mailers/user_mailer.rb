# encoding: UTF-8

class UserMailer < ActionMailer::Base
  default :from => "#{ENV['EMAIL_LOGIN']}@#{ENV['EMAIL_DOMAIN']}"
  def enrollment_notification(enrollment)
  	@enrollment = enrollment
  	mail :to => ENV['EMAIL_RECEIVER'], :bcc => 'julia@nomedarosa.com.br',  
  	:subject => "Novo pedido de inscrição do #{@enrollment.display_name}", :reply_to => "eventocte@nomedarosa.com.br",  

  end
end