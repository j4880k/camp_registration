# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
		$('#reservation_carts_index').dataTable
			bFilter: false
			bPaginate: false
			bJQueryUI: true
			aoColumnDefs: [
			  {
			     bSortable: false,
			     aTargets: [ -1 ]
			  }
			]