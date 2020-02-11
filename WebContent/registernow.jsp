<!doctype html>
<html lang="it">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">

    <title>Registrazione Utente</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/registernow.css" rel="stylesheet">
    <link href="css/carousel.css" rel="stylesheet">
</head>

<body style="padding-top:0">
 <%@ include file="header.jsp"%>

    <div class="text-center">
        <img class="d-block mx-auto mb-2" src="gameuppngsfondonero1.png" alt="" width="100" height="100">
        <h2 class="h2">Registrati</h2>
        <p class="lead">Compila i campi per registrarti</p>
    </div>

  <div class="container">
        <div class="col-12 order-md-1">
            <form id="registerForm" class="needs-validation" action="Register" method="post" novalidate>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName" class="lb">Nome</label>
                        <input name="nome" type="text" class="form-control" id="firstName" placeholder="Nome" value="" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName">Cognome</label>
                        <input name="cognome" type="text" class="form-control" id="lastName" placeholder="Cognome" value="" required>
                        <div class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="username">Username</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">@</span>
                        </div>
                        <input name="username" type="text" class="form-control" id="username" placeholder="Username" required>
                        <div class="invalid-feedback" style="width: 100%;"></div>

                    </div>
                </div>

                <div class="mb-3">
                    <label for="password">Password</label>
                    <input name="password" type="password" class="form-control" id="password" placeholder="password" required>
                    <div class="invalid-feedback" style="width: 100%;"></div>
                </div>

                <div class="mb-3">
                    <label for="email">Email<span class="text-muted"></span></label>
                    <input name="email" type="email" class="form-control" id="email" placeholder="you@example.com" required>
                    <div class="invalid-feedback"></div>
                </div>

                <div class="mb-3">
                    <label for="indirizzo">Indirizzo <span class="text-muted"></span></label>
                    <input name="indirizzo" type="text" class="form-control" id="indirizzo" placeholder="corso trieste,227" required>
                    <div class="invalid-feedback"></div>
                </div>

                <div class="mb-3">
                    <label for="citta">Città <span class="text-muted"></span></label>
                    <input name="citta" type="text" class="form-control" id="citta" placeholder="Caserta" required>
                    <div class="invalid-feedback"></div>
                </div>

                <div class="mb-3">
                    <label for="cap">CAP<span class="text-muted"></span></label>
                    <input name="cap" type="text" class="form-control" id="cap" placeholder="81100" required>
                    <div class="invalid-feedback"></div>
                </div>

                <div class="mb-3">
                    <label for="developer">Sei uno sviluppatore?<span class="text-muted"></span></label><br>
                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                        <label class="btn btn-secondary ">
                            <input type="radio" name="developer" id="developeryes" value="1" autocomplete="off" checked> SI
                        </label>
                        <label class="btn btn-secondary active">
                            <input type="radio" name="developer" id="developerno" value="0" autocomplete="off"> NO
                        </label>
                    </div>
                </div>
                <hr class="mb-4">
                <button class="btn btn-primary btn-lg btn-block" type="submit">Registrati ora</button>
            </form>
        </div>
    </div>

    <footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; 2017-2018 Company Name</p>
        <ul class="list-inline">
            <li class="list-inline-item"><a href="#">Privacy</a></li>
            <li class="list-inline-item"><a href="#">Terms</a></li>
            <li class="list-inline-item"><a href="#">Support</a></li>
        </ul>
    </footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')
    </script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/form_validation.js"></script>
    <script src="js/register_validation.js"></script>
    <script src="js/signin_validation.js"></script>
</body>
</html>