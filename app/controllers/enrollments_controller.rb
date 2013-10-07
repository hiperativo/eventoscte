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
			unless params["add_another"].blank?
				@enrollment.group_enrollment = true
				session[:first_enrollment] = @enrollment
				session[:first_enrollment].created_at = Time.now

				@second_enrollment = @enrollment.dup
				@second_enrollment.full_name = ""
				@second_enrollment.display_name = ""


				render action: "new"
			else

				@i = ItauShopline.new
				
				if @enrollment.group_enrollment

					@precos = {
						"Profissional" => 1400.0,
						"Cliente CTE (ativo)" => 1260.0,
						"Associado de entidade apoiadora" => 1260.0
					}

				else

					@precos = {
						"Profissional" => 700.0,
						"Cliente CTE (ativo)" => 630.0,
						"Associado de entidade apoiadora" => 630.0
					}

				end

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

				@id_offset = ENV["RAILS_ENV"] == "development" ? 900000 : 2000

				@itau_crypto = ItauShopline.new.gera_dados({ pedido: @enrollment.id + @id_offset,  
															valor: @preco,
															observacao: 3,
															nome_do_sacado: (@enrollment.receipt_person == "cpf" ? @enrollment.full_name : @enrollment.enterprise),
															codigo_da_inscricao: @enrollment.receipt_person,
															numero_da_inscricao: @enrollment[@enrollment.receipt_person],
															endereco_do_sacado: @enrollment.address,
															bairro_do_sacado: @enrollment.neighbourhood,
															cep_do_sacado: @enrollment.cep,
															cidade_do_sacado: @enrollment.city,
															estado_do_sacado: @enrollment.state,
															obs_adicional1: "Sr. Caixa, não receber após o vencimento",
															# data_de_vencimento: Time.new(2013, 10, 20, 8) })
															data_de_vencimento: Time.now + 5.days })

				@enrollment.update_attribute(:itau_crypto, @itau_crypto)

				if @enrollment.group_enrollment
					# enviar email para o primeiro usuario cadastrado, caso tenha sido feito duas
					UserMailer.user_enrollment_notification(session[:first_enrollment], @enrollment).deliver 

					# enviar email para cte com os 2 usuarios juntos no mesmo
					UserMailer.enrollment_notification(session[:first_enrollment], @enrollment).deliver 

				else
					# enviar email para cte, caso tenha sido feita apenas uma inscricao
					UserMailer.enrollment_notification(@enrollment).deliver
					
					# enviar email para o usuario
					UserMailer.user_enrollment_notification(@enrollment).deliver
				end

				# enviar email para o ultimo usuario cadastrado
			end
		else
			render action: "new"
		end
	end
end
