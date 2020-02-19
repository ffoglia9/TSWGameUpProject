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
    <link href="css/registernow.css" rel="stylesheet">
  
  
  
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
        	<a href="#" class="list-group-item list-group-item-action " onclick="switchTab('#pubblicaGioco')">Pubblica gioco</a>
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
        
        	 <div class="row">
        	 	
                   <div class="col-md-6 mb-3">
                       <label for="username" class="lb">Username</label>
                       <input name="nome" type="text" class="form-control" id="firstName" value="<%= uBean.getUsername() %>" readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName">Password</label>
                        <div class="input-group">
                        	<input name="password" type="password" class="form-control pwd" id="password"  data-toggle="password" value="<%= uBean.getPassword() %>">
                         	<div class="input-group-append">
                         		<span class="input-group-text reveal"><i class="fa fa-eye"></i>
                         		</span>
                         	</div>
                    	</div>
                    </div>
                </div>
                
                <div class="row">
                	<div class="col-md-6 mb-3">
                		<label for="Email" class="lb">Email</label>
                       <input name="nome" type="text" class="form-control" id="email" value="<%= uBean.getEmail() %>" readonly>
                	</div>
                	
                	<div class="col-md-6 mb-3">
                		<label for="developer">Sei uno sviluppatore?<span class="text-muted"></span></label><br>
                    	<div class="btn-group btn-group-toggle" data-toggle="buttons">
                        	<label class="btn btn-secondary ">
                            	<input type="radio" name="developer" id="developeryes" value="<%= uBean.getUserTypeID() %>" autocomplete="off" > SI
                        	</label>
                        	<label class="btn btn-secondary active">
                            	<input type="radio" name="developer" id="developerno" value="<%= uBean.getUserTypeID() %>" autocomplete="off"> NO
                        	</label>
                    	</div>
                    </div>
                	
                	
                
                </div>
                
                <hr class="horizontal-line mt-4" noshade>
      			<p class="h4 text-left mb-5">Informazioni di fatturazione</p>
                <div class="row">
                	
                	<div class="col-md-6 mb-3">
                		<label for="nome" class="lb">Nome</label>
                       <input name="nome" type="text" class="form-control" id="nome" value="<%= uBean.getEmail() %>" readonly>
                	</div>
                	
                	<div class="col-md-6 mb-3">
                		<label for="cognome" class="lb">Cognome</label>
                       <input name="nome" type="text" class="form-control" id="cognome" value="<%= uBean.getEmail() %>" readonly>
                	</div>
                	
                	<div class="col-md-6 mb-3">
                		<label for="cognome" class="lb">Via e numero civico</label>
                       <input name="nome" type="text" class="form-control" id="cognome" value="<%= uBean.getEmail() %>" readonly>
                	</div>
                	
                	<div class="col-md-6 mb-3">
                		<label for="cognome" class="lb">CAP</label>
                       <input name="nome" type="text" class="form-control" id="cognome" value="<%= uBean.getEmail() %>" readonly>
                	</div>
                	
                	<div class="col-md-6 mb-5">
                		<label for="cognome" class="lb">Citt�</label>
                       <input name="nome" type="text" class="form-control" id="cognome" value="<%= uBean.getEmail() %>" readonly>
                	</div>
                	
                
                </div>
                
                
                
                
                <div class="row">
                <div class="col-8 mt-5 mb-3">
                </div>
                
                <div class="col-4 mt-4 mb-3">
                 	<button class="btn btn-primary btn-block" type="submit">Applica</button>
                
                </div>
                
                
                </div>
                      
             </div>
        
        
      
		
		<!-- Lista degli acquisti effettuati dall'utente -->
		<div id="listaAcquisti" style="display: none">
			LISTA ACQUISTI
			CREARE UNA ENTRY TRANSAZIONE CONTENENTE ID UTENTE E ID GIOCO, QUANDO SI ACQUISTA UN GIOCO
			FARE IL SELECT DI TUTTE LE TRANSAZIONI DELL'UTENTE UBEAN E PRINTARLE QUA
			serve un formato html per ogni transazione
			<div class="row">
				<div class="col-md-12">
                	<jsp:include page="transazione_card.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include>
                </div>
                
                <div class="col-md-12">
                	<jsp:include page="transazione_card.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include>
                </div>
                
				
			</div>
			
			
			
			
			
			
			
			
		</div>
		
		<%
          	if(userType == tipoUtente.Developer) {
        %>
		<!--  Lista delle app sviluppate dall'utente -->
		<div id="mieApp" style="display: none">
			LISTA APP
			FARE UN SELECT DI TUTTI I GIOCHI CON ID UTENTE DELL'UBEAN
			
			<div class="row">
				<div class="col-md-12">
                	<jsp:include page="app_developer.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include>
                </div>
                
                <div class="col-md-12">
                	<jsp:include page="app_developer.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include>
                </div>
			
			
			
		</div>
		</div>
		
		
		
		<div id="pubblicaGioco" style="display:none">
		<form id="registerForm" class="needs-validation" action="" method="post" novalidate>

			<div class="row">
			
				<div class="col-md-12 mb-3">
					<label for="nomegioco">Nome del gioco<span class="text-muted"></span></label>
                    <input name="nome" type="text" class="form-control" id="nomegioco" required>
				</div>
			
			</div>
			
			
			<div class="row">
			
				<div class="col-md-12 mb-3">
					<label for="descrizione">Descrizione<span class="text-muted"></span></label>
                    <textarea class="form-control" id="descrizionegioco" rows="5"></textarea>
				</div>
				
			
			</div>
			
				<div class="row">
			
				<div class="col-md-12 mb-3">
					<label for="descrizione">Carica la copertina del gioco<span class="text-muted"></span></label>
					<div class="custom-file">
					 	
    					<input type="file" class="custom-file-input" id="customFile">
    					<label class="custom-file-label" for="customFile">Scegli file</label>
  					</div>
				</div>
		
		
				</div>
				
				
				<div class="row">
			
				<div class="col-md-12 mb-3">
					<label for="descrizione">Carica l'icona del gioco<span class="text-muted"></span></label>
					<div class="custom-file">
					 	
    					<input type="file" class="custom-file-input" id="customFile">
    					<label class="custom-file-label" for="customFile">Scegli file</label>
  					</div>
				</div>
		
		
				</div>
				
				
				<div class="row">
				
				<div class="col-md-6 mb-5">
					<label for="prezzo">Prezzo<span class="text-muted"></span></label>
				
					<div class="input-group">

					<div class="input-group-prepend">
					
    					<span class="input-group-text">&euro;</span>
  					</div>
  					<input type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
				</div>
				
				</div>
				
				<div class="col-md-6 mb-5">
					<label for="prezzo">Seleziona categoria<span class="text-muted"></span></label>
				
					<div class="input-group">

					<div class="input-group-prepend">
    					<label class="input-group-text" for="inputGroupSelect01">categorie</label>
  					</div>
  					<select class="custom-select" id="inputGroupSelect01">
    					<option selected>Choose...</option>
    					<option value="1">One</option>
    					<option value="2">Two</option>
    					<option value="3">Three</option>
  					</select>
					
					</div>
				</div>
				</div>
				<div class="row">
                	<div class="col-8 mt-5 mb-3">
                </div>
                <div class="col-4 mt-4 mb-3">
                 	<button class="btn btn-primary btn-block" type="submit">Invia</button>
                </div>
                </div>
		</form>
		</div>
		
		
		
		
		
		<% } else if(userType == tipoUtente.Admin) { %>
		<!-- Lista dei giochi proposti in attesa di approvazione -->
		<div id="daApprovare" style="display: none">
			BOOLEANO ACCETTATO SETTATO A FALSE PER LE PROPOSTE DI GIOCO
			MESSO A VERO QUANDO L'ADMIN ACCETTA
			
			<div class="row">
				<div class="col-md-12">
                	<jsp:include page="app_pending.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include>
                </div>
                
                <div class="col-md-12">
                	<jsp:include page="app_pending.jsp">
              		<jsp:param name="ID" value="1"/>
              		</jsp:include>
                </div>
                
				
			</div>
			
			
			
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
  </div>


  <!-- /#wrapper -->

  <!-- <%@ include file="footer.jsp"%>  --> 

  <!-- Menu Toggle Script -->
  <script>
    $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
    });
    function switchTab(sourceID) {
    	$("#destinazione").children(":visible").hide(); // nascondi l'elemento che in questo momento � visibile
    	$(sourceID).show(); // e mostra quello con id = sourceID
    }
    
    
    $(".reveal").on('click',function() {
        var $pwd = $(".pwd");
        if ($pwd.attr('type') === 'password') {
            $pwd.attr('type', 'text');
        } else {
            $pwd.attr('type', 'password');
        }
    });
    
    
    $(".custom-file-input").on("change", function() {
    	  var fileName = $(this).val().split("\\").pop();
    	  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    	});
    
    
  </script>

</body>

</html>