# encoding: UTF-8

class EnrollmentsController < ApplicationController
	def new
		@event = Event.where("date > ?", Time.now).order("date ASC").first
		@enrollment = Enrollment.new
		unless @event.nil? then @enrollment.event_id = @event.id end
	end

	def create
		@enrollment = Enrollment.new params[:enrollment]

		if @enrollment.valid? 
			@i = ItauShopline.new	

			precos = {"cheio" => 700.0, "especial" => 630.00}
			@preco = precos[@enrollment.category]	

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
			@itau_crypto = ItauShopline.new.gera_dados(@enrollment.id , @preco, @enrollment.full_name, @enrollment.city, @enrollment.state, nil, '')
			UserMailer.enrollment_notification(@enrollment).deliver

		else
			render action: "new"
		end

	end
end
