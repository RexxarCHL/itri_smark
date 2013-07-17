# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('form').first().submit ->
		username = $('#user_username').val()
		passwd = $('#user_passwd').val()
		regex = /[A-Za-z0-9]+/

		result = regex.test(username) and regex.test(passwd)
		if result isnt true
			alert "Only alphabets and numbers are permitted!"
		result
