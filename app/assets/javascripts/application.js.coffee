#= require jquery
#= require jquery_ujs
#= require holder
#= require bootstrap
#= require turbolinks

ready = ->
	$(".carousel").carousel
		interval: 2000

$(document).ready(ready)
$(document).on('page:load', ready)