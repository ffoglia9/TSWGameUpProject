<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<header>
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="index.jsp"><img class="ml-5" src="gameuppngsfondonero1.png" alt="" width="72" height="72"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item" >
          <a class="nav-link" data-toggle="modal" data-target="#exampleModalCenter" href="/">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Pubblica il tuo gioco <span class="sr-only">(current)</span> </a>
        </li>
      </ul>
      <form class="form-inline mt-2 mt-md-0">
        <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
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
            <label for="inputEmail" class="sr-only">Email address</label>
            <input type="email" id="inputEmail" name="inputEmail" class="form-control" placeholder="Email address" required autofocus>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" name="inputPassword" class="form-control" placeholder="Password" required>
            <div class="checkbox mb-0">
              <label>
                <input type="checkbox" value="remember-me"/> Remember me
              </label>
            </div>
              <a class="mb-3" href="registernow.jsp">Register now</a>
            <button class="btn mt-3 btn-lg btn-primary btn-block" id="loginSubmit" type="button">Sign in</button>
            <p class="mt-3 mb-3 text-muted">&copy; Game Up 2019</p>
          </form>
        </div>
      </div>
    </div>
  </div>
</header>