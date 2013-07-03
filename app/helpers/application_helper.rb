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

	def get_slides talk

		if talk.slides_local_file.blank?
			if talk.slides.url.blank?
				nil
			else
				talk.slides.url
			end
		else
			asset_path talk.slides_local_file
		end
	end
end
