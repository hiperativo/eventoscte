# encoding: UTF-8

module ApplicationHelper
	def markdown string
		Maruku.new(string).to_html.html_safe
	end

	def sim_ou_nao boolean
		boolean ? "Sim" : "Não"
	end

	def admin?
		current_admin_user
		false
	end
end
