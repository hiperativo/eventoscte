# encoding: UTF-8

class EnrollmentsController < ApplicationController
	include ActionView::Helpers::NumberHelper
	
	def new
		@event = Event.where("date > ?", Time.now).order("date ASC").first
		@enrollment = Enrollment.new
		unless @event.nil? then @enrollment.event_id = @event.id end
	end

	def index
		redirect_to action: "new"
	end

	def create
		@enrollment = Enrollment.new params[:enrollment]

		if @enrollment.valid? 
			@i = ItauShopline.new

			@precos = {"Profissional" => 700.0, "Cliente CTE (ativo)" => 630.0, "Associado de entidade apoiadora" => 630.0}
			@preco = @precos[@enrollment.category]	

			if @enrollment.receipt_or_nf == "nota_fiscal"
				if @enrollment.receipt_person == "cnpj" and @preco > 666.0
					@IR = 1.5/100
					@ISS = 5.0/100

					formas_de_digitar_sao_paulo_errado = ["saopaulo", "sp"]

					if formas_de_digitar_sao_paulo_errado.include? @enrollment.city.downcase.delete(" ").parameterize
						@preco -= @preco*(@IR+@ISS)
						@enrollment.full_price = @precos[@enrollment.category]

					else
						@preco -= @preco*@IR
						@enrollment.full_price = @precos[@enrollment.category]
						
					end
				end
			end

			@enrollment.full_price = number_to_currency(@enrollment.full_price) unless @enrollment.full_price.blank?
			@enrollment.price = number_to_currency @preco, unit: "R$", separator: ",", delimiter: "."
			@enrollment.save
			@values = {price: @preco, full_price: @enrollment.full_price}
			
			@itau_crypto = ItauShopline.new.gera_dados({ pedido: @enrollment.id + 800,  
														valor: @preco,
														nome_do_sacado: (@enrollment.receipt_person == "cpf" ? @enrollment.full_name : @enrollment.enterprise),
														codigo_da_inscricao: @enrollment.receipt_person,
														numero_da_inscricao: @enrollment[@enrollment.receipt_person],
														endereco_do_sacado: @enrollment.address,
														bairro_do_sacado: @enrollment.neighbourhood,
														cep_do_sacado: @enrollment.cep,
														cidade_do_sacado: @enrollment.city,
														estado_do_sacado: @enrollment.state,
														data_de_vencimento: (Time.new(2013, 5, 10, 8)) })
														# data_de_vencimento: (Time.now + 5.days) })

			@enrollment.update_attribute(:itau_crypto, @itau_crypto)

			UserMailer.enrollment_notification(@enrollment).deliver
			UserMailer.user_enrollment_notification(@enrollment).deliver
		else
			render action: "new"
		end
	end
end
