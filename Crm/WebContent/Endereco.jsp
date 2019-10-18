<%@page import="model.Endereco"%>
<% 
Endereco endereco = new Endereco();
if(session.getAttribute("endereco") != null){
	endereco = (Endereco)session.getAttribute("endereco");
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
		            <span class="collapsed" data-toggle="collapse" data-target="#cadastroEndereco" aria-expanded="false" aria-controls="cadastroEndereco">Cadastro de Endereço</span>
		        </div>
		        <div class="card-body" id="cadastroEndereco">
		        	<form method="POST" action="Endereco">
		                <div class="form-row p-2">
		                    <div class="form-group col-md-2">
		                        <label for="cep">CEP</label>
		                        <input type="text" class="form-control mw-100" id="cep" name="cep" value="<%=endereco.getCep() %>" />
		                    </div>
		                    <div class="form-group col-md-6">
		                        <label for="logradouro">Logradouro</label>
		                        <input type="text" class="form-control mw-100" id="logradouro" name="logradouro" value="<%=endereco.getLogradouro() %>"/>
		                    </div>
		                    <div class="form-group col-md-2">
		                        <label for="numero">Número</label>
		                        <input type="text" class="form-control mw-100" id="numero" name="numero" value="<%=endereco.getNumero() %>"/>
		                    </div>
		                    <div class="form-group col-md-2">
		                        <label for="complemento">Complemento</label>
		                        <input type="text" class="form-control mw-100" id="complemento" name="complemento" value="<%=endereco.getComplemento() %>"/>
		                    </div>
		                </div>
		                <div class="form-row p-2">
		                    <div class="form-group col-md-6">
		                        <label for="bairro">Bairro</label>
		                        <input type="text" class="form-control mw-100" id="bairro" name="bairro" value="<%=endereco.getBairro() %>"/>
		                    </div>
		                    <div class="form-group col-md-4">
		                        <label for="cidade">Cidade</label>
		                        <input type="text" class="form-control mw-100" id="cidade" name="cidade" value="<%=endereco.getCidade() %>"/>
		                    </div>
		                    <div class="form-group col-md-2">
		                        <label for="uf">UF</label>
		                        <input type="text" class="form-control mw-100" id="uf" name="uf" value="<%=endereco.getUf() %>"/>
		                    </div>
		                </div>
		                <div class="form-row p-2">
		                    <div class="form-group col-md-6">
		                        <button type="reset" class="btn btn-warning w-100">Limpar Campos</button>
		                    </div>
		                    <div class="form-group col-md-6">
		                    	<button type="submit" class="btn btn-primary w-100" name="cmd" value="GravarEndereco">Gravar Endereço</button>
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