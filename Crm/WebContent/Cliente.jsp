<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="style/Site.css" rel="stylesheet" type="text/css" />
	<link href="style/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script src="scripts/modernizr-2.6.2.js"></script>
    <script src="scripts/jquery-1.10.2.js"></script>
    <script src="scripts/site.js"></script>
	<meta charset="UTF-8">
	<title>CRM</title>
</head>
<body>
	<%@include file='Menu.jsp' %>
	
	<div class="container body-content mt-4">
		<div class="accordion">
		    <div class="card mt-4">
		        <div class="card-header bg-primary text-white">
		            <span class="collapsed" data-toggle="collapse" data-target="#cadastroCliente" aria-expanded="false" aria-controls="cadastroCliente" >Cadastro de Cliente</span>
		        </div>
		
		        <div class="card-body" id="cadastroCliente">
		        	<form method="POST" action="Cliente">
		                <div class="form-row p-2">
		                    <div class="form-group col-md-12">
		                        <label for="nome">Nome do cliente</label>
		                        <input type="text" name="nome" id="nome" class="form-control mw-100" placeholder="Nome do cliente" />
		                    </div>
		                </div>
		                <div class="form-row p-2">
		                    <div class="form-group col-md-2">
		                        <label for="documento">Número do documento</label>
		                        <input type="text" name="documento" id="documento" class="form-control mw-100" placeholder="Documento" />
		                    </div>
		                    <div class="form-group col-md-2">
		                        <label for="dataNascimento">Data de nascimento</label>
		                        <input type="date" name="dataNascimento" id="dataNascimento" class="form-control mw-100" placeholder="Nascimento" />
		                    </div>
		                    <div class="form-group col-md-2">
		                        <label for="genero">Gênero</label>
		                        <select class="form-control w-auto" id="genero" name="genero">
		                            <option id="M" value="M">M</option>
		                            <option id="F" value="F">F</option>
		                        </select>
		                    </div>
		                </div>
		                <div class="form-row p-2">
		                    <div class="form-group col-md-6">
		                        <button type="reset" class="btn btn-warning w-100">Limpar Campos</button>
		                    </div>
		                    <div class="form-group col-md-6">
		                        <button type="submit" class="btn btn-primary w-100" name="cmd" value="GravarCliente">Gravar Cliente</button>
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
	</div>
	
	<script src="scripts/cliente.js"></script>
</body>
</html>