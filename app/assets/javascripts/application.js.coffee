#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#= require holder
#= require bootstrap
#= require turbolinks
#= require gallery
#= require swfobject
#= # require speaker_tooltip

ready = ->

	$(".sort-projects").css("background-color: red")

	window["counting"] = []
	$("form.live-update").keyup ->
		form = $(this).closest("form")
		clearTimeout window["counting"][form.data().id]

		window["counting"][form.data().id] = setTimeout =>
			$.post form.attr("action"), form.serialize()
			$(this).effect "pulsate"
		, 1000

	$(".carousel").carousel 		interval: 7000
	$(".logo-carousel").carousel 	interval: 1000

	if $(".media-gallery").length
		new Gallery
			gallery_links: 	".media-gallery a"
			main_media: 	".main-media"
			media_wrapper: 	".conteudo"

	$(".sortable").sortable
		update: (e, ui) -> 
			obj = $(this)
			$.post window.location.pathname + "/sort", obj.sortable("serialize"), -> 
				obj.effect "highlight"



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

		$(".enrollment_receipt_person").change()
		$(".enrollment_how_did_you_knew_us").change()
		$(".enrollment_category").change()


	$(window).load -> 
		do mostrar_campos_condicionais

	do $(window).load

$(document).ready(ready)
$(document).on('page:load', ready)
