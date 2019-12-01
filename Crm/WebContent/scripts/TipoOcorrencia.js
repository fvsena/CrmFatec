$('#grupos_detalhe').change(function () {
	console.log("Atualizando sub grupos");
    var select = document.getElementById("grupos_detalhe");
    var index = select.selectedIndex;
    var value = select[index].value;

    $.ajax({
        type: "GET",
        url: "TipoOcorrencia?cmd=subgrupo&grupo="+value,
        contentType: "application/json; charset=utf-8"
    }).done(function (data) {
    	console.log(data);
        var json = JSON.parse(JSON.stringify(data));
        $("#subGrupos").find('option').remove().end();
        $.each(json, function () {
            $("#subGrupos").append(new Option(this.descricao, this.codigo));
        });
    });
});