require 'spec_helper'


def last_email 
	ActionMailer::Base.deliveries.last
end


describe "enrollments", type: :feature do	
	it "enrolls as Professional" do
		ActionMailer::Base.deliveries = []
		user = FactoryGirl.build :enrollment

		visit "/inscricoes/nova"
		fill_in "Nome completo", with: user.full_name
		fill_in "Nome para crachá", with: user.display_name
		fill_in "E-mail", with: "pedrozath@gmail.com"
		fill_in "Empresa", with: user.enterprise
		fill_in "Profissão", with: user.profession
		fill_in "Cargo", with: user.occupation
		select user.category, from: "enrollment[category]"
		choose "Nota Fiscal"
		choose "Empresa"
		fill_in "Informe seu CNPJ", with: "00000111112222"
		fill_in "CEP", with: "04506150"
		fill_in "Cidade", with: "São Paulo"
		select "SP", from: "Estado"
		fill_in "Endereço", with: "Rua da Banana"
		fill_in "Nº", with: 1896
		fill_in "Complemento", with: "Apt. 25"
		fill_in "Bairro", with: "Mangas"
		fill_in "Telefone", with: 97993777

		choose "Boleto bancário"
		choose "Site CTE"
		choose "Sim"
		
		click_button "Fazer Inscrição"
		puts page.body
	end
end