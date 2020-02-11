// Funzioni speciali di controllo, usate per validazioni ulteriori
function emailPresent(jQueryObj) {
	var returnVal = false;
	var httpObj = $.ajax({
			url: "Register", 
			type: "GET",
			data: {"email" : jQueryObj.val()},
			async: false,
			statusCode: {
				200: function() {returnVal = true},
				420: function(jqXHR, textStatus, errorThrown) {
					console.log(textStatus);
					jQueryObj.closest("div").find(".invalid-feedback").text(Validations.errorMessages["email"]["alreadyExisting"]);
				}
			}
	});
	return returnVal;
}

function usernamePresent(jQueryObj){
	var returnVal = false;
	$.ajax({
		url: "Register",
		type: "GET",
		data: {"username" : jQueryObj.val()},
		async: false,
		statusCode: {
			200: function() {returnVal = true},
			420: function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				jQueryObj.closest("div").find(".invalid-feedback").text(Validations.errorMessages["username"]["alreadyExisting"]);
			}
		}
	});
	
	return returnVal;
}

Validations.specialBehaviour["registerFormemail"] = emailPresent;
Validations.specialBehaviour["registerFormusername"] = usernamePresent;