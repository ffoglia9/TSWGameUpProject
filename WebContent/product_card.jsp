<%@ page import = "javax.sql.DataSource" %>
<%@ page import = "model.GameDS" %>
<%@ page import = "model.GameBean" %>

<% 
	int ID = Integer.parseInt(request.getParameter("ID"));
	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
	GameDS gameDS = new GameDS(ds);
	GameBean gBean = gameDS.doRetrieveByKey(ID); // Può ritornare null, ma in questo caso il problema non risiede qui e va risolto
%>

<div class="card shadow-lg py-4 mb-3" style="max-width: 540px;">
	<div class="row ">
		<div
			class="col-md-4 my-auto img-hover-zoom img-hover-zoom--brightness">
			<img src="<%= gBean.getIcon() %>" class="card-img shadow-lg align-middle" alt="...">
		</div>
		<div class="col-md-8">
			<div class="card-body">
				<h5 class="card-title"><%= gBean.getTitle() %></h5>
				<p class="card-text"><%= gBean.getDescription() %></p> 
				<button type="button" class="btn btn-primary btn-sm"
					onclick="window.location.href = 'singleproduct.jsp?ID=<%= gBean.getCode() %>'"><%= gBean.getPrice() %>
					&euro;</button>
			</div>
		</div>
	</div>
</div>