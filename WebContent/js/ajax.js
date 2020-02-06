$(document).ready(function(){
	$("#loginSubmit").click(function() {
		console.log("yes");
		$.post("SignIn", 
				$("#loginForm").serialize(),
				function(data) {
					$("#errorLogin").text(data);
				}
		)
	})
});