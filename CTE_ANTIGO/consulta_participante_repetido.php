<?php


	header("Content-Type: text/html; charset=ISO-8859-1",true);
	
	// Chama as classes
	require "../../class/database.class.php";
	require "../../json.php";
	
	$json = new FastJSON;
	$db = new dataBase;	
	
	$cnpj = str_replace(array("/",".","-"),"",$_POST["CNPJ"]);
	$cpf= str_replace(array(".","-"),"",$_POST["CPF"]);	
	
	$query_inscricao = "SELECT 1 FROM cte_evento_participante cte_evp
	INNER JOIN cte_evento_pedido cte_evpd
	ON cte_evp.idParticipante = cte_evpd.idParticipante
	INNER JOIN cte_evento_data_inscricao cte_evdi
	ON cte_evdi.idDataInscricao = cte_evpd.idDataInscricao
	WHERE cte_evp.cnpj = '$cnpj' 
	AND cte_evp.cpf_recibo_participante = '$cpf'
	AND cte_evdi.idEvento = (SELECT idEvento FROM cte_evento WHERE dt_evento >= DATE(NOW()) ORDER BY dt_evento ASC LIMIT 1)";
	
	$result_inscricao =  $db->Query($query_inscricao);	
	
	echo mysql_num_rows($result_inscricao);

	



?>