$(document).ready(function() {	

	var tabela = document.getElementById("dados_inscricao");
	var primeira_linha = tabela.insertRow(0);	
	
	$.ajaxSetup({ cache: false });
	$.getJSON('dados_inscricao.php', function(data) {
		
		if(data == null){
		
			primeira_linha.className = 'td_palestra';
			var primeira_coluna = primeira_linha.insertCell(0);
			primeira_coluna.innerHTML = "Não há evento cadastrado neste momento";
		
		}else{
		
			primeira_linha.className = 'td_painel1';
			var primeira_coluna = primeira_linha.insertCell(0);
			primeira_coluna.className = 'td_painel1';
	
			primeira_coluna.innerHTML = "Categoria";
	
			datas_inscricao_pagamento = data.datas_inscricao_pagamento;
			tipos_profissionais =  data.tipos_profissionais;
			data_evento = data.data_evento;
		
			for(i=0;i < datas_inscricao_pagamento.length;i++){
				coluna_data_inscricao = primeira_linha.insertCell(-1);
			
				if(datas_inscricao_pagamento[i] == data_evento)
					coluna_data_inscricao.innerHTML = "No dia do evento";
				else
					coluna_data_inscricao.innerHTML = "Até " + datas_inscricao_pagamento[i];
				
				
			}
		
		for(i=0;i < tipos_profissionais.length;i++){
		
			linha_categoria_valores = tabela.insertRow(-1);
			linha_categoria_valores.className = 'td_palestra';
			
			coluna_tipo_profissional = linha_categoria_valores.insertCell(0);			
			coluna_tipo_profissional.innerHTML = tipos_profissionais[i].nome;
			
			idTipoInscricao = tipos_profissionais[i].idTipoInscricao;			
			valores = tipos_profissionais[i].valores;			
			
			for(j=0;j<valores.length;j++){
			
				valor =  "R$ " + tipos_profissionais[i].valores[j];	
			
				coluna_valores = linha_categoria_valores.insertCell(-1);
				coluna_valores.innerHTML = (tipos_profissionais[i].valores[j] == "0,00")?"R$ 0,00":valor;
							
				idDataInscricao = tipos_profissionais[i].idDataInscricao[j];
				
				if(datas_inscricao_pagamento[j]!=data_evento && j == 0){
				
					coluna_acoes = tabela.getElementsByTagName("tr")[i+1].getElementsByTagName("td")[j+1];
					coluna_acoes.style.cursor = "pointer";
					coluna_acoes.style.textDecoration = 'underline';
					coluna_acoes.style.color='#1E90FF';
					coluna_acoes.setAttribute("onClick","Show_Popup(" + idDataInscricao + "," + idTipoInscricao + ")");

				}				
				
			}	
			
		}
		
		}
		
	});

document.form_inscricao.CPF.disabled = true;
document.form_inscricao.CPF.value = '';
document.form_inscricao.conhecimento_OUTROSQUAL.disabled = true;

$("input[type=radio][name=emissao_em_nome]").click(function() {

	if($('input[type=radio][name=emissao_em_nome]:eq(1)').is(':checked')){		
		document.form_inscricao.CPF.disabled = false;
	}else{	
		document.form_inscricao.CPF.disabled = true;
		document.form_inscricao.CPF.value = '';						
	}
	
});
  
$("input[name='conhecimento_OUTROS']").click(function() {
	
	if($('input[type=checkbox][name=conhecimento_OUTROS]').is(':checked')){		
		document.form_inscricao.conhecimento_OUTROSQUAL.disabled = false;
	}else{	
		document.form_inscricao.conhecimento_OUTROSQUAL.disabled = true;
		document.form_inscricao.conhecimento_OUTROSQUAL.value = '';						
	}
	
});
		
});	

function Show_Popup(idDataInscricao,idTipoInscricao) {

	var altura = $(document).height();
	var largura = $(document).width();
	
	var winH = $(window).height();
	var winW = $(window).width();
	
	$('#popup').css('left', winW/2-$('#popup').width()/2);
	
	$('#popup').css({'width':largura,'height':altura});
	$('#popup').css('display','block');	
	
	switch(idTipoInscricao){
	
		case 1:
			$('#cliente_cte_ativo').css('display','none');
			$('#entidade').css('display','none');
			$("input[name='clienteAtivo'][value='N']").attr('checked','checked');
		break;
		
		case 2:
			$("input[name='clienteAtivo'][value='S']").attr('checked','checked');
			$("input[name='clienteAtivo']").attr('disabled','disabled');
			$('#cliente_cte_ativo').removeAttr("style");
			$('#entidade').removeAttr("style");
		break;
		
		case 3:
			$("input[name='clienteAtivo'][value='N']").attr('checked','checked');
			$('#cliente_cte_ativo').css('display','none');
			$('#entidade').removeAttr("style");
		break;
	
	}

	document.forms[0].idDataInscricao.value = idDataInscricao;
	document.forms[0].idTipoInscricao.value = idTipoInscricao;
		
}

function Close_Popup() {
	$('#popup').css('display','none');
}

function abrePopUP(link){
	window.open(link,'link','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=800');
}

function validaCampos(){


	if($.trim($("input[name='nome']").val()) == ''){		
		alert('O campo "Nome" é de preenchimento obrigatório.');					
		$("input[name='nome']").focus();
		return false;
	}
	
	if($.trim($("input[name='nome_cracha']").val()) == ''){							
		alert('O campo "Nome para crachá" é de preenchimento obrigatório.');					
		$("input[name='nome_cracha']").focus();
		return false;
	}
	
	if($.trim($("input[name='email']").val()) == ''){							
		alert('O campo "E-mail" é de preenchimento obrigatório.');					
		$("input[name='email']").focus();
		return false;
	}else if(!validaEmail($("input[name='email']").val())){
		alert('Email Inválido');					
		$("input[name='email']").focus();
		return false;
	}
	
	if($.trim($("input[name='profissao']").val()) == ''){							
		alert('O campo "Profissão" é de preenchimento obrigatório.');					
		$("input[name='profissao']").focus();
		return false;
	}
	
	if($.trim($("input[name='cargo']").val()) == ''){							
		alert('O campo "Cargo" é de preenchimento obrigatório.');					
		$("input[name='cargo']").focus();
		return false;
	}
	
	if($.trim($("input[name='empresa']").val()) == ''){							
		alert('O campo "Empresa" é de preenchimento obrigatório.');					
		$("input[name='empresa']").focus();
		return false;
	}
	
	if($.trim($("input[name='CNPJ']").val()) == ''){							
		alert('O campo "CNPJ" é de preenchimento obrigatório.');					
		$("input[name='CNPJ']").focus();
		return false;
	}else if(!validaCNPJ($("input[name='CNPJ']").val())){
		alert('CNPJ inválido');					
		$("input[name='CNPJ']").focus();
		return false;
	}
	
	if($.trim($("input[name='inscricao_estadual']").val()) == ''){							
		alert('O campo "Inscrição Estadual" é de preenchimento obrigatório.');					
		$("input[name='inscricao_estadual']").focus();
		return false;
	}
	
	if($.trim($("input[name='endereco']").val()) == ''){							
		alert('O campo "Endereço é de preenchimento obrigatório.');					
		$("input[name='endereco']").focus();
		return false;
	}
	
	if($.trim($("input[name='numero']").val()) == ''){							
		alert('O campo "Nº" é de preenchimento obrigatório.');					
		$("input[name='numero']").focus();
		return false;
	}
	
	if($.trim($("input[name='bairro']").val()) == ''){							
		alert('O campo "Bairro" é de preenchimento obrigatório.');					
		$("input[name='bairro']").focus();
		return false;
	}
	
	if($.trim($("input[name='cidade']").val()) == ''){							
		alert('O campo "Cidade" é de preenchimento obrigatório.');					
		$("input[name='cidade']").focus();
		return false;
	}
	
	if($.trim($("input[name='estado']").val()) == ''){							
		alert('O campo "Estado" é de preenchimento obrigatório.');					
		$("input[name='estado']").focus();
		return false;
	}
	
	if($.trim($("input[name='cep']").val()) == ''){							
		alert('O campo "CEP" é de preenchimento obrigatório.');					
		$("input[name='cep']").focus();
		return false;
	}
	
	if($.trim($("input[name='ddd']").val()) == ''){							
		alert('O campo "DDD" é de preenchimento obrigatório.');					
		$("input[name='ddd']").focus();
		return false;
	}
		
	if($.trim($("input[name='telefone']").val()) == ''){							
		alert('O campo "Telefone" é de preenchimento obrigatório.');					
		$("input[name='telefone']").focus();
		return false;
	}
	
	if(!$("input[name='emissao_tipo_comprovante']").is(':checked')){							
		alert('O campo "Emissão de recibo ou Nota Fiscal" é de preenchimento obrigatório.');					
		$("input[name='emissao_tipo_comprovante']").focus();
		return false;
	}
	
	if(!$('input[type=radio][name=emissao_em_nome]').is(':checked')){
		alert('O campo "Emissão em nome de" é de preenchimento obrigatório.');					
		$('input[type=radio][name=emissao_em_nome]').focus();	
		return false;
	}
	
	if(($.trim($("input[name='CPF']").val()) == '') && ($('input[type=radio][name=emissao_em_nome]:eq(1)').is(':checked'))){
		alert('O campo "CPF" é de preenchimento obrigatório, quando selecionado opção "participante".');					
		$("input[name='CPF']").focus();
		return false;
	}else if(($.trim($("input[name='CPF']").val()) != '')){
		if(!validaCPF($("input[name='CPF']").val())){
			alert('CPF inválido');					
			$("input[name='CPF']").focus();
			return false;
		}
	}
		
	if(!$("input[name='clienteAtivo']").is(':checked')){							
		alert('O campo "Cliente CTE Ativo" é de preenchimento obrigatório.');					
		$("input[name='clienteAtivo']").focus();
		return false;
	}
	
	if(!$("input[name='informativo']").is(':checked')){
		alert('O campo "Deseja receber os informativos do CTE" é de preenchimento obrigatório.');					
		$("input[name='informativo']").focus();
		return false;
	}

	if(!$("input[name='forma_pagamento']").is(':checked')){							
		alert('O campo "Assinale a forma de pagamento" é de preenchimento obrigatório.');					
		$("input[name='forma_pagamento']").focus();
		return false;
	}
		
	
}
