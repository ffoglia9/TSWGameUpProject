$(document).ready(function(){
	$("#loginSubmit").click(function() {
		console.log("yes");
		console.log($("#loginForm").serialize());
		$.post("SignIn", 
				$("#loginForm").serialize(),
				function(data) {
					$("#errorLogin").text(data);
				}
		)
	})
});