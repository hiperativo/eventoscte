<?php

	header("Content-Type: text/html; charset=ISO-8859-1",true);
	
	// Chama as classes
	require "../../class/database.class.php";
	require "../../json.php";
	
	$json = new FastJSON;
	$db = new dataBase;
	
	$idTipoInscricao = $_GET["idTipoInscricao"];
	$idDataInscricao = $_GET["idDataInscricao"];
	
	$query_data_inscricao = "SELECT valor FROM cte_evento_preco WHERE idTipoInscricao = $idTipoInscricao AND idDataInscricao = $idDataInscricao";
	$result_data_inscricao =  $db->Query($query_data_inscricao);
	
	$row_data_inscricao = mysql_fetch_assoc($result_data_inscricao);	
	
	echo $row_data_inscricao['valor'];
	
?>