$(document).ready(function() {
	
	$("#cod_company").change(function(e){
		fillOptions();
	});

	function fillOptions() {
		company_id = $("#cod_company").val();
		$.get('/companies/'+ company_id +"/users", function(data){
			$("#cod_users").html(data);
		});
	}
});
