FactoryGirl.define do
	factory :enrollment do 
		active_cte_client 				true
		address							"algum lugar"
		category						"Cliente CTE (ativo)"
		cep								"05406-150"
		city 							"São Paulo"
		cnpj							"12345123451234"
		complement
		display_name
		email
		enterprise
		entity
		full_name 
		how_did_you_knew_us
		neighbourhood
		number
		occupation
		phone
		profession
		receipt_person
		state
		want_to_receive_newsletter
		event_id
		state_register
		cpf
		receipt_or_nf
		how_exactly_did_you_knew_us
		itau_crypto
		payment_type
		price
		full_price
	end
		
	end

end