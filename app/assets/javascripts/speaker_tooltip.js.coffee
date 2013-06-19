class SpeakerTooltip
	constructor: (@options) ->
		@hot_element = $(@options.hot_element).not(@options.skip)
		do @user_interaction

	user_interaction: =>
		@hot_element.click -> window.location.href += "/palestrantes"
		@hot_element.hover (e) =>
			link = $(e.currentTarget).attr "href"
			@fetch "/palestrante/#{link}", @show
		, @destroy

	fetch: (url, callback) =>
		@request = $.get url, callback

	show: (data) =>
		@adjust_styling_of $(data).appendTo("body")
		
	adjust_styling_of: (element) =>
		left_pos = $(".programacao").offset()["left"] + $(".programacao").outerWidth()
		element.css 
			left: left_pos + "px"
			top: $(window).scrollTop()+20+"px"

	destroy: =>
		@request?.abort()
		$(".speaker-info").remove()

@SpeakerTooltip = SpeakerTooltip