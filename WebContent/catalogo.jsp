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


</head>


<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class=" border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Start Bootstrap </div>
      <div class="list-group list-group-flush">
        <a href="#" class="list-group-item list-group-item-action ">Dashboard</a>
        <a href="#" class="list-group-item list-group-item-action ">Shortcuts</a>
        <a href="#" class="list-group-item list-group-item-action ">Overview</a>
        <a href="#" class="list-group-item list-group-item-action ">Events</a>
        <a href="#" class="list-group-item list-group-item-action ">Profile</a>
        <a href="#" class="list-group-item list-group-item-action ">Status</a>
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
        <div class="row">
          <div class="col">
              <%@ include file="product_card.jsp"%>

          </div>
          <div class="col">
           <%@ include file="product_card.jsp"%>

          </div>
        </div>

        <div class="row">
          <div class="col">
             <%@ include file="product_card.jsp"%>

          </div>
          <div class="col">
              <%@ include file="product_card.jsp"%>

          </div>
        </div>
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
