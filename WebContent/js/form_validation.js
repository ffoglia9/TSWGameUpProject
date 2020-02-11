// Uso:
// Aggiungere una regex associata all'id dell'input che si vuole validare

// Se non esiste una regex associata all'id di un input, allora il campo non viene validato

var Validations = new Object();
Validations.regs = new Object();
Validations.specialBehaviour;
Validations.errorMessages; // formato: id = {invalid : "invalid message", server : "server message" ... }

// Funzione di validazione, ritorna vero se il matching regex ritorna un risultato non null
Validations.regs.validate = function(text, pattern) {
	if(text.match(pattern)) {
		return true;
	} else {
		return false;
	}
}

errorMsgs = new Object(); // Messaggi di errore per la validazione degli input, id = {invalid : "invalid message", server : "server message" ... }

errorMsgs.email = {
	"invalid" : "Il campo deve contenere una mail valida (you@example.com)",
	"alreadyExisting" : "L'email è già stata usata!",
	"noEmailExisting" : "Non esiste un account associato a questa email."
};
errorMsgs.firstName = {
	"invalid" : "Il nome deve contenere solo lettere."
};
errorMsgs.lastName = {
	"invalid" : "Il cognome deve contenere solo lettere."
};
errorMsgs.username = {
	"invalid" : "L'username può contenere lettere, numeri, trattini (-) e underscore (_).",
	"alreadyExisting" : "L'username è già in uso!"
};
errorMsgs.password = {
	"invalid" : "La password deve essere di almeno 8 caratteri."
};
errorMsgs.indirizzo = {
	"invalid" : "L'indirizzo può contenere solo lettere, numeri, spazi e la virgola."
};
errorMsgs.citta = {
	"invalid" : "L'indirizzo può contenere solo lettere e spazi."
};
errorMsgs.cap = {
	"invalid" : "Il cap deve essere formato da 5 cifre."
};
errorMsgs.defaultMsg = {
	"invalid": "Il campo è obbligatorio."
}
Validations.errorMessages = errorMsgs;

// Oggetto (array associativo) id = regex associata
regexes = new Object();

regexes.email = /^\w+(?:[\.-]?\w+)*@\w+(?:[\.-]?\w+)*(?:\.\w{2,4})+$/; // Formato email: test@example.com. I gruppi regex sono di tipo non-capture, poiché dobbiamo solo validare l'email.
regexes.firstName = /^[A-Za-z]+$/; // Solo lettere (minuscole/maiuscole)
regexes.lastName = /^[A-Za-z]+$/; // ^
regexes.username = /^[A-Za-z0-9\-\_]+$/; // Solo lettere (minuscole/maiuscole), numeri, trattino (-) e underscore (_)
regexes.password = /^.{8,}$/; // Minimo 8 caratteri
regexes.indirizzo = /^[a-zA-Z0-9\s,]+$/; // Solo lettere (minuscole/maiuscole), numeri, spazi e la virgola.
regexes.citta = /^[A-Za-z\s]+$/; // Solo lettere (minuscole/maiuscole) e spazi.
regexes.cap = /^\d{5}$/; // Solo 5 numeri

Validations.regs.regex = regexes;

// Funzioni speciali di controllo, comboid = funzione associata (definite negli script js dedicati ai singoli form).
// comboid = id form + id input
Validations.specialBehaviour = new Object();

// Funzioni di validazione, validano l'input tramite l'uso di regex e settano il DOM tramite jquery
Validations.validate = function(jQueryObj) { // Prende un oggetto jquery come input, deve essere un input di un form
	var inputID = jQueryObj.attr("id");
	var comboID = jQueryObj.closest("form").attr("id") + inputID;
	console.log("timeout running " + Validations.timeoutIDs[comboID]);
	Validations.timeoutIDs[comboID] = null;
	if(!(jQueryObj.val()) && jQueryObj.attr("required")) { // Il campo è required ma l'utente non lo ha compilato, segna come invalido e termina la funzione
		jQueryObj.removeClass("is-valid").addClass("is-invalid");
		jQueryObj.closest("div").find(".invalid-feedback").text(Validations.errorMessages.defaultMsg["invalid"]);
		return
	}
	if(!Validations.regs.regex[inputID]) { // Nessuna regex associata all'input, quindi non va validato
		return
	}
	Validations.timeoutIDs[comboID] = null;
	var success = Validations.regs.validate(jQueryObj.val(), Validations.regs.regex[inputID]); // Validazione lato client della sintassi dell'input tramite regex
	console.log("validating" + Validations.regs.regex[inputID] + ": " +success);
	if(!success) {
		jQueryObj.closest("div").find(".invalid-feedback").text(Validations.errorMessages[inputID]["invalid"]); // Trova il div parente dell'oggetto input. Trova un elemento con la classe invalid-feedback all'interno. 
	}
	console.log(comboID);
	if(success && Validations.specialBehaviour[comboID]) {
		console.log("specialBehaviour con comboID "+comboID+" esiste");
		success = Validations.specialBehaviour[comboID](jQueryObj); // Ulteriore validazione (es. controllo della presenza dell'email nel DB lato server
	}
	if(success) {
		jQueryObj.removeClass("is-invalid").addClass("is-valid");
	} else {
		jQueryObj.removeClass("is-valid").addClass("is-invalid");
	}
}

Validations.timeoutIDs = new Object();
$("form :input").keyup(function(data) { // Valida l'input 1 secondo dopo che l'utente ha smesso di digitare del testo.
	var thisObj = $(this);
	var thisID = thisObj.closest("form").attr("id") + thisObj.attr("id"); // genera un id univoco creato dalla combo id form + id input
	console.log("calling!");
	if(Validations.timeoutIDs[thisID] != null && Validations.timeoutIDs[thisID] != undefined) {
		console.log("being deleted " + Validations.timeoutIDs[thisID]);
		clearTimeout(Validations.timeoutIDs[thisID]);
		Validations.timeoutIDs[thisID] = null;
	}
	Validations.timeoutIDs[thisID] = setTimeout(Validations.validate, 1000, thisObj); // Un secondo di pausa da parte dell'utente causa l'esecuzione della validazione.
});

$("form").submit(function(e) {
	$(this).find(":input").each(function() {
		Validations.validate($(this));
		if($(this).hasClass("is-invalid")) { // Se uno degli input è invalido, la richiesta non viene mandata
			e.preventDefault();
		}
	})
});
