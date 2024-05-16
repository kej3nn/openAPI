

function nullCheckValdation(obj,labal,val){
 	if(obj.attr("type") =="radio"){
 		var name = obj.attr("name");
 		if(inputRadioYn(name) =="N"){
			alert(labal+"(을)를 선택해주세요.");               
			obj.focus();                                    
			return true;      
		}               
	}else if(obj.attr("type") =="checkbox"){
		var name = obj.attr("name");
		if(inputCheckYn(name) =="N"){
			alert(labal+"(을)를 체크해주세요.");
			obj.focus();          
			return true;                              
		}                
	}else if(obj.attr("type") =="text"){              
		if(obj.val() == val){
			alert(labal+"(을)를 입력해주세요.");
			obj.focus();
			return true;
		}
	}else if(obj.attr("type") =="password"){              
		if(obj.val() == val){
			alert(labal+"(을)를 입력해주세요.");
			obj.focus();
			return true;
		}
	}else{
		if(obj.val() == val){
			alert(labal+"(을)를 선택해주세요.");
			obj.focus();
			return true;
		}            
	}
	return false;
}                     

function nullCheckValdationEn(obj,labal,val){        
	if(obj.attr("type") =="radio"){
 		var name = obj.attr("name");
 		if(inputRadioYn(name) =="N"){
			alert("Please enter "+labal);               
			obj.focus();                                    
			return true;      
		}               
	}else if(obj.attr("type") =="checkbox"){
		var name = obj.attr("name");
		if(inputCheckYn(name) =="N"){
			alert("Please enter "+labal);               
			obj.focus();          
			return true;                              
		}                
	}else if(obj.attr("type") =="text"){              
		if(obj.val() == val){
			alert("Please enter "+labal);               
			obj.focus();
			return true;
		}
	}else if(obj.attr("type") =="password"){              
		if(obj.val() == val){
			alert("Please enter "+labal);               
			obj.focus();
			return true;
		}
	}else{
		if(obj.val() == val){
			alert("Please enter "+labal);               
			obj.focus();
			return true;
		}            
	}
	return false;
}          

//영어 숫자로 구성되어있는지 체크
function engNumCheck(val){
	var pat = /^[a-zA-Z0-9]/g;
	return check(val,pat);
}                   

//숫자로 구성되어있는지 체크
function numcheck(val){
	var pat = /^[0-9]/g;
	return check(val,pat);
}

//영문로 구성되어있는지 체크
function engcheck(val){
	var pat = /^[a-zA-Z]/g;                                           
	return check(val, pat);
}

function check(val, pat){                                  
	if(pat.test(val)){                               
		return false;
	}                           
	return true;                       
}