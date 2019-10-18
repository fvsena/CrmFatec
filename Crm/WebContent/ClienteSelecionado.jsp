<% 
String id = "";
if(session.getAttribute("idCliente") != null){
	id = session.getAttribute("idCliente").toString();
}
String nome = "";
if(session.getAttribute("nomeCliente") != null){
	nome = session.getAttribute("nomeCliente").toString();
}
%>

<div class="card">
	<div class="card-header bg-primary text-white">
		Cliente Selecionado
	</div>
	<div class="card-body">
		<table class="table border-0">
			<thead>
				<th scope="col">C�digo</th>
				<th scope="col">Nome</th>
				<th scope="col">A��o</th>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" id="codigoSelecionado" value="<%=id%>" disabled/></td>
					<td><input type="text" class="form-control" id="nomeSelecionado" value="<%=nome%>" disabled/></td>
					<td><input type="button" class="btn btn-warning" id="acaoSelecionado" value="Remover Sele��o" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>