$(document).ready(function() {
	// cod_cidades
	$("#cod_estados").change(function(e){
		fillOptions();
	});

	function fillOptions() {
		state_id = $("#cod_estados").val();
		$.get('/states/'+ state_id +"/cities", function(data){
			$("#cod_cidades").html(data);
		});
	}
		
});
