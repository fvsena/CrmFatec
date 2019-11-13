<%@page import="dao.ClienteDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<% 
List<Cliente> clientes = new ArrayList<Cliente>();
if(session.getAttribute("clientes") != null){
	clientes = (List<Cliente>)session.getAttribute("clientes");
}
else {
	clientes = new ClienteDAO().obterClientes();
}
%>
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
		<%@include file='ClienteSelecionado.jsp' %>
		
		<div class="card">
		    <div class="card-body">
		        <a href="Cliente.jsp" class="btn btn-primary">Cadastrar Cliente</a>
		    </div>
		</div>
		
		<form method="POST" action="ListaClientes">
			<table id="ListaClientes" name="ListaClientes" class="table mt-4">
			    <thead class="thead-dark">
			        <th scope="col">Código</th>
			        <th scope="col">Nome</th>
			        <th scope="col">Documento</th>
			        <th scope="col">Data de Nascimento</th>
			        <th scope="col">Gênero</th>
			        <th scope="col">Ação</th>
			    </thead>
			    <tbody>
			    	<% for(Cliente cliente : clientes) {%>
			            <tr>
			                <td><%=cliente.getCodigo() %></td>
			                <td><%=cliente.getNome() %></td>
			                <td><%=cliente.getDocumento() %></td>
			                <td><%=cliente.getDataNascimento().toString()%></td>
			                <td><%=cliente.getGenero() %></td>
			                <td><button type="submit" class="btn btn-primary w-100" name="cmd" value="<%=cliente.getCodigo() %>">Selecionar</button></td>
			            </tr>
					<% } %>
			    </tbody>
			</table>
		</form>
	</div>
	
	<script src="scripts/cliente.js"></script>
</body>
</html>