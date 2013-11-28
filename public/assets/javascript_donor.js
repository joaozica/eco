$(document).ready(function() {
	
	$("#cod_company").change(function(e){
		fillOptions();
	});

	function fillOptions() {
		company_id = $("#cod_company").val();
		$.get('/companies/'+ company_id +"/donors", function(data){
			$("#cod_donors").html(data);
		});
	}
});
