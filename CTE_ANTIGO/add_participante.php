<?php

	//Exibicao de erros. Notificacoes naoo sao exibidas
    error_reporting(E_ALL ^ E_NOTICE ^ E_DEPRECATED);
	
	header("Content-Type: text/html; charset=ISO-8859-1",true);	
	
	// Chama as classes
	require "../../class/database.class.php";
	require "../../class/uteis.class.php";
	require "../../phpmailer/class.phpmailer.php";
	
	$db = new dataBase;
	$oUt = new Uteis;
	
	//Recupera as variaveis
	
	$nome 						= utf8_decode($_POST['nome']);
	$cracha 					= utf8_decode($_POST['nome_cracha']);
	$email 						= utf8_decode($_POST['email']);
	$profissao 					= utf8_decode($_POST['profissao']);
	$cargo 						= utf8_decode($_POST['cargo']);
	$empresa 					= utf8_decode($_POST['empresa']);
	$cnpj 						= utf8_decode($_POST['CNPJ']);
	$inscricao_estadual 		= utf8_decode($_POST['inscricao_estadual']);
	$endereco 					= utf8_decode($_POST['endereco']);
	$numero 					= utf8_decode($_POST['numero']);
	$complemento 				= utf8_decode($_POST['complemento']);
	$bairro						= utf8_decode($_POST['bairro']);
	$cidade 					= utf8_decode($_POST['cidade']);
	$estado 					= $_POST['estado'];
	$cep 						= $_POST['cep'];
	$ddd 						= $_POST['ddd'];
	$telefone 					= $_POST['telefone'];
	$emissao_tipo_comprovante   = $_POST['emissao_tipo_comprovante'];
	$recibo_EMPRESA 			= ($_POST['emissao_em_nome'] == 'E')?"S":"N";
	$recibo_PARTICIPANTE		= ($_POST['emissao_em_nome'] == 'P')?"S":"N";
	$cpf						= (isset($_POST['CPF']))?$_POST['CPF']:"";
	$clienteAtivo               = ($_POST["idTipoInscricao"] == 2)?'S':'N';
	$conhecimento_BOLETIM		= (isset($_POST['conhecimento_BOLETIM']))?$_POST['conhecimento_BOLETIM']:"";
	$conhecimento_SITECTE		= (isset($_POST['conhecimento_SITECTE']))?$_POST['conhecimento_SITECTE']:"";
	$conhecimento_REVISTA		= (isset($_POST['conhecimento_REVISTA']))?$_POST['conhecimento_REVISTA']:"";
	$conhecimento_OUTROS		= (isset($_POST['conhecimento_OUTROS']))?$_POST['conhecimento_OUTROS']:"";
	$conhecimento_OUTROSQUAL	= (isset($_POST['conhecimento_OUTROSQUAL']))?$_POST['conhecimento_OUTROSQUAL']:"";
	$informativo 				= (isset($_POST['informativo']))?$_POST['informativo']:"";
	$entidade 					= (isset($_POST['entidade']))?$_POST['entidade']:"";
	$forma_pagamento            = $_POST['forma_pagamento'];
	$ip							= $_SERVER['REMOTE_ADDR'];
	$data_envio					= date('d/m/Y - H:i:s');
	$idPedido					= $_POST["idPedido"]?$_POST["idPedido"]:0;
	
		
	//Rotina para inserir dados do participante no banco
	
	$cnpj_grava = str_replace(array("/",".","-"),"",$cnpj);
	$cep_grava = str_replace("-","",$cep);
	$cpf_grava = str_replace(array(".","-"),"",$cpf);
	
	$como_conheceu = "";
	
	if(!empty($conhecimento_BOLETIM)) $como_conheceu .= "Boletim CTE|";
	if(!empty($conhecimento_SITECTE)) $como_conheceu .= "Site CTE|";
	if(!empty($conhecimento_REVISTA)) $como_conheceu .= "Jornal/Revista|";
    if(!empty($conhecimento_OUTROS))  $como_conheceu .= "Outros";
	
	$query_insere_participante = "INSERT INTO cte_evento_participante(nomecompleto,nomecracha,email,profissao,cargo,nomeempresa,cnpj,inscricao_estadual,cep,endereco,numero,complemento,bairro,cidade,uf,ddd,telefone,";
	$query_insere_participante .= "emissao_tipo_comprovante,emissao_recibo_empresa,emissao_recibo_participante,cpf_recibo_participante,cliente_cte_ativo,como_conheceu,como_conheceu_outros_qual,informativos_cte,entidade_associado) ";
	$query_insere_participante .= "VALUES('$nome','$cracha','$email','$profissao','$cargo','$empresa','$cnpj_grava','$inscricao_estadual','$cep_grava','$endereco','$numero','$complemento','$bairro','$cidade','$estado','$ddd','$telefone',";
	$query_insere_participante .= "'$emissao_tipo_comprovante','$recibo_EMPRESA','$recibo_PARTICIPANTE','$cpf_grava','$clienteAtivo','$como_conheceu','$conhecimento_OUTROSQUAL','$informativo','$entidade')";

	$db->Query($query_insere_participante);
	
	//Rotina para inserir dados do pedido do participante no banco
	
	$idParticipante = mysql_insert_id();
	$idDataInscricao = $_POST["idDataInscricao"];
	$idTipoInscricao = $_POST["idTipoInscricao"];
	
	$query_insere_dados_pedido = "INSERT INTO cte_evento_pedido(".($idPedido?'idPedido,':'')."idDataInscricao,idTipoInscricao,idParticipante,valor,data_cadastro)";
	$query_insere_dados_pedido .= "VALUES(".($idPedido?$idPedido.',':'')."$idDataInscricao,$idTipoInscricao,$idParticipante,(SELECT valor FROM cte_evento_preco WHERE idDataInscricao=$idDataInscricao AND idTipoInscricao=$idTipoInscricao),NOW())";
	//$query_insere_dados_pedido .= "'$forma_pagamento','EA',DATE_ADD(NOW(),INTERVAL (SELECT IF(DATEDIFF(data_inscricao,NOW()) < 5,DATEDIFF(data_inscricao,NOW()),5) AS diferenca FROM cte_evento_data_inscricao WHERE idDataInscricao=$idDataInscricao) DAY),NOW())";
	
	$db->Query($query_insere_dados_pedido);
	$idPedido = (!$idPedido)?mysql_insert_id():$idPedido;
	
	if($idPedido){
		$dados_saida['mensagem'] = "Participante inscrito com sucesso";
		$dados_saida['idPedido'] = $idPedido;
	}else{
		$dados_saida['mensagem'] = "Erro ao inscrever participante";
	}
	
	//Rotina para ser executada no envio de email
	
	if($recibo_EMPRESA=='S' && $recibo_PARTICIPANTE=='S'){
		$reciboDe = "da Empresa e do Participante";
	}else{
	
		if($recibo_EMPRESA!='S' && $recibo_PARTICIPANTE!='S'){
			$reciboDe = "opções não marcadas";
		}else{
			$reciboDe = ($recibo_EMPRESA == 'S') ? "da Empresa" : "do Participante";
		}
	}
	
	$clienteAtivo	= ($clienteAtivo == 'S') ? "Sim" : "Não";
	$informativo	= ($informativo == 'S') ? "Sim" : "Não";
	
	$conhecimento_evento = ($conhecimento_BOLETIM==1) ? "Boletim" : "";
	$conhecimento_evento.= ($conhecimento_SITECTE==1) ? (($conhecimento_evento) ? ', Site CTE' : 'Site CTE') : '';
	$conhecimento_evento.= ($conhecimento_REVISTA==1) ? (($conhecimento_evento) ? ', Jornal/Revista' : 'Jornal/Revista') : '';
	$conhecimento_evento.= ($conhecimento_OUTROS==1) ? (($conhecimento_evento) ? ', Outros: '.$conhecimento_OUTROSQUAL : 'Outros: '.$conhecimento_OUTROSQUAL) : '';
	
	$tipo_comprovante = ($emissao_tipo_comprovante == 'R') ?"Recibo":"Nota Fiscal";
	$forma_pagamento = ($forma_pagamento == 'BB') ?"Boleto Bancário":"Crédito em conta – somente para clientes Itaú";
	
	echo json_encode($dados_saida);
	
?>