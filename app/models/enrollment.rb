class Enrollment < ActiveRecord::Base
  attr_accessible :active_cte_client, :address, :category, :cep, :city, :cnpj, :complement, :display_name, :email, :enterprise, :entity, :full_name, :how_did_you_knew_us, :neighbourhood, :number, :occupation, :phone, :profession, :receipt_person, :state, :want_to_receive_newsletter
  validates :full_name, presence: true

  attr_accessor :cpf

end
