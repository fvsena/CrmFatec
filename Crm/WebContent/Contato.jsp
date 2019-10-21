<%@page import="model.Telefone"%>
<% 
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="style/Site.css" rel="stylesheet" type="text/css" />
	<link href="style/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script src="/scripts/modernizr-2.6.2.js"></script>
    <script src="/scripts/jquery-1.10.2.js"></script>
    <script src="/scripts/site.js"></script>
	<meta charset="UTF-8">
	<title>CRM</title>
</head>
<body>
	<%@include file='Menu.jsp' %>
	
	<div class="container body-content mt-4">
		<%@include file='ClienteSelecionado.jsp' %>
		<div class="accordion">
		    <div class="card mt-4">
		        <div class="card-header bg-primary text-white">
		            <span data-toggle="collapse" data-target="#novoContato" aria-expanded="true" aria-controls="novoContato">
		                Novo Contato
		            </span>
		        </div>
		        <div class="card-body" id="novoContato">
		        	<form method="POST" action="Contato">
		                <div class="form-row">
		                    <div class="form-group col-12">
		                        <label for="detalhe">Detalhe do contato:</label>
		                        <textarea name="detalhe" id="detalhe" class="form-control mw-100"></textarea>
		                    </div>
		                </div>
		                <div class="form-row">
		                    <div class="form-group col-md-4">
		                        <input type="submit" class="btn btn-primary" value="Gravar Contato" />
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
	</div>
	<script src="scripts/modernizr-2.6.2.js"></script>
    <script src="scripts/jquery-1.10.2.js"></script>
    <script src="scripts/site.js"></script>
	<script src="scripts/cliente.js"></script>
</body>
</html>