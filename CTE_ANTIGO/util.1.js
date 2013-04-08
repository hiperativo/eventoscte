//Função para validar email

function validaEmail(email)
{
	er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;

	if(er.exec(email)){
		return true;
	} else {
		return false;
	}
}



// Função para validação de CPF

function validaCPF(cpf) {

	cpf = cpf.toString().replace( "-", "" );
	cpf = cpf.toString().replace( ".", "" );
	cpf = cpf.toString().replace( ".", "" );

	if(cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111" ||
	cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" ||
	cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" ||
	cpf == "88888888888" || cpf == "99999999999"){
		return false;
	}

	soma = 0;
	for(i = 0; i < 9; i++)
	soma += parseInt(cpf.charAt(i)) * (10 - i);
	resto = 11 - (soma % 11);
	if(resto == 10 || resto == 11)
	resto = 0;
	if(resto != parseInt(cpf.charAt(9))){
		return false;
	}
	soma = 0;
	for(i = 0; i < 10; i ++)
	soma += parseInt(cpf.charAt(i)) * (11 - i);
	resto = 11 - (soma % 11);
	if(resto == 10 || resto == 11)
	resto = 0;
	if(resto != parseInt(cpf.charAt(10))){
		return false;
	}
	return true;
}

function validaCNPJ(CNPJ) {
                 erro = new String;
                 if (CNPJ.length < 14) erro += "É necessario preencher corretamente o número do CNPJ! "; 
                 if ((CNPJ.charAt(2) != ".") || (CNPJ.charAt(6) != ".") || (CNPJ.charAt(10) != "/") || (CNPJ.charAt(15) != "-")){
                 //if (erro.length == 0) erro += "É necessário preencher corretamente o número do CNPJ! ";
                 }
                 //substituir os caracteres que não são números
              if(document.layers && parseInt(navigator.appVersion) == 4){
                      x = CNPJ.substring(0,2);
                       x += CNPJ. substring (3,6);
                       x += CNPJ. substring (7,10);
                      x += CNPJ. substring (11,15);
                       x += CNPJ. substring (16,18);
                       CNPJ = x; 
               } else {
                       CNPJ = CNPJ. replace (".","");
                       CNPJ = CNPJ. replace (".","");
                       CNPJ = CNPJ. replace ("-","");
                       CNPJ = CNPJ. replace ("/","");
               }
               var nonNumbers = /\D/;
               if (nonNumbers.test(CNPJ)) erro += "A verificação de CNPJ suporta apenas números! "; 
               var a = [];
               var b = new Number;
               var c = [6,5,4,3,2,9,8,7,6,5,4,3,2];
			   
               for (i=0; i<12; i++){
                       a[i] = CNPJ.charAt(i);
                       b += a[i] * c[i+1];
			   }
			   
               if ((x = b % 11) < 2) { a[12] = 0 } else { a[12] = 11-x }
			   
               b = 0;
               for (y=0; y<13; y++) {
                       b += (a[y] * c[y]); 
               }
               if ((x = b % 11) < 2) { a[13] = 0; } else { a[13] = 11-x; }
               if ((CNPJ.charAt(12) != a[12]) || (CNPJ.charAt(13) != a[13])){
                       erro +="Dígito verificador com problema!";
               }
               if (erro.length > 0){
                       return false;
               }
              return true;
       }
	   
	   
	   
//Função para colocar mascara nos textos
	   
function mascaraTexto(objForm, strField, sMask, evtKeyPress) {
	//alert('1111');
	var i, nCount, sValue, fldLen, mskLen,bolMask, sCod, nTecla;
	if(window.event) { // Internet Explorer
		nTecla = evtKeyPress.keyCode;
	}else{
		nTecla = evtKeyPress.which;
	}
	sValue = objForm[strField].value;

	// Limpa todos os caracteres de formatação que
	// já estiverem no campo.
	sValue = sValue.toString().replace( "-", "" );
	sValue = sValue.toString().replace( "-", "" );
	sValue = sValue.toString().replace( ".", "" );
	sValue = sValue.toString().replace( ".", "" );
	sValue = sValue.toString().replace( "/", "" );
	sValue = sValue.toString().replace( "/", "" );
	sValue = sValue.toString().replace( "(", "" );
	sValue = sValue.toString().replace( "(", "" );
	sValue = sValue.toString().replace( ")", "" );
	sValue = sValue.toString().replace( ")", "" );
	sValue = sValue.toString().replace( " ", "" );
	sValue = sValue.toString().replace( " ", "" );
	fldLen = sValue.length;
	mskLen = sMask.length;

	i = 0;
	nCount = 0;
	sCod = "";
	mskLen = fldLen;

	while (i <= mskLen) {
		bolMask = ((sMask.charAt(i) == "-") || (sMask.charAt(i) == ".")
		|| (sMask.charAt(i) == "/"))
		bolMask = bolMask || ((sMask.charAt(i) == "(") ||
		(sMask.charAt(i) == ")") || (sMask.charAt(i) == " "))

		if (bolMask) {
			sCod += sMask.charAt(i);
			mskLen++; }
			else {
				sCod += sValue.charAt(nCount);
				nCount++;
			}

			i++;
	}

	objForm[strField].value = sCod;

	if (nTecla != 8) { // backspace
		if (sMask.charAt(i-1) == "9") { // apenas números...
			return ((nTecla > 47) && (nTecla < 58)); } // números de 0 a 9
			else { // qualquer caracter...
				return true;
			} }
			else {
				return true;
			}
}
