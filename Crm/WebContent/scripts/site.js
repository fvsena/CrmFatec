$('#cep').blur(function () {
	console.log("Metodo acionado");
    value = this.value;
    $.ajax({
        type: "GET",
        url: "https://viacep.com.br/ws/" + value + "/json/",
        context: document.body,
        contentType: "application/json; charset=utf-8"
    }).done(function (data) {
        $("#logradouro").val(data.logradouro);
        $("#bairro").val(data.bairro);
        $("#cidade").val(data.localidade);
        $("#uf").val(data.uf);
    })
});

$('#fone').mask('0000-00009');
$('#fone').blur(function(event) {
   if($(this).val().length == 10){
      $('#fone').mask('00000-0009');
   } else {
      $('#fone').mask('0000-00009');
   }
});