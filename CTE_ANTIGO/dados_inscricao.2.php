<?php

	header("Content-Type: text/html; charset=ISO-8859-1",true);
	
	// Chama as classes
	require "../../class/database.class.php";
	require "../../json.php";
	
	$json = new FastJSON;
	$db = new dataBase;
		
	// Seleciona todas as datas de inscrição do evento
	
	$query_data_inscricao = "SELECT 
									cte_ev.dt_evento AS data_evento,
									cte_di.data_inscricao 
								  FROM cte_evento_data_inscricao cte_di
								  LEFT JOIN cte_evento cte_ev
								  ON cte_ev.idEvento = cte_di.idEvento
								  WHERE cte_ev.idEvento = (SELECT idEvento FROM cte_evento WHERE dt_evento >= DATE(NOW()) ORDER BY dt_evento ASC LIMIT 1)
								  AND data_inscricao >= DATE(NOW())
								  ORDER BY data_inscricao ASC";
	
	$result_data_inscricao =  $db->Query($query_data_inscricao);
	
	//Colocar os dados dentro de um array
	
	while($row_data_inscricao = mysql_fetch_array($result_data_inscricao)){
		$dados_saida['datas_inscricao_pagamento'][] = date("d/m/y",strtotime($row_data_inscricao['data_inscricao']));	
		$dados_saida['data_evento'] = date("d/m/y",strtotime($row_data_inscricao['data_evento']));
	}
	
	if(!empty($dados_saida)){
	
	//Seleciona todos os tipos de inscrições
	
	$query_tipos_inscricoes = "SELECT * FROM cte_evento_tipo_inscricao";
	
	$result_tipos_inscricoes =  $db->Query($query_tipos_inscricoes);
	
	$i= 0;
	
	while($row_tipos_inscricoes = mysql_fetch_array($result_tipos_inscricoes)){

		$dados_saida['tipos_profissionais'][$i]['nome'] = $row_tipos_inscricoes['descricao'];
		$dados_saida['tipos_profissionais'][$i]['idTipoInscricao'] = $row_tipos_inscricoes['idTipoInscricao'];
		
		$query_valores_inscricao = "SELECT cte_evp.*,cte_edi.idDataInscricao AS idDataInscricao_data_inscricao FROM cte_evento_data_inscricao cte_edi
					LEFT JOIN (SELECT idDataInscricao,idTipoInscricao,valor FROM cte_evento_preco WHERE idTipoInscricao =".$row_tipos_inscricoes['idTipoInscricao'].") AS cte_evp
					ON cte_edi.idDataInscricao = cte_evp.idDataInscricao
					WHERE idEvento = (SELECT idEvento FROM cte_evento WHERE dt_evento >= DATE(NOW()) ORDER BY dt_evento ASC LIMIT 1)
					AND data_inscricao >= DATE(NOW())
					ORDER BY data_inscricao ASC";
					
		$result_valores_inscricao =  $db->Query($query_valores_inscricao);
		
		while($row_valores_inscricao = mysql_fetch_array($result_valores_inscricao)){
			$dados_saida['tipos_profissionais'][$i]['idDataInscricao'][] = $row_valores_inscricao['idDataInscricao_data_inscricao'];
			$dados_saida['tipos_profissionais'][$i]['valores'][] = (!empty($row_valores_inscricao['valor']))?number_format($row_valores_inscricao['valor'],2,',',''):"0,00";
		}
		
		$i++;
		
	}
	
	/*echo "<pre>";
	print_r($dados_saida);
	echo "</pre>";*/
	
	echo $json->encode($dados_saida);
	
	}
	
?>