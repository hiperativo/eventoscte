# encoding: UTF-8

class UserMailer < ActionMailer::Base
	add_template_helper(ApplicationHelper)
	default :from => "inscricao_eventos@cte.com.br"
	# default :from => "#{ENV['EMAIL_LOGIN']}@#{ENV['EMAIL_DOMAIN']}"
	def enrollment_notification(enrollment)
		@enrollment = enrollment
		mail :to => ENV['EMAIL_RECEIVER'],  
		:bcc => 'julia@nomedarosa.com.br',	
		:subject => "Novo pedido de inscrição de #{@enrollment.display_name}", 
		:reply_to => @enrollment.email
	end

	def user_enrollment_notification(enrollment)
		@enrollment = enrollment
		mail :to => @enrollment.email,  
		:bcc => 'julia@nomedarosa.com.br',	
		:cc => 'pedrozath@gmail.com',	
		:subject => "Pré-inscrição no evento #{@enrollment.event.title}", 
		:reply_to => "inscricao_eventos@cte.com.br"

	end
end
