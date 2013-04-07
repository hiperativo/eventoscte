# encoding: UTF-8

class EnrollmentsController < ApplicationController
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

			if @enrollment.receipt_or_nf == "Nota Fiscal"
				if @enrollment.receipt_person == "Empresa" and @preco > 666.0
					@IR = 1.5/100
					@ISS = 5.0/100

					if @enrollment.city == "São Paulo"
						@preco -= @preco*(@IR+@ISS)
					else
						@preco -= @preco*@ISS
					end

				end
			end

			@enrollment.save
			
			@itau_crypto = ItauShopline.new.gera_dados({ pedido: @enrollment.id + 800,  
														valor: @preco,
														nome_do_sacado: @enrollment.full_name,
														codigo_da_inscricao: @enrollment.receipt_person,
														numero_da_inscricao: @enrollment[@enrollment.receipt_person],
														endereco_do_sacado: @enrollment.address,
														bairro_do_sacado: @enrollment.neighbourhood,
														cep_do_sacado: @enrollment.cep,
														cidade_do_sacado: @enrollment.city,
														estado_do_sacado: @enrollment.state,
														data_de_vencimento: (Time.now + 5.days) } )


			@enrollment.update_attribute(:itau_crypto, @itau_crypto)
			# UserMailer.enrollment_notification(@enrollment).deliver

		else
			render action: "new"
		end

	end
end
