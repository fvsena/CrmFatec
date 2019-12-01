<%@page import="java.util.ArrayList"%>
<%@page import="model.GrupoOcorrencia"%>
<%@page import="java.util.List"%>
<% 
	List<GrupoOcorrencia> grupos = new ArrayList<GrupoOcorrencia>();
	if(request.getSession().getAttribute("grupos") != null){
		grupos = (List<GrupoOcorrencia>)request.getSession().getAttribute("grupos");
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
		<div class="accordion">
		    <div class="card mt-4">
		        <div class="card-header bg-primary text-white">
		            <span data-toggle="collapse" data-target="#grupoOcorrencia" aria-expanded="false" aria-controls="grupoOcorrencia">Grupo de Ocorrência</span>
		        </div>
		        <div class="card-body" id="grupoOcorrencia">
		        	<form method="POST" action="TipoOcorrencia">
		                <div class="form-row">
		                    <div class="form-group col-12">
		                        <label for="Grupo">Grupo</label>
		                        <input type="text" class="form-control mw-100" id="grupo" name="grupo">
		                    </div>
		                </div>
		                <div class="form-row">
		                    <div class="form-group col-4">
		                        <input type="submit" name="cmd" value="GravarGrupo" class="btn btn-primary" />
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		
		<div class="accordion">
		    <div class="card mt-4">
		        <div class="card-header bg-primary text-white">
		            <span data-toggle="collapse" data-target="#subGrupoOcorrencia" aria-expanded="false" aria-controls="subGrupoOcorrencia">Sub Grupo de Ocorrência</span>
		        </div>
		        <div class="card-body" id="subGrupoOcorrencia">
		        	<form method="POST" action="TipoOcorrencia">
		                <div class="form-row">
		                    <div class="form-group col-6">
		                        <label for="grupos">Grupo</label>
		                        <select class="form-control mw-100" id="grupos" name="grupos">
		                            <option value="0">--Selecione--</option>
		                            <% for(GrupoOcorrencia g : grupos) {%>
							            <option value="<%=g.getCodigo() %>">
							            	<%=g.getDescricao()%>
							            </option>
									<% } %>
		                        </select>
		                    </div>
		                    <div class="form-group col-6">
		                        <label for="SubGrupo">Sub Grupo</label>
		                        <input type="text" class="form-control mw-100" id="subGrupo" name="subGrupo">
		                    </div>
		                </div>
		                <div class="form-row">
		                    <div class="form-group col-4">
		                        <input type="submit" name="cmd" value="GravarSubGrupo" class="btn btn-primary" />
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		
		<div class="accordion">
		    <div class="card mt-4">
		        <div class="card-header bg-primary text-white">
		            <span data-toggle="collapse" data-target="#detalheOcorrencia" aria-expanded="false" aria-controls="detalheOcorrencia">Detalhe de Ocorrência</span>
		        </div>
		        <div class="card-body" id="detalheOcorrencia">
		            <form method="POST" action="TipoOcorrencia">
		                <div class="form-row">
		                    <div class="form-group col-4">
		                        <label for="grupos_detalhe">Grupo</label>
		                        <select class="form-control mw-100" id="grupos_detalhe" name="grupos_detalhe">
		                            <option value="0">--Selecione--</option>
		                            <% for(GrupoOcorrencia g : grupos) {%>
							            <option value="<%=g.getCodigo() %>">
							            	<%=g.getDescricao()%>
							            </option>
									<% } %>
		                        </select>
		                    </div>
		                    <div class="form-group col-4">
		                        <label for="subGrupos">SubGrupo</label>
		                        <select class="form-control mw-100" id="subGrupos" name="subGrupos">
		                            <option value="0">--Selecione--</option>
		                        </select>
		                    </div>
		                    <div class="form-group col-4">
		                        <label for="Detalhe">Detalhe Ocorrência</label>
		                        <input type="text" class="form-control mw-100" id="detalhe" name="detalhe">
		                    </div>
		                </div>
		                <div class="form-row">
		                    <div class="form-group col-4">
		                        <input type="submit" name="cmd" value="GravarDetalhe" class="btn btn-primary" />
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
	</div>
    <script src="scripts/TipoOcorrencia.js"></script>

</body>
</html>