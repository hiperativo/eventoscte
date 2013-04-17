#= require jquery
#= require jquery_ujs
#= require holder
#= require bootstrap
#= require turbolinks
# require head
ready = ->
	
	$(".carousel").carousel interval: 7000
	$(".logo-carousel").carousel interval: 1000

	change_state = (state) ->
		remove_all_states = -> $("html").removeAttr "data-state"
		set_state = -> $("html").attr "data-state", state 

		switch state
			when "normal" then do remove_all_states
			else do set_state

	# mostrar_palestrante = (target) ->
	# 	request = null
	# 	busy_countdown = null
	# 	target.hover ->
	# 		element = $(this)
	# 		console.log "/palestrante/#{target.attr "href"}"
	# 		busy_countdown = setTimeout -> 
	# 			change_state "busy"
	# 		, 400

	# 		request = $.get "/palestrante/#{target.attr "href"}", (data, element)->
	# 			clearTimeout busy_countdown
	# 			change_state "normal"
	# 			$("body").append(data)
	# 			$(".speaker-info").css 
	# 				left: target.offset()["left"]
	# 				top: target.offset()["top"]

	# 			console.log target.offset()["left"], target.offset()["top"]

	# 	, ->
	# 		clearTimeout busy_countdown
	# 		change_state "normal"
	# 		if request? then request.abort()
	# 		$(".speaker-info").remove()
	# 	false

	mostrar_palestrante $(".talk a")

	mostrar_campos_condicionais = ->
		$(".enrollment_category").change ->
			campos_condicionais = $(".enrollment_entity")
			campos_condicionais.parent().hide()
			campo_selecionado = $(".enrollment_category :checked").val()

			if campo_selecionado is "Associado de entidade apoiadora"
				$(".enrollment_entity").parent().slideDown()

		$(".enrollment_receipt_person").change ->
			campos_condicionais = $(".enrollment_cpf, .enrollment_cnpj, .enrollment_state_register")
			campos_condicionais.parent().hide()
			campo_selecionado = $(".enrollment_receipt_person :checked").val()

			if campo_selecionado is "cpf"
				$(".enrollment_cpf").parent().slideDown()

			else if campo_selecionado is "cnpj"
				$(".enrollment_cnpj, .enrollment_state_register").parent().slideDown()


		$(".enrollment_how_did_you_knew_us").change ->
			campos_condicionais = $(".enrollment_how_exactly_did_you_knew_us")
			campos_condicionais.parent().hide()
			campo_selecionado = $(".enrollment_how_did_you_knew_us :checked").val()

			# console.log $("#enrollment_how_exactly_did_you_knew_us").val()
			# if $("#enrollment_how_did_you_knew_us_outros").val() is "Outros" or $("#enrollment_how_exactly_did_you_knew_us").val() == ""
			# 	$("#enrollment_how_did_you_knew_us_outros").attr "checked", "checked"
			# 	campos_condicionais.parent().slideDown()

		$(".enrollment_receipt_person").change()
		$(".enrollment_how_did_you_knew_us").change()
		$(".enrollment_category").change()


	$(window).load -> do mostrar_campos_condicionais
	do $(window).load

$(document).ready(ready)
$(document).on('page:load', ready)
