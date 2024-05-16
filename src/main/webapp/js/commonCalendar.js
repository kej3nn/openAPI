/**********************************************************************************
* 두 일수에 대한 차이 - 년 또는 월 또는 일을 리턴
* parm : (선일, 후일, 형태)
* mode : y : 년,  m : 월,   d: 일
* argument는 반드시 yyyy-mm-dd 형태를 유지한다. 
***********************************************************************************/
function getDateDiff(preDateId,postDateId,mode){
	var preDate = $('#'+preDateId).val();
	var postDate = $('#'+postDateId).val();
	
	var errMsg = "[ERR] ";
	var errFlag = false;
	if(mode == null || mode == ""){
		mode = "D";
	}
	mode = mode.toUpperCase();
	
	if(preDate == null || preDate == "") {
		errMsg += "Null : preDate";
		errFlag = true;
	} else if(postDate == null || postDate == "") {
		errMsg += "Null : postDate";
		errFlag = true;
	} else if(!isValidDate(preDate)) {
		errMsg += "Type : preDate";
		errFlag = true;
	} else if(!isValidDate(postDate)) {
		errMsg += "Type : postDate";
		errFlag = true;
	} else if(mode!="Y" && mode!="M" && mode!="D") {
		errMsg += "Type : mode";
		errFlag = true;
	}
	
	if(errFlag) {
		return false;
	}
	
	var preSplit  = preDate.split("-");
	var postSplit = postDate.split("-");
	
	var pre  = new Date(preSplit[0],  Number(preSplit[1])-1,  preSplit[2]);
	var post = new Date(postSplit[0], Number(postSplit[1])-1, postSplit[2]);

	var rtnVal = 0;

	switch (mode) {
		case "Y" : rtnVal = post.getYear() - pre.getYear(); break;
		case "M" : rtnVal = (post.getYear() - pre.getYear())*12 + (post.getMonth() - pre.getMonth()); break;
		case "D" : rtnVal = Math.ceil((post-pre) / 24 / 60 / 60 / 1000); break;
	}
	
	
	return rtnVal;

}


function getDateDiffVal(date1,date2,mode){
	var pattern =/[^(0-9)]/gi;
	var preDate = date1.replace(pattern,"");
	var postDate =date2.replace(pattern,"");
	
	var errMsg = "[ERR] ";
	var errFlag = false;
	if(mode == null || mode == ""){
		mode = "D";
	}
	mode = mode.toUpperCase();
	
	if(preDate == null || preDate == "") {
		errMsg += "Null : preDate";
		errFlag = true;
	} else if(postDate == null || postDate == "") {
		errMsg += "Null : postDate";
		errFlag = true;
	/*} else if(!isValidDate(preDate)) {                         
		errMsg += "Type : preDate";
		errFlag = true;
	} else if(!isValidDate(postDate)) {
		errMsg += "Type : postDate";
		errFlag = true;*/
	} else if(mode!="Y" && mode!="M" && mode!="D") {
		errMsg += "Type : mode";
		errFlag = true;
	}
	if(errFlag) {               
		return false;          
	}
	
	var pre  = new Date(preDate.substr(0,4),  Number(preDate.substr(4,2))-1,  preDate.substr(6,2));
	var post = new Date(postDate.substr(0,4),  Number(postDate.substr(4,2))-1,  postDate.substr(6,2));
                  
	var rtnVal = 0;                                      
                  
	switch (mode) {
		case "Y" : rtnVal = post.getYear() - pre.getYear(); break;
		case "M" : rtnVal = (post.getYear() - pre.getYear())*12 + (post.getMonth() - pre.getMonth()); break;
		case "D" : rtnVal = Math.ceil((post-pre) / 24 / 60 / 60 / 1000); break;
	}
	
	
	return rtnVal;

}

/**
 * 날짜가 유효한지 검사
 * 구분자는 나중에 추가하기로 한다.
 */
function isValidDate(d) {
    // 포맷에 안맞으면 false리턴
    if(!isDateFormat(d)) {
        return false;
    }

    var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    var dateToken = d.split('-');
    var year = Number(dateToken[0]);
    var month = Number(dateToken[1]);
    var day = Number(dateToken[2]);
    
    // 날짜가 0이면 false
    if(day == 0) {
        return false;
    }

    var isValid = false;

    // 윤년일때
    if(isLeaf(year)) {
        if(month == 2) {
            if(day <= month_day[month-1] + 1) {
                isValid = true;
            }
        } else {
            if(day <= month_day[month-1]) {
                isValid = true;
            }
        }
    } else {
        if(day <= month_day[month-1]) {
            isValid = true;
        }
    }

    return isValid;
}

/**
 * 날짜포맷에 맞는지 검사
 * 구분자 체크는 나중에 추가하기로 한다.
 */
function isDateFormat(d) {
    var df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
    return d.match(df);
}

/**
 * 윤년여부 검사
 */
function isLeaf(year) {
    var leaf = false;

    if(year % 4 == 0) {
        leaf = true;

        if(year % 100 == 0) {
            leaf = false;       
        }

        if(year % 400 == 0) {
            leaf = true;
        }
    }

    return leaf;
}


function dateValCheck(fromObj,toObj){
	var fromDt = fromObj.val(); //from
	var toDt =  toObj.val(); //to           
	var pattern =/[^(0-9)]/gi;
	var fromReplace = fromDt.replace(pattern,"");                 
	var toReplace=toDt.replace(pattern,"");           
	if(!(fromDt =="" && toDt == "")){//값이 있으면
		if(fromDt != "" && toDt == ""){
			toObj.val(fromDt); //to 값 넣음
			toReplace = fromReplace;
		}
		if(toDt != "" && fromDt == ""){
			fromObj.val(toDt); //from 값 넣음
			fromReplace = toReplace;
		}
		if(toReplace < fromReplace ){              
			toObj.val(fromDt); //from 값 넣음    
			toReplace = fromReplace;                                         
		}                                            
	}
}
