$(document).ready(function(){
	$("#loginSubmit").click(function() {
		console.log("yes");
		console.log($("#loginForm").serialize());
		$.ajax({
			type: "POST",
			url: "SignIn",
			data: $("#loginForm").serialize(),
			success: function(data) {
				$("#errorLogin").text(data);
			},
			statusCode: {
				500: function(jqXHR, textStatus, errorThrown) {
					$("#errorLogin").text("Errore lato server");
				},
				432: function() {
					$("#errorLogin").text("Account non trovato")
				},
				433: function(jqXHR, textStatus, errorThrown) {
					$("#errorLogin").text("Password errata");
				},
			}
		});
	})
});