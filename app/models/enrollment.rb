# encoding: UTF-8

class Enrollment < ActiveRecord::Base
	attr_accessible :active_cte_client, :address, :category, :cep, :city, 
	:cnpj, :complement, :display_name, :email, :enterprise, :entity, :full_name, 
	:how_did_you_knew_us, :neighbourhood, :number, :occupation, :phone, :profession, 
	:receipt_person, :state, :want_to_receive_newsletter, :event_id, :state_register, 
	:cpf, :receipt_or_nf, :how_exactly_did_you_knew_us, :itau_crypto, :payment_type, :price, :full_price

	attr_accessor :how_exactly_did_you_knew_us

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

	with_options presence: { message: "Este campo é obrigatório" } do |f|
		f.validates :full_name
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
	end

	validates :email, format: {with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "Email inválido"}
	validates :cep, length: { is: 8, message: "Deve ter 8 dígitos"}



	belongs_to :event
	
	# def cpf_ou_cnpj?
		# self.usar_como_cnpj :cnpj
		# self.usar_como_cpf :cpf
	# end

end
