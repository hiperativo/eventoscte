# encoding: UTF-8

class UserMailer < ActionMailer::Base
	add_template_helper(ApplicationHelper)
	default :from => "#{ENV['EMAIL_LOGIN']}@#{ENV['EMAIL_DOMAIN']}"
	def enrollment_notification(enrollment)
		@enrollment = enrollment
		mail :to => "pedrozath@gmail.com",  
		:bcc => 'julia@nomedarosa.com.br',	
		:subject => "Novo pedido de inscrição de #{@enrollment.display_name}", 
		:reply_to => "eventocte@nomedarosa.com.br"

	end
end