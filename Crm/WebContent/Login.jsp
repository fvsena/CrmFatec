<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link href="style/Site.css" rel="stylesheet" type="text/css" />
	<link href="style/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script src="scripts/modernizr-2.6.2.js"></script>
    <script src="scripts/jquery-1.10.2.js"></script>
    <script src="scripts/site.js"></script>
	<meta charset="UTF-8">
	<title>CRM Java</title>
</head>
<body>
<body class="p-0">
    <div class="container body-content">
        <div class="card mx-auto my-lg-5 w-50">
            <div class="card-header bg-primary text-white">
                Autenticação - CRM Java
            </div>
            <div class="card-body">
            	<form method="POST" action="Login">
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="Usuario">Usuário</label>
                            <input type="text" name="Login" id="Login" class="form-control mw-100" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-12"">
                            <label for="Usuario">Senha</label>
                            <input type="password" name="Senha" id="Senha" class="form-control mw-100" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-12"">
                            <input type="submit" class="btn btn-primary" value="Logar" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="~/Scripts/site.js"></script>
    <script src="~/Scripts/jquery-1.10.2.min.js"></script>
    <script src="~/Scripts/bootstrap.min.js"></script>
</body>
</html>