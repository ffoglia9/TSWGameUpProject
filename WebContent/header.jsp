<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "model.UserBean" %>
<%@ page import = "model.Cart" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="css/signin.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<header>

  <!-- <link href="css/header.css" rel="stylesheet"> -->
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="index.jsp"><img class="ml-5" src="gameuppngsfondonero1.png" alt="" width="72" height="72"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <%
          	UserBean ub = (UserBean) request.getSession().getAttribute("userBean");
          	if(ub != null) {
          %>
          	<span class="navbar-text"><%= ub.getUsername() %></span>
          <% } else { %>
          	<a class="nav-link" data-toggle="modal" data-target="#exampleModalCenter" href="/">Login</a>
          <% } %>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Pubblica il tuo gioco</a>
        </li>
      </ul>
      <a href="checkout.jsp" class="nav-link">
		<i class="fa fa-shopping-cart"></i>
			<sup><span class="badge badge-pill badge-danger">
			<%
				Cart shoppingCart = (Cart) request.getSession().getAttribute("ShoppingCart");
				if(shoppingCart != null) {
			%>
			<%= shoppingCart.getAmountOfGames() %>
			<% } else { %>
			0
			<% } %>
			</span></sup>
 	  </a>
      <form class="form-inline mt-2 mt-md-0">
        <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Search</button>
      </form>
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
            <img class="mb-4" src="..." alt="" width="72" height="72">
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