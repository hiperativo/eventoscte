# encoding: UTF-8

class Enrollment < ActiveRecord::Base
	attr_accessible :active_cte_client, :address, :category, :cep, :city, 
	:cnpj, :complement, :display_name, :email, :enterprise, :entity, :full_name, 
	:how_did_you_knew_us, :neighbourhood, :number, :occupation, :phone, :profession, 
	:receipt_person, :state, :want_to_receive_newsletter, :event_id, :state_register, 
	:cpf, :receipt_or_nf, :how_exactly_did_you_knew_us, :itau_crypto, :payment_type, :price, :full_price, :group_enrollment

	attr_accessor :how_exactly_did_you_knew_us, :has_discount

	with_options presence: { message: "Este campo é obrigatório" } do |f|
		f.validates :full_name
		f.validates :email
		f.validates :display_name
		f.validates :receipt_person
		f.validates :receipt_or_nf
		f.validates :city
		f.validates :state
		f.validates :address
		f.validates :number
		# f.validates :how_did_you_knew_us
		f.validates :enterprise
		f.validates :profession
		f.validates :occupation
		f.validates :neighbourhood
		f.validates :category
		# f.validates :state_register, presence: true, if: "receipt_person == 'cnpj'"
		f.validates :cnpj, length: {is: 14, message: "Deve ter 14 dígitos"} , if: "receipt_person == 'cnpj'"
		f.validates :cpf, length: {is: 11, message: "Deve ter 11 dígitos"}, if: "receipt_person == 'cpf'"
		
		f.validates :entity, if: "category == 'Associado de entidade apoiadora'"
	end

	validates :email, format: {with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "Email inválido"}
	validates :cep, length: { is: 8, message: "Deve ter 8 dígitos"}

	belongs_to :event

	def has_discount
		!self.full_price.blank?
	end

	before_validation :formatar_cep, :formatar_cpf, :formatar_cnpj, :definir_como_conheceu_cte

	def definir_como_conheceu_cte
		self.how_did_you_knew_us = self.how_exactly_did_you_knew_us unless self.how_exactly_did_you_knew_us.nil?
	end

	def formatar_cep
		apenas_digitos :cep
	end

	def formatar_cpf
		apenas_digitos :cpf
	end

	def formatar_cnpj
		apenas_digitos :cnpj
	end

	def apenas_digitos campo
		self[campo].gsub!(/[^\d]/, "") unless self[campo].nil?
	end

		# @i = ItauShopline.new	

		# @precos = {"Profissional" => 700.0, "Cliente CTE (ativo)" => 630.0, "Associado de entidade apoiadora" => 630.0}
		# @preco = @precos[@enrollment.category]	

		# if @enrollment.receipt_or_nf == "nota_fiscal"
		# 	if @enrollment.receipt_person == "cnpj" and @preco > 666.0
		# 		@IR = 1.5/100
		# 		@ISS = 5.0/100

		# 		formas_de_digitar_sao_paulo_errado = ["saopaulo", "sp"]

		# 		if formas_de_digitar_sao_paulo_errado.include? @enrollment.city.downcase.delete(" ").parameterize
		# 			@preco -= @preco*(@IR+@ISS)
		# 			@enrollment.full_price = @precos[@enrollment.category]	
		# 		else
		# 			@preco -= @preco*@IR
		# 			@enrollment.full_price = @precos[@enrollment.category]	
		# 		end
		# 	end
		# end

		# @enrollment.full_price = number_to_currency unless @enrollment.full_price.blank?
		# @enrollment.price = number_to_currency @preco, unit: "R$", separator: ",", delimiter: "."
		# @enrollment.save
		# @values = {price: @preco, full_price: @enrollment.full_price}
		
		# @itau_crypto = ItauShopline.new.gera_dados({ pedido: @enrollment.id + 800,  
		# 											valor: @preco,
		# 											nome_do_sacado: (@enrollment.receipt_person == "cpf" ? @enrollment.full_name : @enrollment.enterprise),
		# 											codigo_da_inscricao: @enrollment.receipt_person,
		# 											numero_da_inscricao: @enrollment[@enrollment.receipt_person],
		# 											endereco_do_sacado: @enrollment.address,
		# 											bairro_do_sacado: @enrollment.neighbourhood,
		# 											cep_do_sacado: @enrollment.cep,
		# 											cidade_do_sacado: @enrollment.city,
		# 											estado_do_sacado: @enrollment.state,
		# 											data_de_vencimento: (Time.now + 5.days) } )

		# @enrollment.update_attribute(:itau_crypto, @itau_crypto)



	
	# def cpf_ou_cnpj?
		# self.usar_como_cnpj :cnpj
		# self.usar_como_cpf :cpf
	# end

end
