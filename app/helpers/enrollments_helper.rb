module EnrollmentsHelper
	def inscricoes_abertas?
		ENV['INSCRICOES_ABERTAS'] == "ON"
	end
end
