FactoryGirl.define do
	factory :enrollment do 
		full_name 						"Fulano de Tal"
		active_cte_client 				true
		address							"algum lugar"
		category						"Cliente CTE (ativo)"
		cep								"05406-150"
		city 							"São Paulo"
		cnpj							"12345123451234"
		complement						"some apartment"
		display_name					"Fulano"
		email							"Fulano@algumacoisa.com.br"
		enterprise						"alguma empresa"
		entity							"entidade"
		how_did_you_knew_us 			"amigos"
		neighbourhood					"um bairro aí"
		number							"25"
		occupation						"designer"
		phone							"11 9999-9999"
		profession						"desenvolvedor"
		receipt_person					"cnpj"
		state 							"sp"
		want_to_receive_newsletter 		true
		event_id 						1
		state_register 					"sp"
		cpf 							"34666014870"
		receipt_or_nf 					:nf
		how_exactly_did_you_knew_us 	"blabla"
		itau_crypto 					nil
		payment_type 					"bank"
		price 							700
		full_price 						nil
	end
end