
//검색 정제 (번지 빼기, 띄어쓰기)
function regExpCheckJuso(strKeyword)
{
	var tempKeyword = strKeyword;
	var charKeyword;  
	var tempLength;
	
	//주소일 경우 글자뒤에 번지 x, 주소와 숫자 사이에 한칸 띄우기
	var reqExp1 =/([0-9]|번지)$/;
	var reqExp2 =/번지$/;
	var checkChar =/^([0-9]|-|\.|\·)$/;
	var checkEng =/^[A-Za-z]+$/;

	if(reqExp1.test(strKeyword))
	{
		// 글자 뒤의 번지 삭제
		tempKeyword = strKeyword.split(reqExp2).join("");

		// 주소와 숫자 사이 한칸 띄우기
		tempLength = tempKeyword.length;

		for(var i=tempLength-1;i>=0;i--)
		{
			charKeyword = tempKeyword.charAt(i);
			
			if(!checkChar.test(charKeyword))
			{
				if(charKeyword != " " && !checkEng.test(charKeyword))
				{
					tempKeyword = insertString(tempKeyword,i+1,' ');			
				}
				break;
			}
		}
	}
	
	var regExp3 = /[0-9]*[ ]*(대로|로|길)[ ]+[0-9]+[ ]*([가-힝]|[ ])*[ ]*(로|길)/;
	var regExp4 = /[ ]/;

	var k = tempKeyword.match(regExp3) ;
	
	if (k != null) {
		var tmp = k[0].split(regExp4).join("");
		
		tempKeyword=tempKeyword.replace(regExp3, tmp);
	}
	
	return tempKeyword;
}

function insertString(key,index,string)
{
	if(index >0)
		return key.substring(0,index) + string + key.substring(index,key.length);
	else
		return string+key;
}
function validateJuso(value){
	value =value.replace(/(^\s*)|(\s*$)/g, ""); //앞뒤 공백 제거
	/* 2014.05.09 특수문자 제거 안하도록 수정 %는 예외 */
  	//return value.split(/[~!$%^&*+=|:;?']/).join("");  //특수문자제거
  	return value.split(/[%]/).join("");  //특수문자제거
	/* 2014.05.09 특수문자 제거 안하도록 수정 %는 예외 */
}

function searchJuso(){
	var frm = document.getElementById("AKCFrm");
	//var keyword = document.getElementById('mainSearch');

	if (!checkSearchedWord(frm.searchKeyword)) {
		return ;
	} 

	frm.searchKeyword.value = validateJuso(frm.searchKeyword.value); //공백 및 특수문자 제거
	if(!checkValidate1(frm.searchKeyword, "검색어")){
		return;
	} else if(!checkValidate2(frm.searchKeyword.value)){
		return;
	}
	
	checkValidate3(frm.searchKeyword.value);//인천 남구 -> 미추홀구 명칭변경 안내문구
		
	frm.searchKeyword.value = regExpCheckJuso(frm.searchKeyword.value);
	frm.submit();
}

/*
 * 
 * */
function checkValidate1(form_nm,ele_nm) {	
	if (trim(form_nm.value)=="") {
		alert(ele_nm+'을(를) 입력해주세요!     ');

		form_nm.value="";
		
		form_nm.focus();
		return false;
	}
	/*
	var real_byte = form_nm.value.length;
		for (i = 0; i < form_nm.value.length; i++) {
			temp = form_nm.value.substr(i, 1).charCodeAt(0);
			if (temp < 2) {
				real_byte++;
				//alert(real_byte);
			}
		}
		// 클경우 메시지 뿌리기 
		if ( real_byte < 3 && form_nm.value != "국회") {
			alert('검색어를 3자 이상 입력하여 주세요.');
			return false;
		}
		*/
	return true;
}

function checkValidate2(keyword)
{
	//시도
	var sidoArray = new Array(
			"서울특별시","서울시","서울",
			"부산광역시","부산시","부산",
			"대전광역시","대전시","대전",
			"대구광역시","대구시","대구",
			"인천광역시","인천시","인천",
			"광주광역시","광주시","광주",
			"울산광역시","울산시","울산",
			"충청북도","충북",
			"충청남도","충남",
			"전라북도","전북",
			"전라남도","전남",
			"경상북도","경북",
			"경상남도","경남",
			"제주특별자치도","제주도","제주","특별자치도",
			"세종특별자치시","세종시","세종","특별자치시",
			"강원도", "강원",
			"경기도", "경기"
	);
	
	//시군구
	var sggArray = new Array("종로구","중구","용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구","노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구",
			"관악구","서초구","강남구","송파구","강동구","서구","동구","영도구","부산진구","동래구","남구","북구","해운대구","사하구","금정구","연제구","수영구","사상구","기장군","수성구",
			"달서구","달성군","연수구","남동구","부평구","계양구","강화군","옹진군","미추홀구","광산구","유성구","대덕구","울주군","수원시","수원시 장안구","수원시 권선구","수원시 팔달구","수원시 영통구",
			"성남시","성남시 수정구","성남시 중원구","성남시 분당구","의정부시","안양시","안양시 만안구","안양시 동안구","부천시","부천시 원미구","부천시 소사구","부천시 오정구","광명시","평택시",
			"동두천시","안산시","안산시 상록구","안산시 단원구","고양시","고양시 덕양구","고양시 일산동구","고양시 일산서구","과천시","구리시","남양주시","오산시","시흥시","군포시","의왕시","하남시",
			"용인시","용인시 처인구","용인시 기흥구","용인시 수지구","파주시","이천시","안성시","김포시","화성시","광주시","양주시","포천시","여주시","연천군","가평군","양평군","춘천시","원주시",
			"강릉시","동해시","태백시","속초시","삼척시","홍천군","횡성군","영월군","평창군","정선군","철원군","화천군","양구군","인제군","고성군","양양군","청주시","청주시 상당구","청주시 흥덕구",
			"충주시","제천시","청원군","보은군","옥천군","영동군","증평군","진천군","괴산군","음성군","단양군","천안시","천안시 동남구","천안시 서북구","공주시","보령시","아산시","서산시","논산시",
			"계룡시","당진시","금산군","부여군","서천군","청양군","홍성군","예산군","태안군","전주시","전주시 완산구","전주시 덕진구","군산시","익산시","정읍시","남원시","김제시","완주군","진안군",
			"무주군","장수군","임실군","순창군","고창군","부안군","목포시","여수시","순천시","나주시","광양시","담양군","곡성군","구례군","고흥군","보성군","화순군","장흥군","강진군","해남군","영암군",
			"무안군","함평군","영광군","장성군","완도군","진도군","신안군","포항시","포항시 남구","포항시 북구","경주시","김천시","안동시","구미시","영주시","영천시","상주시","문경시","경산시","군위군",
			"의성군","청송군","영양군","영덕군","청도군","고령군","성주군","칠곡군","예천군","봉화군","울진군","울릉군","창원시","창원시 의창구","창원시 성산구","창원시 마산합포구","창원시 마산회원구",
			"창원시 진해구","진주시","통영시","사천시","김해시","밀양시","거제시","양산시","의령군","함안군","창녕군","남해군","하동군","산청군","함양군","거창군","합천군","제주시","서귀포시");

	var tmpKeyword = (keyword == null) ? "" : keyword.replace(/ /g,"");
	for(var i=0; i<sidoArray.length; i++){
		if(tmpKeyword == sidoArray[i]){
			alert("주소를 상세히 입력해 주시기 바랍니다.");
			return false;
		}
	}
	
	for(var i=0; i<sggArray.length; i++){
		if(tmpKeyword == sggArray[i]){
			alert("주소를 상세히 입력해 주시기 바랍니다.");
			return false;
		}
	}
	return true;
}

function checkValidate3(keyword){
	var chkSido = keyword.match(/인천/);
	var chkSig = keyword.match(/남구/);
	
	if(chkSido != null && chkSig != null){
		alert('2018.7.1 부터 인천광역시 남구의 구 명칭이 "미추홀구"로 변경되었습니다.\n주소검색 시 참고하시기 바랍니다.');
	}
}


// enter처리   
function enterSearch(ev) {
	var evt_code = (window.netscape) ? ev.which : event.keyCode;
	if (evt_code == KEY_ENTER) {    
		ev.keyCode = 0;  
		searchJuso(); 
	} 
} 

function enterSearchTop(ev) {
	var evt_code = (window.netscape) ? ev.which : event.keyCode;
	if (evt_code == KEY_ENTER) {    
		ev.keyCode = 0;  
		headerSearch('top'); 
	} 
} 

// 주소검색(검색 버튼 클릭 시)
function headerSearch(formType) {
	if(formType == 'top'){
		var f = document.GNBHeaderTopSearchForm;	
	}else if(formType == 'seachList'){
		var f = document.GNBsearchForm;
	}else{
		var f = document.GNBHeaderSearchForm;
	}
	
	  //특수문자 제거
	f.searchKeyword.value = validateJuso(f.searchKeyword.value);
	
	//주소 체크
	if (!checkValidate1(f.searchKeyword, "검색어")){
		return;
	}else if(!checkValidate2(f.searchKeyword.value)){
		return;
	}
	 
	checkValidate3(f.searchKeyword.value);//인천 남구 -> 미추홀구 명칭변경 안내문구
	
	f.searchKeyword.value = regExpCheckJuso(f.searchKeyword.value);
	f.submit();
} 

/*
문자열 trim함수
*/
function trim(strSource) {

	return strSource.replace(/(^\s*)|(\s*$)/g, ""); 

}