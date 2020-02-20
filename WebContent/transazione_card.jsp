<%@ page import = "javax.sql.DataSource" %>
<%@ page import = "model.TransazioneDS" %>
<%@ page import = "model.TransazioneBean" %>
<%@ page import = "model.GameBean" %>
<%@ page import = "model.GameDS" %>

<% 
	int ID = Integer.parseInt(request.getParameter("ID"));
	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
	TransazioneDS tds = new TransazioneDS(ds);
	TransazioneBean tBean = tds.doRetrieveByKey(ID); // Può ritornare null, ma in questo caso il problema non risiede qui e va risolto
	GameDS gds = new GameDS(ds);
	GameBean gBean = gds.doRetrieveByKey(tBean.getID_gioco());
%>

<div class="card shadow-lg py-4 mb-3" style="max-width: 540px;">
	<div class="row ">
		<div
			class="col-md-4 my-auto img-hover-zoom img-hover-zoom--brightness">
			<img src="img1.jpg" class="card-img shadow-lg align-middle" alt="...">
		</div>
		<div class="col-md-8">
			<div class="card-body">
				<h5 class="card-title"><%= gBean.getTitle() %></h5>
				<p class="card-text"><%= gBean.getShortDescription() %></p>
				<a href="singleproduct.jsp?ID=<%= gBean.getCode() %>"><button type="button" class="btn btn-primary btn-sm">Più informazioni</button></a>
			</div>
			<div class="card-footer"> <!-- Data acquisto -->
    			<p>Acquistato il <%= tBean.getData().toString() %></p>
  			</div>
		</div>
	</div>
</div>