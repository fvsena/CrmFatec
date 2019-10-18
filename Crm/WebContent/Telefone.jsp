<%@page import="model.Telefone"%>
<% 
Telefone telefone = new Telefone();
if(session.getAttribute("telefone") != null){
	telefone = (Telefone)session.getAttribute("telefone");
}
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
		            <span class="collapsed" data-toggle="collapse" data-target="#cadastroTelefone" aria-expanded="false" aria-controls="cadastroTelefone">Cadastro de Telefone</span>
		        </div>
		        <div class="card-body" id="cadastroTelefone">
		        	<form method="POST" action="Telefone">
		                <div class="form-row p-2">
		                    <div class="form-group col-md-2">
		                        <label for="ddd">DDD</label>
		                        <input type="text" class="form-control mw-100" id="ddd" name="ddd" maxlength="2" value="<%=telefone.getDdd() %>" />
		                    </div>
		                    <div class="form-group col-md-6">
		                        <label for="fone">Fone</label>
		                        <input type="text" class="form-control mw-100" id="fone" name="fone" maxlength="9" value="<%=telefone.getFone() %>"/>
		                    </div>
		                </div>
		                <div class="form-row p-2">
		                    <div class="form-group col-md-6">
		                        <button type="reset" class="btn btn-warning w-100">Limpar Campos</button>
		                    </div>
		                    <div class="form-group col-md-6">
		                    	<button type="submit" class="btn btn-primary w-100" name="cmd" value="GravarTelefone">Gravar Telefone</button>
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