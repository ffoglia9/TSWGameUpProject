<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Catalogo giochi - Game Up</title>
  <%@ include file="header.jsp"%>

  <!-- Custom styles for this template -->
  <link href="css/catalogo.css" rel="stylesheet">
  
   <%@ page import = "model.UserBean" %>
   <%@ page import = "model.UserBean.tipoUtente" %>
   <% 
     UserBean uBean = (UserBean) request.getSession().getAttribute("userBean");
	 tipoUtente userType = uBean.getUserType();
   %>


</head>


<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class=" border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Ciao, <%= uBean.getUsername() %> </div>
      <div class="list-group list-group-flush">
        <a href="#" class="list-group-item list-group-item-action " onclick="switchTab('#infoAccount')">Info account</a>
        <a href="#" class="list-group-item list-group-item-action " onclick="switchTab('#listaAcquisti')">Lista acquisti</a>
        <%
          	if(userType == tipoUtente.Developer) {
        %>
        	<a href="#" class="list-group-item list-group-item-action " onclick="switchTab('#mieApp')">Le mie app</a>
        <% } else if(userType == tipoUtente.Admin) { %>
	        <a href="#" class="list-group-item list-group-item-action " onclick="switchTab('#daApprovare')">Giochi da approvare</a>
	        <a href="#" class="list-group-item list-group-item-action " onclick="switchTab('#daSponsorizzare')">Sponsorizzazioni in attesa</a>
        <% } %>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

      <nav class="navbar navbar-expand-lg navbar-light">
        <a href=""><i id="menu-toggle" class="fa fa-lg fa-bars"></i></a>
      </nav>
		
      <div class="container" id="destinazione">
      
      	<!-- Info del mio account utente -->
        <div id="infoAccount">
			Username: <%= uBean.getUsername() %><br>
			Email: <%= uBean.getEmail() %><br>
			Password: <%= uBean.getPassword() %>
		</div>
		
		<!-- Lista degli acquisti effettuati dall'utente -->
		<div id="listaAcquisti" style="display: none">
			LISTA ACQUISTI
			CREARE UNA ENTRY TRANSAZIONE CONTENENTE ID UTENTE E ID GIOCO, QUANDO SI ACQUISTA UN GIOCO
			FARE IL SELECT DI TUTTE LE TRANSAZIONI DELL'UTENTE UBEAN E PRINTARLE QUA
			serve un formato html per ogni transazione
		</div>
		
		<%
          	if(userType == tipoUtente.Developer) {
        %>
		<!--  Lista delle app sviluppate dall'utente -->
		<div id="mieApp" style="display: none">
			LISTA APP
			FARE UN SELECT DI TUTTI I GIOCHI CON ID UTENTE DELL'UBEAN
		</div>
		
		<% } else if(userType == tipoUtente.Admin) { %>
		<!-- Lista dei giochi proposti in attesa di approvazione -->
		<div id="daApprovare" style="display: none">
			BOOLEANO ACCETTATO SETTATO A FALSE PER LE PROPOSTE DI GIOCO
			MESSO A VERO QUANDO L'ADMIN ACCETTA
		</div>
		
		<!-- Lista dei giochi in attesa di sponsorizzazione -->
		<div id="daSponsorizzare" style="display: none">
			BOOLEANO ACCETTATO SETTATO A FALSE DI DEFAULT
			MESSO A VERO QUANDO L'ADMIN ACCETTA LA SPONSORIZZAZIONE
		</div>
		<% } %>
		
      </div>
    </div>
    <!-- /#page-content-wrapper -->

  </div>


  <!-- /#wrapper -->

   <%@ include file="footer.jsp"%>

  <!-- Menu Toggle Script -->
  <script>
    $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
    });
    function switchTab(sourceID) {
    	$("#destinazione").children(":visible").hide(); // nascondi l'elemento che in questo momento è visibile
    	$(sourceID).show(); // e mostra quello con id = sourceID
    }
  </script>

</body>

</html>