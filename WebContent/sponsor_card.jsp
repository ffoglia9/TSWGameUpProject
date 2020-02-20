<%@ page import = "javax.sql.DataSource" %>
<%@ page import = "model.GameDS" %>
<%@ page import = "model.GameBean" %>
<%@ page import = "model.SponsorizzazioneBean" %>
<%@ page import = "model.SponsorizzazioneDS" %>

<% 
	int ID = Integer.parseInt(request.getParameter("ID"));
	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
	GameDS gameDS = new GameDS(ds);
	SponsorizzazioneDS sds = new SponsorizzazioneDS(ds);
	GameBean gBean = gameDS.doRetrieveByKey(ID); // Può ritornare null, ma in questo caso il problema non risiede qui e va risolto
	// sBean esisterà sempre poiché le card dinamiche sono generate dai giochi prodotti da doRetrievePendingSponsors();
	SponsorizzazioneBean sBean = sds.doRetrieveByKey(gBean.getSponsorID());
	
%>
    <link href="css/registernow.css" rel="stylesheet">

<div class="card shadow-lg py-4 mb-3" style="max-width: 540px;" >
	<div class="row ">
		<div class="col-md-4 my-auto img-hover-zoom img-hover-zoom--brightness">
			<img src="img1.jpg" class="card-img shadow-lg align-middle" alt="...">
		</div>
		<div class="col-md-8">
			<div class="card-body">
				<h5 class="card-title"><%= gBean.getTitle() %></h5>
				<p class="card-text"><%= gBean.getShortDescription() %></p> <!-- Da cambiare con un metodo che ritorna max y chars -->
				<a href="singleproduct.jsp?ID=<%= gBean.getCode() %>"><button type="button" class="btn btn-primary btn-sm">Più informazioni</button></a>
			</div>
			<div class="card-footer"> <!-- Data acquisto -->
				<p>Richiede sponsorizzazione dal <%= sBean.getDataInizio().toString() %> al <%= sBean.getDataFine().toString() %></p>
    			<button id="accettaGioco" type="button" class="btn btn-primary btn-sm ml-auto mr-auto"
    					onclick="$.post('PendingSponsor', {ID_Gioco: <%= gBean.getCode() %>, Approvato: 1}, function(data) { location.reload(true); })"
    			>Accetta<i class="ml-2 fa fa-check" aria-hidden="true"></i></button>
    			
    			<button id="rifiutaGioco" type="button" class="btn btn-primary btn-sm ml-auto mr-auto"
    					onclick="$.post('PendingSponsor', 
        				{ID_Gioco: <%= gBean.getCode() %>, Approvato: 0},
        				function(data) {
        					location.reload(true);
        				}
        		)"
    			>Rifiuta<i class="ml-2 fa fa-times" aria-hidden="true"></i></button>
    			

    			
  			</div>
		</div>
	</div>
</div>