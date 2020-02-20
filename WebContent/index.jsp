<!doctype html>
<html lang="it">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>GAME UP </title>
  <%@ include file="header.jsp"%>

  <style>
    .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }

    @media (min-width: 768px) {
      .bd-placeholder-img-lg {
        font-size: 3.5rem;
      }
    }
  </style>
  
  <%@ page import = "model.GameDS" %>
  <%@ page import = "model.GameBean" %>
  <%@ page import = "model.ReviewDS" %>
  <%@ page import = "javax.sql.DataSource" %>
  <%@ page import = "java.util.ArrayList" %>
  <%@ page import = "java.util.Arrays" %>

</head>

<body>

  <main role="main">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
            <rect width="100%" height="100%" fill="#777" /></svg>
          <div class="container">
            <div class="carousel-caption text-left">
              <h1>Example headline.</h1>
              <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
              <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
            </div>
          </div>
        </div>
        <div class="carousel-item">
          <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
            <rect width="100%" height="100%" fill="#777"/></svg>
          <div class="container">
            <div class="carousel-caption">
              <h1>Another example headline.</h1>
              <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
              <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
            </div>
          </div>
        </div>
        <div class="carousel-item">
          <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
            <rect width="100%" height="100%" fill="#777" /></svg>
          <div class="container">
            <div class="carousel-caption text-right">
              <h1>One more for good measure.</h1>
              <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
              <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>
            </div>
          </div>
        </div>
      </div>
      <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>


    <!-- Marketing messaging and featurettes
  ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->
    
  
    
    <%
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		GameDS gameDS = new GameDS(ds);
        ReviewDS reviewDS = new ReviewDS(ds);
		ArrayList<GameBean> allGames = (ArrayList<GameBean>) gameDS.doRetrieveAll("Valutazione");
		
		int valutazioni[] = null, gameIDs[] = null, i = 0;
		
		for(GameBean gb : allGames){
			
			valutazioni[i] = reviewDS.valutazione(gb.getCode());
			gb.setValutazione(valutazioni[i]);
			i++;
		}
		
		Arrays.sort(valutazioni);
			
		int best4Games[] = null;
			
		
		
		%>

    <div class="container">
      <hr class="horizontal-line" noshade>
      <p class="h1 text-left mb-4">Offerte del giorno</p>
      <div class="row">
        <div class="col">
  			<jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>
        </div>
        <div class="col">
        <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
      </div>

      <div class="row">
        <div class="col">
          <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
        <div class="col">
            <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
      </div>
    </div>




    <!-- START THE FEATURETTES -->

    <div class="container">
      <hr class="horizontal-line" noshade>
      <p class="h1 text-left mb-4">Giochi che adoriamo</p>
      <div class="row">
        <div class="col">
            <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
        <div class="col">
         <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
      </div>

      <div class="row">
        <div class="col">
           <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
        <div class="col">
            <jsp:include page="product_card.jsp">
              	<jsp:param name="ID" value="1"/>
              </jsp:include>

        </div>
      </div>
    </div>


    <!-- /END THE FEATURETTES -->

    <!-- /.container -->


    <!-- FOOTER -->
	<%@ include file="footer.jsp"%>
	
 

  </main>

</body>



</html>
