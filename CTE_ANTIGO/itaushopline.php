<?

	//Exibicao de erros. Notificacoes naoo sao exibidas
	error_reporting(E_ALL ^ E_NOTICE ^ E_DEPRECATED);	
	
	// Chama as classes	
	header("Content-Type: text/html; charset=ISO-8859-1",true);

	require "../../class/database.class.php";
	require "../../class/itaucripto.class.php";
	require "../../class/uteis.class.php";
	require "../../phpmailer/class.phpmailer.php";
	
	$db = new dataBase;
	$oUt = new Uteis;
	$mail = new PHPMailer();
	
	$nome 						= $_POST['nome'];
	$cracha 					= $_POST['nome_cracha'];
	$email 						= $_POST['email'];
	$profissao 					= $_POST['profissao'];
	$cargo 						= $_POST['cargo'];
	$empresa 					= $_POST['empresa'];
	$cnpj 						= $_POST['CNPJ'];
	$inscricao_estadual 		= $_POST['inscricao_estadual'];
	$endereco 					= $_POST['endereco'];
	$numero 					= $_POST['numero'];
	$complemento 				= $_POST['complemento'];
	$bairro						= $_POST['bairro'];
	$cidade 					= $_POST['cidade'];
	$estado 					= $_POST['estado'];
	$cep 						= $_POST['cep'];
	$ddd 						= $_POST['ddd'];
	$telefone 					= $_POST['telefone'];
	$emissao_tipo_comprovante   = $_POST['emissao_tipo_comprovante'];
	$recibo_EMPRESA 			= ($_POST['emissao_em_nome'] == 'E')?"S":"N";
	$recibo_PARTICIPANTE		= ($_POST['emissao_em_nome'] == 'P')?"S":"N";
	$cpf						= (isset($_POST['CPF']))?$_POST['CPF']:"";
	$clienteAtivo               = ($_POST["idTipoInscricao"] == 2)?'Sim':'Não';
	$conhecimento_BOLETIM		= (isset($_POST['conhecimento_BOLETIM']))?$_POST['conhecimento_BOLETIM']:"";
	$conhecimento_SITECTE		= (isset($_POST['conhecimento_SITECTE']))?$_POST['conhecimento_SITECTE']:"";
	$conhecimento_REVISTA		= (isset($_POST['conhecimento_REVISTA']))?$_POST['conhecimento_REVISTA']:"";
	$conhecimento_OUTROS		= (isset($_POST['conhecimento_OUTROS']))?$_POST['conhecimento_OUTROS']:"";
	$conhecimento_OUTROSQUAL	= (isset($_POST['conhecimento_OUTROSQUAL']))?$_POST['conhecimento_OUTROSQUAL']:"";
	$informativo 				= (isset($_POST['informativo']))?$_POST['informativo']:"";
	$entidade 					= (isset($_POST['entidade']))?$_POST['entidade']:"";
	//$formaPagamento            =  ;
	$forma_pagamento 			= $_POST['formaPagamentoFinal'];
	$tipo_comprovante 			= ($_POST['emissaoComprovanteFinal'] == 'R') ?"Recibo":"Nota Fiscal";	
	$ip							= $_SERVER['REMOTE_ADDR'];
	$data_envio					= date('d/m/Y - H:i:s');
	
	//print_r($_POST);
	
	$idPedido = $_POST["idPedido"];
	$valorFinal = $_POST["valorFinalInscricao"];
	$idDataInscricao = $_POST["idDataInscricao"];
	$idTipoInscricao = $_POST["idTipoInscricao"];
	
	$cnpj_grava = str_replace(array("/",".","-"),"",$cnpj);
	$cep_grava = str_replace("-","",$cep);
	$cpf_grava = str_replace(array(".","-"),"",$cpf);
	
	//Inserir dados na parte de pagamentos
	
	$query_inserir_pagamento = "INSERT INTO cte_evento_financeiro(idPedido,valor,forma_pagamento,data_vencimento,data_cadastro)VALUES($idPedido,$valorFinal,'$forma_pagamento',DATE_ADD(NOW(),INTERVAL (SELECT IF(DATEDIFF(data_inscricao,NOW()) < 5,DATEDIFF(data_inscricao,NOW()),5) AS diferenca FROM cte_evento_data_inscricao WHERE idDataInscricao=$idDataInscricao) DAY),NOW())";

	$result = $db->Query($query_inserir_pagamento);	
	
	$query_consulta_dados_pedido = " SELECT cte_evpt.*,cte_evf.forma_pagamento,DATE_FORMAT(cte_evf.data_vencimento,'%d%m%Y') AS data_vencimento,cte_ev.str_titulo AS nome_evento,(SELECT SUM(valor) FROM cte_evento_pedido WHERE idPedido = $idPedido) AS valor_inscricao,cte_evf.valor AS valor_final
	FROM cte_evento_pedido cte_evp
	INNER JOIN cte_evento_data_inscricao cte_edi
	ON cte_evp.idDataInscricao = cte_edi.idDataInscricao
	INNER JOIN cte_evento cte_ev
	ON cte_ev.idEvento = cte_edi.idEvento
	INNER JOIN cte_evento_financeiro cte_evf
	ON cte_evf.idPedido = cte_evp.idPedido
	INNER JOIN cte_evento_participante cte_evpt
	ON cte_evpt.idParticipante = cte_evp.idParticipante
	WHERE cte_evf.idPedido = $idPedido";
	
	$result = $db->Query($query_consulta_dados_pedido);
	
	$corpo = "";
	$formaPagamentoFinal = ($forma_pagamento == 'BB') ?"Boleto Bancário":"Crédito em conta – somente para clientes Itaú";	
	
	while($row = mysql_fetch_array($result)){
		
		$data_vencimento = $row['data_vencimento'];
		$valor_inscricao = number_format($row['valor_inscricao'],2,',','');
		$valor_final = number_format($row['valor_final'],2,',','');
		$assunto_email = "Inscrição - ".$row['nome_evento'];		
		
		$recibo_EMPRESA 			= $row['emissao_recibo_empresa'];
		$recibo_PARTICIPANTE		= $row['emissao_recibo_participante'];	
		
		$nome = $row['nomecompleto'];
		$email = $row['email'];
		$cracha = $row['nomecracha'];
		$profissao = $row['profissao'];
		$cargo = $row['cargo'];
		
		if($recibo_EMPRESA=='S' && $recibo_PARTICIPANTE=='S'){
			$reciboDe = "da Empresa e do Participante";
		}else{
	
			if($recibo_EMPRESA!='S' && $recibo_PARTICIPANTE!='S'){
				$reciboDe = "opções não marcadas";
			}else{
				$reciboDe = ($recibo_EMPRESA == 'S') ? "da Empresa" : "do Participante";
			}
		}
		
		$cpf = $row['cpf_recibo_participante'];	
		
		$entidade = $row['entidade_associado'];
		$conhecimento_evento =	str_replace('|',',',$row['como_conheceu']);
		$informativo = ($row["informativos_cte"] == 'S')?'Sim':'Não';

		$corpo.= "Estes são os dados de seu formulário. Eles foram enviados por:<br />";
		$corpo.= "Nome: $nome ($email)<br />";
		$corpo.= "IP: $ip<br />";
		$corpo.= "Data: $data_envio<br />";
		$corpo.= "<hr style='border:1px dotted black;' />";
		$corpo.= "Crachá: $cracha<br />";	
		$corpo.= "Profissão: $profissao<br />";
		$corpo.= "Cargo: $cargo<br />";
		$corpo.= "Empresa: $empresa<br />";
		$corpo.= "CNPJ: $cnpj<br />";
		$corpo.= "Inscrição Estadual: $inscricao_estadual<br />";
		$corpo.= "Endereço: $endereco $numero $complemento <br />";
		$corpo.= "Bairro: $bairro<br />";
		$corpo.= "Cidade: $cidade<br />";
		$corpo.= "CEP: $cep<br />";
		$corpo.= "Estado: $estado<br />";
		$corpo.= "DDD: $ddd<br />";
		$corpo.= "Telefone: $telefone<br />";
		$corpo.= "Recibo ou nota fiscal:$tipo_comprovante<br />";	
		$corpo.= "Emissão em nome de $reciboDe<br />";
		$corpo.= "CPF: $cpf<br />";
		$corpo.= "Cliente Ativo: $clienteAtivo<br />";
		$corpo.= "Deseja receber os informativos: $informativo<br />";
		$corpo.= "Entidade: $entidade<br />";
		$corpo.= "Como tomou conhecimento do evento? : $conhecimento_evento<br />";
		$corpo.= "Forma de Pagamento: $formaPagamentoFinal<br />";
		
		$corpo.="<br>";
		$corpo.= "<hr style='border:1px dotted black;' />";
		
		//$mail -> From = "msantos@cte.com.br";
		$mail -> From = "evento_inscricao@cte.com.br";
		//$mail -> From = "evento_inscricao@cte.com.br";
		// $mail -> From = "noticias@autodoc.com.br";
		$mail -> FromName = "Eventos CTE";
		$mail -> AddAddress ($email);
		$mail -> Subject = $assunto_email;
		
		$mail -> IsHTML (true);
		$mail -> IsSMTP();
		// $mail -> Host = 'smtp.autodoc.com.br';
		$mail -> Host = 'smtp.cte.com.br';
		$mail -> Port = 587;
		$mail -> SMTPAuth = true;
		// $mail -> Username = 'bruno@autodoc.com.br';
		// $mail -> Password = 'x';
		$mail -> Username = 'evento_inscricao@cte.com.br';
		$mail -> Password = 'cte1212';		
		// $mail -> Username = 'sistemas@autodoc.com.br';
		// $mail -> Password = 'sySAdOc1011';
		// $mail -> Username = 'msantos@autodoc.com.br';
		// $mail -> Password = 'marcos123';
		
		
	}
	
	$corpo .= "<b>Valor da Inscrição: R$ $valor_inscricao</b>";
	// $mail -> AddAddress ("inscricao_eventos@cte.com.br");
	$mail -> AddAddress ("cera.bruno@gmail.com.br");
	$mail -> Body = $corpo;

	$mail->IsHTML(true);
		
	$mail->Send();	
	
	#echo 'Após o envio do e-mail';exit;
	
	//echo $corpo;

	//Rotina para ser gerada o boleto	    	
	
	$cripto = new Itaucripto;

	$codEmp = "J0103978720001990000007702";
	$pedido = $idPedido;
	$valor = $valor_final;
	$observacao = 3;
	$chave = "CTE191249EDIFICA"; 

	if($cnpj){
	
		$nomeSacado = $oUt->retirarCaracteres(substr($empresa,0,30));
		$codigoInscricao = "02";
		$numeroInscricao = $cnpj_grava;
	
	}else{
	
		$nomeSacado = $oUt->retirarCaracteres(substr($nome,0,30));
		$codigoInscricao = "01";
		$numeroInscricao = $cpf_grava;	
	
	}

	$enderecoSacado = $oUt->retirarCaracteres(substr($endereco." " . $numero . " " . $complemento,0,40));
	$bairroSacado = $oUt->retirarCaracteres(substr($bairro,0,15));
	$cepSacado = $cep_grava;
	$cidadeSacado = $oUt->retirarCaracteres(substr($cidade,0,15));
	$estadoSacado = $estado;
	$dataVencimento = $data_vencimento;
	$urlRetorna = "";
	$obsAd1 = "A SUA INSCRICAO SERA EFETIVADA APOS A QUITACAO DESTE BOLETO.";
	$obsAd2 = "O PAGAMENTO SO PODERÁ SER FEITO ATÉ O VENCIMENTO.";
	$obsAd3 = "";

	$dados = $cripto->geraDados($codEmp,$pedido,$valor,$observacao,$chave,$nomeSacado,$codigoInscricao,$numeroInscricao,$enderecoSacado,$bairroSacado,$cepSacado,$cidadeSacado,$estadoSacado,$dataVencimento,$urlRetorna,$obsAd1,$obsAd2,$obsAd3);
	
?>


<script>

function envia(){


alert('Obrigado por efetuar sua inscrição')

document.forms[0].DC.value = '<? echo $dados; ?>';
document.forms[0].submit();

}

</script>

<HTML>
<HEAD></HEAD>
<BODY onload="envia();">

<FORM ACTION="https://shopline.itau.com.br/shopline/shopline.asp" method="post" name="form1">
<INPUT type="hidden" name="DC">
<BR>
</form>

</BODY>
</HTML>

<?php

	
	
?>

