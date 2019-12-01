<%@page import="viewmodels.RelatorioContato"%>
<%@page import="dao.ContatoDAO"%>
<%@page import="model.Contato"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<% 
List<RelatorioContato> relatorio = new ArrayList<RelatorioContato>();
if(session.getAttribute("relatorio") != null){
	relatorio = (List<RelatorioContato>)session.getAttribute("relatorio");
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
		
		<div class="card">
		    <div class="card-body">
		    	<form method="POST" action="Relatorio">
		        	<div class="form-group col-md-12">
                        <label for="nome">Data início</label>
                        <input type="date" name="dataInicio" id=""dataInicio"" class="form-control mw-100" />
                    </div>
                    <div class="form-group col-md-12">
                        <label for="nome">Data fim</label>
                        <input type="date" name="dataFim" id="dataFim" class="form-control mw-100" />
                    </div>
                    <div class="form-group col-md-6">
                        <button type="submit" class="btn btn-primary w-100" name="cmd" value="RelatorioContato">Gerar relatório</button>
                    </div>
		        </form>
		    </div>
		</div>
		
			<table id="ListaClientes" name="ListaClientes" class="table mt-4">
			    <thead class="thead-dark">
			        <th scope="col">Data</th>
			        <th scope="col">Nome</th>
			        <th scope="col">Doc.</th>
			        <th scope="col">Genero</th>
			        <th scope="col">Dt. Nascto</th>
			        <th scope="col">Rua</th>
			        <th scope="col">Numero</th>
			        <th scope="col">Bairro</th>
			        <th scope="col">Cidade</th>
			        <th scope="col">UF</th>
			        <th scope="col">Detalhe</th>
			        <th scope="col">Agente</th>
			    </thead>
			    <tbody>
			    	<% for(RelatorioContato r : relatorio) {%>
			            <tr>
			                <td><%=r.getDataContato() %></td>
			                <td><%=r.getNome() %></td>
			                <td><%=r.getDocumento() %></td>
			                <td><%=r.getGenero() %></td>
			                <td><%=r.getDataNascimento() %></td>
			                <td><%=r.getLogradouro() %></td>
			                <td><%=r.getNumero() %></td>
			                <td><%=r.getBairro() %></td>
			                <td><%=r.getCidade() %></td>
			                <td><%=r.getUf() %></td>
			                <td><%=r.getDetalhe() %></td>
			                <td><%=r.getNomeAgente() %></td>
			            </tr>
					<% } %>
			    </tbody>
			</table>
	</div>
	
	<script src="scripts/cliente.js"></script>
</body>
</html>