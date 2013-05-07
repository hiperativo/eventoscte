# Gallery List 1.0 by Pedro Maciel
# requires jQuery

class Gallery
	constructor: (@options) ->
		do @select_elements
		do @make_clickable
		do @keyboard_interactions
		do @browser_history

	select_elements: ->
		@main_media = $(@options.main_media)
		@gallery_links = $(@options.gallery_links)
		@media_wrapper = $(@options.media_wrapper)

	make_clickable: ->
		@gallery_links.on "click", @select_new_media

	select_new_media: (event) =>
		link = $(event.currentTarget).attr("href")
		@fetch_content(@change_content, link)
		false

	fetch_content: (callback, link) =>
		$.get link, (data) =>
			@change_content(data)
			@push_state
				html: data
				page_title: "Eventos CTE"
				link: link

	change_content: (data) =>
		@main_media.animate {opacity: 0}, 100, "swing", =>
			@media_wrapper.html(data)
			if @main_media.is("img")
				@main_media.css(opacity: 0).load -> $(this).animate({opacity: 1}, 100)
			
			@select_elements()
			@make_clickable()

	push_state: (options) =>
		window.history.pushState options, "", options.link

	keyboard_interactions: =>
		$("html").keyup (e) ->
			media_to_go = switch e.which
				when 37 then $(".media-gallery .active").prev()
				when 39 then $(".media-gallery .active").next()
				else null 
			unless media_to_go is null
				media_to_go.click() 
			false

	browser_history: =>
		window.onpopstate = (e) =>
			unless e.state is null
				@change_content(e.state.html)

# Make the class public
@Gallery = Gallery