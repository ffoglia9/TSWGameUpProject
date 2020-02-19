<!DOCTYPE html>
<html lang="it">


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Shop Item - Start Bootstrap Template</title>
    <!-- Header -->
	<%@ include file = "header.jsp" %>

    <!-- Custom styles for this template -->
    <link href="css/imgproduct.css" rel="stylesheet">
    <link href="css/registernow.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href = "https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"rel = "stylesheet">
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

</head>

<body>

<!-- TODO Navigation bar -->
	<!-- Page Content -->
	<div class="container">
		
		<% if (gb != null) { %>
	
		    <div class="row">
		
		        <div class="col-lg-12">
		
		            <div class="card mt-4 pb-4">
		                <img class="card-img-top img-fluid" src="<%= gb.getImg() %>" alt="">
		                <div class="card-body">
		                    <h3 class="card-title ml-3"> <%= gb.getTitle() %> </h3>
		                    <p class="card-text ml-3"> <%= gb.getDescription() %> </p>
		                    <button type="button" class="btn btn-primary btn-sm ml-3" id = "acquisto"> Acquista a &euro; 16,99 </button>
		                    
		                </div>
		            </div>
		            <!-- /.card -->
		
		            <div class="card card-outline-secondary my-4 pb-4">
		                <div class="card-header ml-3">
		                    Informazioni
		                </div>
		                <div class="card-body ml-3">
		                    <h5>Requisiti di sistema</h5>
		                    <p> <%= gb.getDescription() %> </p> //TODO scegliere come gestire i requisiti di sistema (creare una nuova variabile / integrare nella descrizione)
		                    
		                    <hr>
		                    <h5>Recensioni</h5>
		                    <p> <jsp:include page="recensione_card.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include> </p>
		                    <!-- TODO display delle recensioni -->
		
		                    <hr>
		                    <h5>Vota</h5>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
		                    <button class="btn btn-primary btn-sm"> <i class="fa fa-lg fa-thumbs-o-up"></i> Mi piace </button>
		                    <button class="btn btn-primary btn-sm"> <i class="fa fa-lg  fa-thumbs-o-down"></i> Non mi piace </button>
		                    <!-- TODO aggiungere al button la chiamata ad un metodo che setta il campo liked (ReviewBean) su T/F  -->
		
		                </div>
		            </div>


					<form>
					 <div class="card card-outline-secondary my-4 pb-4">
		                <div class="card-header ml-3">
		                    Richiedi sponsorizzazione gioco
		                </div>
		                <div class="card-body ml-3">
		                    <h5>Inserisci una data di inizio e di fine</h5>
		                    
		                    <div class="col-md-6 mb-3">
                       			 <label for="lastName">Inizio</label>
                      			<div class="input-group">
                        			<input  type="text" id="datepicker" class="form-control">
                         			<div class="input-group-append">
                         				<span class="input-group-text"><i class="fa fa-calendar"></i>
                         				</span>
                         			</div>
                    			</div>
                    		</div>
                    
                      		<div class="col-md-6 mb-3">     
                        		<label for="lastName">Fine</label>
                        			<div class="input-group">
                        				<input  type="text" id="datepicker1" class="form-control">
                         			<div class="input-group-append">
                         				<span class="input-group-text"><i class="fa fa-calendar"></i>
                         				</span>
                         			</div>
                    				</div>
                    		</div>
		                    
		                    <button class="btn btn-primary btn-sm"> Invia richiesta </button>
		                    
		                    <!-- TODO aggiungere al button la chiamata ad un metodo che setta il campo liked (ReviewBean) su T/F  -->
		
		                </div>
		                </form>
		            </div>




		
					
		        </div>
		        <!-- /.col-lg-9 -->
		
		    </div>
		    
		    <script>
			    $(document).ready(function(){
			    	console.log("TEST");
			    	
			    	 
			    	
			    	$("#acquisto").click(function() {
			    		console.log("TEST2");
			    		$.post("CartManager", 
			    				{ID: <%= gb.getCode() %>},
			    				function(data) {
			    					$("#errorLogin").text(data);
			    				}
			    		)
			    	})
			    });
			    
			    $(function() {
		            $( "#datepicker" ).datepicker();
		            $( "#datepicker" ).datepicker("show");
		         });
			    
			    $(function() {
		            $( "#datepicker1" ).datepicker();
		            $( "#datepicker1" ).datepicker("show");
		         });
			    
			    
			   
			    
			    
			 
			    
			    
			</script>
	    
	    <% } else { %>
			<div><h1>Errore: ID assente.</h1></div>
		<% } %>
	
	</div>
	<!-- /.container -->

<!-- Footer -->
<%@ include file="footer.jsp"%>


</body>

</html>