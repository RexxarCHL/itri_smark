# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('a').click (event)->
		event.stopPropagation()
		event.preventDefault()
	$('a.search').click (event)->
		event.stopPropagation()
		event.preventDefault()
		$(this).siblings('div').toggle()
		$('input').select()
		$('td.plate').parent().removeClass('content-hidden')
	$('#reset').click (event)->
		inputs = $('div>input')
		inputs.val ''
		inputs.trigger 'blur'
	$('#search-plate').bind 'blur', (event)->
		val = $(this).val().toUpperCase()
		if val isnt ""
			$('td.plate').parent().addClass('content-hidden')
			plate = 'td.plate.' + val
			$(plate).parent().removeClass('content-hidden')
		$(this).parent().hide()
