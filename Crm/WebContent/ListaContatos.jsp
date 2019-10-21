<%@page import="dao.ContatoDAO"%>
<%@page import="model.Contato"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<% 
List<Contato> contatos = new ArrayList<Contato>();
if(session.getAttribute("contatos") != null){
	contatos = (List<Contato>)session.getAttribute("contatos");
}
else {
	int codigoCliente = Integer.parseInt(session.getAttribute("idCliente").toString());
	contatos = new ContatoDAO().obterContatos(codigoCliente);
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
		        <a href="Contato.jsp" class="btn btn-primary">Novo Contato</a>
		    </div>
		</div>
		
			<table id="ListaClientes" name="ListaClientes" class="table mt-4">
			    <thead class="thead-dark">
			        <th scope="col">#</th>
			        <th scope="col">Agente</th>
			        <th scope="col">Data</th>
			        <th scope="col">Detalhe</th>
			    </thead>
			    <tbody>
			    	<% for(Contato contato : contatos) {%>
			            <tr>
			                <td><%=contato.getCodigo() %></td>
			                <td><%=contato.getNomeAgente() %></td>
			                <td><%=contato.getDataContato().toString() %></td>
			                <td><%=contato.getDetalhe()%></td>
			            </tr>
					<% } %>
			    </tbody>
			</table>
	</div>
	
	<script src="scripts/cliente.js"></script>
</body>
</html>