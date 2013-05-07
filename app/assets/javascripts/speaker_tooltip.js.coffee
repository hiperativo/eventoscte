class SpeakerTooltip
	constructor: (@options) ->
		@hot_element = $(@options.hot_element)
		do @user_interaction

	user_interaction: =>
		@hot_element.click -> false
		@hot_element.hover (e) =>
			link = $(e.currentTarget).attr "href"
			@fetch "/palestrante/#{link}", @show
		, @destroy

	fetch: (url, callback) =>
		$.get url, callback

	show: (data) =>
		@adjust_styling_of $(data).appendTo("body")
		
	adjust_styling_of: (element) =>
		left_pos = $(".programacao").offset()["left"] + $(".programacao").outerWidth()
		element.css 
			left: left_pos + "px"
			top: $(window).scrollTop()+20+"px"

	destroy: =>
		$(".speaker-info").remove()

@SpeakerTooltip = SpeakerTooltip