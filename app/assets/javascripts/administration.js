$(document).ready(function() {
	$( "#testMessage" ).click(function() {
		var d = "message=" + $( "#message" ).val();
		$.post( "/administration/send_test_message", d, function( data ) {
			  alert( data );
		});
		
	});
	
});