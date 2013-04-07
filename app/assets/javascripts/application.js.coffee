#= require jquery
#= require jquery_ujs
#= require holder
#= require bootstrap
#= require turbolinks

ready = ->
	$(".carousel").carousel
		interval: 2000

	mostrar_campos_condicionais = ->
		$(".enrollment_receipt_person").change ->
			campos_condicionais = $(".enrollment_cpf, .enrollment_cnpj, .enrollment_state_register")
			campos_condicionais.parent().hide()
			campo_selecionado = $(".enrollment_receipt_person :checked").val()

			if campo_selecionado is "cpf"
				$(".enrollment_cpf").parent().slideDown()

			else if campo_selecionado is "cnpj"
				$(".enrollment_cnpj, .enrollment_state_register").parent().slideDown()

		$(".enrollment_receipt_person").change()

		$(".enrollment_how_did_you_knew_us").change ->
			campos_condicionais = $(".enrollment_how_exactly_did_you_knew_us")
			campos_condicionais.parent().hide()
			campo_selecionado = $(".enrollment_how_did_you_knew_us :checked").val()

			console.log $("#enrollment_how_did_exactly_did_you_knew_us").val()
			if campo_selecionado is "Outros" or $("#enrollment_how_did_exactly_did_you_knew_us").val() isnt ""
				$("#enrollment_how_did_you_knew_us_outros").attr "checked", "checked"
				campos_condicionais.parent().slideDown()

		$(".enrollment_how_did_you_knew_us").change()


	$(window).load -> do mostrar_campos_condicionais
	do $(window).load

$(document).ready(ready)
$(document).on('page:load', ready)