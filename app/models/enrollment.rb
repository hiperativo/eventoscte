# encoding: UTF-8

class Enrollment < ActiveRecord::Base
	attr_accessible :active_cte_client, :address, :category, :cep, :city, 
	:cnpj, :complement, :display_name, :email, :enterprise, :entity, :full_name, 
	:how_did_you_knew_us, :neighbourhood, :number, :occupation, :phone, :profession, 
	:receipt_person, :state, :want_to_receive_newsletter, :event_id, :state_register, :cpf, :receipt_or_nf

	belongs_to :event
	
	# usar_como_cnpj :cnpj
	validates :full_name, presence: { message: "Preencha seu nome completo"}
	validates :cpf, presence: { message: "Preencha seu nome completo"}

end
