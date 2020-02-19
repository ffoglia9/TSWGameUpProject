function emailNotPresent(jQueryObj) {
	var returnVal = true;
	var httpObj = $.ajax({
			url: "SignIn", 
			type: "POST",
			data: {"email" : jQueryObj.val()},
			async: false,
			statusCode: {
				432: function(jqXHR, textStatus, errorThrown) {
					returnVal = false;
				}
			}
	});
	if(!returnVal) {
		jQueryObj.closest("div").find(".invalid-feedback").text(Validations.errorMessages["email"]["noEmailExisting"]);
	}
	return returnVal;
}

//todo: rimuovere o migliorare
$("#loginSubmit").click(function() {
	console.log("yes");
	console.log($("#loginForm").serialize());
	$.ajax({
		type: "POST",
		url: "SignIn",
		async: false,
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
	location.reload(true);
})

Validations.specialBehaviour["loginFormemail"] = emailNotPresent;

// Funzione per effettuare il logout
function logout() {
	$.ajax({
		type: "GET",
		url: "SignIn",
		async: false
	});
	location.reload(true);
}