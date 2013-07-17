# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('#alert_type').change (event)->
		type = $('#alert_type').val()
		if type is "4" then $('tbody>tr').removeClass "content-hidden"
		else
			klassTag = ".alert_type_" + type
			$('tbody>tr.entry').addClass "content-hidden"
			$(klassTag).removeClass "content-hidden"
