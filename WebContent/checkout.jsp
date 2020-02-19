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
	<%@ page import = "javax.sql.DataSource" %>
	<%
		UserBean uBean = (UserBean) request.getSession().getAttribute("userBean");
    	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
    	BillDS bds = new BillDS(ds);
    	BillBean lastBill = bds.doRetrieveByUserID(uBean.getUserID());
	%>
	
	
	
	<div id="paypal-button-container"></div>

<div class="container">
    <div class="py-5 text-center">
        <img class="d-block mx-auto mb-2" src="gameuppngsfondonero1.png" alt="" width="100" height="100">
        <h2>Checkout form</h2>
    </div>

    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="h3">Il tuo carrello</span>
                <span class="badge badge-secondary badge-pill">3</span>
            </h4>
            <ul class="list-group mb-3">
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Product name</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$12</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Second product</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$8</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Third item</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">Hai un codice sconto?</h6>
                        <small>EXAMPLECODE</small>
                    </div>
                    <span class="text-success">-$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (USD)</span>
                    <strong>$20</strong>
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

                <div class="d-block my-3">
                    <div class="custom-control custom-radio">
                        <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked required>
                        <label class="custom-control-label" for="credit">Credit card</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="debit" name="paymentMethod" type="radio" class="custom-control-input" required>
                        <label class="custom-control-label" for="debit">Debit card</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required>
                        <label class="custom-control-label" for="paypal">PayPal</label>
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="cc-name">Intestatario della carta</label>
                        <input type="text" class="form-control" id="cc-name" placeholder="" required>
                        <small class="text-muted">Full name as displayed on card</small>
                        <div class="invalid-feedback">
                            Name on card is required
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="cc-number">Numero carta</label>
                        <input type="text" class="form-control" id="cc-number" placeholder="" required>
                        <div class="invalid-feedback">
                            Credit card number is required
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="cc-expiration">Data di scadenza</label>
                        <input type="text" class="form-control" id="cc-expiration" placeholder="" required>
                        <div class="invalid-feedback">
                            Expiration date required
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="cc-cvv">CVV</label>
                        <input type="text" class="form-control" id="cc-cvv" placeholder="" required>
                        <div class="invalid-feedback">
                            Security code required
                        </div>
                    </div>
                </div>
                <hr class="mb-4">
                <button class="btn btn-primary btn-lg btn-block" type="submit">Continue to checkout</button>
            </form>
        </div>
    </div>


    
</div>



<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<script>
  paypal.Button.render({
    // Configure environment
    env: 'sandbox',
    client: {
      sandbox: 'demo_sandbox_client_id',
      production: 'demo_production_client_id'
    },
    // Customize button (optional)
    locale: 'en_US',
    style: {
      size: 'small',
      color: 'gold',
      shape: 'pill',
    },

    // Enable Pay Now checkout flow (optional)
    commit: true,

    // Set up a payment
    payment: function(data, actions) {
      return actions.payment.create({
        transactions: [{
          amount: {
            total: '0.01',
            currency: 'USD'
          }
        }]
      });
    },
    // Execute the payment
    onAuthorize: function(data, actions) {
      return actions.payment.execute().then(function() {
        // Show a confirmation message to the buyer
        window.alert('Thank you for your purchase!');
      });
    }
  }, '#paypal-button-container');

</script>

	<script
		src="https://www.paypal.com/sdk/js?client-id=Ad2cJIlZoF_6MquMvgkkQETkQyn7QQxlxicghzoXdu8-Za0VtWYWK4-OFjKs4t9HMlN6WrkfDWzM_YuW"> // Required. Replace SB_CLIENT_ID with your sandbox client ID.
	</script>

<!-- FOOTER -->
<%@ include file="footer.jsp"%>
</body>