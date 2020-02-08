<!DOCTYPE html>
<html lang="it">


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Shop Item - Start Bootstrap Template</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="css/imgproduct.css" rel="stylesheet">
    <link href="css/carousel.css" rel="stylesheet">
    <link href="css/registernow.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <script>
    $(document).ready(function(){
    	$("#acquisto").click(function() {
    		$.post("CartManager", 
    				//$("#loginForm").serialize(),
    				function(data) {
    					$("#errorLogin").text(data);
    				}
    		)
    	})
    });
    </script>

</head>

<body>

<!-- TODO Navigation bar -->


<!-- JSP -->
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.servlet.http.HttpServletRequest" %>
<%@ page import = "model.GameBean" %>
<%@ page import = "model.GameDS" %>
<%@ page import = "javax.sql.DataSource" %>
<%
	String idParameter = request.getParameter("ID");
	GameBean gb = null;
	if(idParameter != null && !idParameter.isEmpty()) {
		int gameID;
		try {
			gameID = Integer.parseInt(idParameter);
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			GameDS gameDS = new GameDS(ds);
			gb = gameDS.doRetrieveByKey(gameID);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
%>

	<!-- Page Content -->
	<div class="container">
		<!-- Header -->
		<%@ include file = "header.jsp" %>
	
	    <div class="row">
	
	        <div class="col-lg-12">
	        	<% if(gb != null) { %>
	
	            <div class="card mt-4">
	                <img class="card-img-top img-fluid" src="<%= gb.getImg() %>" alt="">
	                <div class="card-body">
	                    <h3 class="card-title"> <%= gb.getTitle() %> </h3>
	                    <p class="card-text"> <%= gb.getDescription() %> </p>
	                    <button type="button" class="btn btn-primary btn-sm" id = "acquisto"> Acquista a &euro; 16,99 </button>
	                    
	                </div>
	            </div>
	            <!-- /.card -->
	
	            <div class="card card-outline-secondary my-4">
	                <div class="card-header">
	                    Informazioni
	                </div>
	                <div class="card-body">
	                    <h5>Requisiti di sistema</h5>
	                    <p> <%= gb.getDescription() %> </p> //TODO scegliere come gestire i requisiti di sistema (creare una nuova variabile / integrare nella descrizione)
	                    
	
	                    <hr>
	                    <h5>Recensioni</h5>
	                    <p> <%= gb.getReviewString() %> </p>
	                    <!-- TODO display delle recensioni -->
	
	                    <hr>
	                    <h5>Vota</h5>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
	                    <button class="btn btn-primary btn-sm"> <i class="fa fa-lg fa-thumbs-o-up">Mi piace</i> </button>
	                    <button class="btn btn-primary btn-sm"> <i class="fa fa-lg  fa-thumbs-o-down">Non mi piace</i> </button>
	                    <!-- TODO aggiungere al button la chiamata ad un metodo che setta il campo liked (ReviewBean) su T/F  -->
	
	                </div>
	            </div>
	            <!-- /.card -->
	
				<% } else { %>
					<div><h1>Errore: ID assente.</h1></div>
				<% } %>
				
	        </div>
	        <!-- /.col-lg-9 -->
	
	    </div>
	
	</div>
	<!-- /.container -->

<!-- Footer -->

    <!-- /.container -->
<footer></footer>

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>



</body>

</html>