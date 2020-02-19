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
  <%@ page import = "model.GameDS" %>
  <%@ page import = "model.GameBean" %>
  <%@ page import = "javax.sql.DataSource" %>
  <%@ page import = "java.util.ArrayList" %>

</head>


<body>
	<%
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
		ArrayList<GameBean> allGames;
		String action = request.getParameter("list");
		if(action == null) { // controlla se l'utente ha provato a cercare un titolo
			String title = request.getParameter("title");
			if(title == null) // mostra tutti i possibili giochi nel caso default
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveAll("Valutazione");
			else { // l'utente sta provando a cercare un titolo
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveByTitle(title);
			}
		}
		else {
			switch(action) {
			case "Action":
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveByGenre("Action");
				break;
			case "RTS":
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveByGenre("RTS");
				break;
			case "Adventure":
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveByGenre("Adventure");
				break;
			case "Puzzle":
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveByGenre("Puzzle");
				break;
			case "Arcade":
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveByGenre("Arcade");
				break;
			default: // comprende il caso all
				allGames = (ArrayList<GameBean>) gameDS.doRetrieveAll("Valutazione");
				break;
			}
		}
	%>
  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class=" border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Start Bootstrap </div>
      <div class="list-group list-group-flush">
        <a href="?list=all" class="list-group-item list-group-item-action ">Tutti i giochi</a>
        <a href="?list=Action" class="list-group-item list-group-item-action ">Action</a>
        <a href="?list=RTS" class="list-group-item list-group-item-action ">RTS</a>
        <a href="?list=Adventure" class="list-group-item list-group-item-action ">Adventure</a>
        <a href="?list=Puzzle" class="list-group-item list-group-item-action ">Puzzle</a>
        <a href="?list=Arcade" class="list-group-item list-group-item-action ">Arcade</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

      <nav class="navbar navbar-expand-lg navbar-light">
        <a href=""><i id="menu-toggle" class="fa fa-lg fa-bars"></i></a>
      </nav>

      <div class="container">
        <p class="h1 text-left mb-4">Catalogo giochi</p>
        <%
        	GameBean gb;
        	while(allGames.size() > 2) { gb = allGames.remove(0);
       	%>
       				<div class="row">
       	  <div class="col">
              <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="<%= gb.getCode() %>"/>
              </jsp:include>
          </div>
          <% gb = allGames.remove(0); %>
          <div class="col">
              <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="<%= gb.getCode() %>"/>
              </jsp:include>
          </div>
          </div>
          <% } %>
          <% if(!allGames.isEmpty()) { gb = allGames.remove(0); %>
          		<div class="row">
       	  <div class="col">
              <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="<%= gb.getCode() %>"/>
              </jsp:include>
          </div>
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
  </script>
</body>

</html>
