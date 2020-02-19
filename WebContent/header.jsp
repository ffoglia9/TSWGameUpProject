<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "model.UserBean" %>
<%@ page import = "model.Cart" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/signin.css" rel="stylesheet">
<link href="css/header.css" rel="stylesheet"> 
<link href="css/imganimation.css" rel="stylesheet"> 
<link href="css/footer.css" rel="stylesheet">
<link href="css/carousel.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<header>

  
  <nav class="navbar navbar-expand-md navbar-dark navbar-fixed-top bg-dark">
    <a class="navbar-brand" href="index.jsp"><img class="ml-5" src="gameuppngsfondonero1.png" alt="" width="72" height="72"></a> 
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav ">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Pubblica il tuo gioco</a>
        </li>
      </ul>

 	 
    <form action="./catalogo.jsp" method="GET" class=" form-inline d-none d-sm-block d-md-none d-lg-block mr-auto ml-auto w-75 ">
        <input name="title" class="form-control mr-sm-1 w-75" type="text" placeholder="Search">   
        <span class="input-group-btn ">
        <button class="btn btn-default" type="button">
            <i class="fa fa-sm fa-search" aria-hidden="true"></i>
             
        </button>
      </span>
     
      </form>
      

      
      	 <ul class="navbar-nav ml-auto nav-flex-icons">
        <li class="nav-item avatar dropdown">
          <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-5" data-toggle="dropdown" aria-haspopup="true"
            aria-expanded="false">
            <img src="http://placehold.it/32x32" class="rounded-circle z-depth-0" alt="avatar image">
          </a>
          <div class="dropdown-menu dropdown-menu-right dropdown-secondary" aria-labelledby="navbarDropdownMenuLink-5">
          	<%
          		UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
          		if(ub != null) {
         	%>
         		<span class="dropdown-item"><%= ub.getUsername() %></span>
         		<a class="dropdown-item" href="./pannello_utente.jsp">Pannello utente</a>
         		<a class="dropdown-item" href="" onclick="logout()" >Logout</a>
         	<% } else { %>
	            <a class="dropdown-item" data-toggle="modal" data-target="#exampleModalCenter" href="/">Login</a>
	            <a class="dropdown-item" href="./registernow.jsp">Registrati</a>
	        <% } %>
          </div>
        </li>
        <li>
        
            <a href="checkout.jsp" class="nav-link">
		<i class="fa fa-lg fa-shopping-cart"></i>
			<sup><span class="badge badge-pill badge-danger">
			<%
				Cart shoppingCart2 = (Cart) request.getSession().getAttribute("ShoppingCart");
				if(shoppingCart2 != null) {
			%>
			<%= shoppingCart2.getAmountOfGames() %>
			<% } else { %>
			0
			<% } %>
			</span></sup>
 	  </a>
        
        
        </li>
      </ul>
      
   
    

      </div>
  </nav>
  
  
  
  <!-- Modal -->
  <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title align-middle" id="exampleModalLongTitle">Login Utente</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        
        
        <!--Signin-->
        <div class="modal-body">
          <form class="form-signin" id="loginForm">
            <img class="mb-4" src="gameuppngsfondonero1.png" alt="" width="72" height="72">
            <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
            <h2 id="errorLogin" class="h3 mb-3 font-weight-normal text-danger"></h2>
            <div>
            	<label for="email" class="sr-only">Email address</label>
	            <input name="email" type="email" class="form-control" id="email" placeholder="you@example.com" required autofocus>
	            <div class="invalid-feedback"></div>
	        </div>
	        <div>
	            <label for="password" class="sr-only">Password</label>
	            <input name="password" type="password" class="form-control" id="password" placeholder="password" required>
	            <div class="invalid-feedback"></div>
            </div>
            <div class="checkbox mb-0">
              <label>
                <input type="checkbox" value="remember-me"/> Remember me
              </label>
            </div>
              <a class="mb-3" href="registernow.jsp">Register now</a>
            <button class="btn mt-3 btn-lg btn-primary btn-block" id="loginSubmit" type="button">Sign in</button>
            <p class="mt-3 mb-3 text-muted">&copy; Game Up 2020</p>
          </form>
        </div>
      </div>
    </div>
  </div>
</header>