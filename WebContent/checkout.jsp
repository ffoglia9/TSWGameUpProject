<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>Checkout</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Ensures optimal rendering on mobile devices. -->
 	<meta http-equiv="X-UA-Compatible" content="IE=edge" /> <!-- Optimal Internet Explorer compatibility -->
 	


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="css/checkout.css" rel="stylesheet">
    <link href="css/carousel.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ page import = "model.UserBean" %>
	<%@ page import = "model.UserBean.tipoUtente" %>
	<%@ page import = "model.BillDS" %>
	<%@ page import = "model.BillBean" %>
	<%@ page import = "model.Cart" %>
	<%@ page import = "model.GameBean" %>
	<%@ page import = "java.util.ArrayList" %>
	<%@ page import = "javax.sql.DataSource" %>
	<%
		UserBean uBean = (UserBean) request.getSession().getAttribute("userBean");
    	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
    	BillDS bds = new BillDS(ds);
    	BillBean lastBill = bds.doRetrieveByUserID(uBean.getUserID());
    	Cart cart = (Cart) request.getSession().getAttribute("ShoppingCart");
    	if(cart == null) {
    		response.sendRedirect(response.encodeRedirectURL("index.jsp")); // Non andare in questa jsp se il carrello è vuoto
    		return;
    	}
	%>
	

<div class="container">
    <div class="py-5 text-center">
        <img class="d-block mx-auto mb-2" src="gameuppngsfondonero1.png" alt="" width="100" height="100">
        <h2>Checkout form</h2>
    </div>

    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="h3">Il tuo carrello</span>
                <span class="badge badge-secondary badge-pill"><%= cart.getAmountOfGames() %></span>
            </h4>
            <ul class="list-group mb-3">
            	<% ArrayList<GameBean> games = (ArrayList<GameBean>) cart.getGames(); 
            		for(GameBean gBean : games) {
            	%>
            
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0"><%= gBean.getTitle() %></h6>
                        <small class="text-muted"><%= gBean.getShortDescription() %></small>
                    </div>
                    <span class="text-muted">&euro; <%= gBean.getPrice() %></span>
                </li>
                <% } %>
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">Hai un codice sconto?</h6>
                        <small>EXAMPLECODE</small>
                    </div>
                    <span class="text-success">-$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (EUR)</span>
                    <strong>&euro;<%= cart.getTotal() %></strong>
                </li>
            </ul>

            <form class="card p-2">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Promo code">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-primary btn-block">Applica</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Billing address</h4>
            <form class="needs-validation" novalidate>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName">Nome</label>
                        <input type="text" class="form-control" id="firstName" placeholder="" required <%
                        	if(lastBill != null) {
                        %> value="<%=lastBill.getName() %>"
                        
                        <% } %>
                        >
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName">Cognome</label>
                        <input type="text" class="form-control" id="lastName" placeholder="" required <%
                        	if(lastBill != null) {
                        %> value="<%=lastBill.getSurname() %>"
                        
                        <% } %>               
                        >
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email">Email <span class="text-muted">(Optional)</span></label>
                    <input type="email" class="form-control" id="email" placeholder="you@example.com" <%
                        	if(lastBill != null) {
                        %> value="<%=lastBill.getEmail() %>"
                        
                        <% } %>
                        >
                </div>

                <div class="mb-3">
                    <label for="address">Indirizzo</label>
                    <input type="text" class="form-control" id="address" placeholder="1234 Main St" required <%
                        	if(lastBill != null) {
                        %> value="<%=lastBill.getAddress() %>"
                        
                        <% } %>
                        >

                </div>

               
               <div class="mb-3">
                    <label for="zip">CAP</label>
                   <input type="text" class="form-control" id="zip" placeholder="" required <%
                        	if(lastBill != null) {
                        %> value="<%=lastBill.getCAP() %>"
                        
                        <% } %>
                        >
                </div>

                <hr class="mb-4">

                <h4 class="mb-3">Metodo di pagamento</h4>

                <div id="paypal-button-container"></div>
            </form>
        </div>
    </div>


    
</div>

<script src="https://www.paypal.com/sdk/js?client-id=Ad2cJIlZoF_6MquMvgkkQETkQyn7QQxlxicghzoXdu8-Za0VtWYWK4-OFjKs4t9HMlN6WrkfDWzM_YuW&currency=EUR" data-sdk-integration-source="button-factory"></script>
<script>
    paypal.Buttons({
        style: {
            shape: 'pill',
            color: 'blue',
            layout: 'vertical',
            label: 'pay',
            
        },
        createOrder: function(data, actions) {
            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: '<%= cart.getTotal() %>',
                        	breakdown: {
                                item_total: {value: '<%= cart.getTotal() %>',
                                	currency_code: 'EUR'}
                            }
                    },
                    items: [
                    	<%
                    		for(GameBean gb : cart.getGames()) {
                    			%>
                    			{name: "<%= gb.getTitle() %>",
                    			unit_amount: {value: "<%= gb.getPrice() %>", 
                    				currency_code: 'EUR'},
                    			quantity: '1'},
                    			<%
                    		}
                    	%>
                    ]
                    }
            ]});
        },
        onApprove: function(data, actions) {
            return actions.order.capture().then(function(details) {
                alert('Il pagamento è andato a buon fine da ' + details.payer.name.given_name + '!');
            });
        }
    }).render('#paypal-button-container');
</script>


<!-- FOOTER -->
<%@ include file="footer.jsp"%>
</body>