# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#payment_notifications_index').dataTable
		bFilter: true
		bPaginate: true
		bJQueryUI: true
		aoColumnDefs: [
		  {
		     bSortable: false,
		     aTargets: [ -1,-2,-3]
		  }
		]
