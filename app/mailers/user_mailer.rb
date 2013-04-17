# encoding: UTF-8

class UserMailer < ActionMailer::Base
	add_template_helper(ApplicationHelper)
	default :from => "inscricao_eventos@cte.com.br"
	# default :from => "#{ENV['EMAIL_LOGIN']}@#{ENV['EMAIL_DOMAIN']}"

	def info enrollment
		{"Nome" => 								enrollment.full_name,  
		"E-mail" => 							enrollment.email,  
		"Data" => 								enrollment.created_at.strftime("%d/%m/%Y - %H:%M:%S"),  
		"Crachá" => 							enrollment.display_name,  
		"Profissão" => 							enrollment.profession,  
		"Cargo" => 								enrollment.occupation,  
		"Empresa" => 							enrollment.enterprise,  
		"CNPJ" => 								enrollment.cnpj,  
		"Inscrição Estadual" => 				enrollment.state_register,  
		"Endereço" => 							enrollment.address,
		"Número" => 							enrollment.number,
		"Bairro" => 							enrollment.neighbourhood,  
		"Cidade" => 							enrollment.city,  
		"CEP" => 								enrollment.cep,  
		"Estado" => 							enrollment.state,  
		"Telefone" => 							enrollment.phone, 
		"Recibo ou nota fiscal" => 				enrollment.receipt_or_nf,  
		"Emissão" => 							enrollment.receipt_person,  
		"CPF" => 								enrollment.cpf, 
		"Categoria" => 							enrollment.category,  
		"Entidade" => 							enrollment.entity,  
		"Deseja receber os informativos" => 	enrollment.want_to_receive_newsletter == true ? "Sim" : "Não",  
		"Como tomou conhecimento do evento?" => enrollment.how_did_you_knew_us} 
	end
	
	def values enrollment
		{full_price: enrollment.full_price, price: enrollment.price}
	end

	def enrollment_notification(enrollment)
		@enrollment = enrollment
		@values = values enrollment
		@info = info enrollment
		mail :to => ENV['EMAIL_RECEIVER'],  
		:bcc => 'julia@nomedarosa.com.br',	
		:subject => "Inscrição — #{@enrollment.event.title}", 
		:reply_to => @enrollment.email
	end

	def user_enrollment_notification(enrollment)
		@enrollment = enrollment
		@values = values enrollment
		@info = info enrollment
		mail :to => @enrollment.email,  
		:bcc => 'julia@nomedarosa.com.br',	
		:subject => "Pré-inscrição no evento #{@enrollment.event.title}", 
		:reply_to => "inscricao_eventos@cte.com.br"

	end
end
