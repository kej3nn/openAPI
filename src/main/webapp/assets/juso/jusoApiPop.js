//특수문자, 특정문자열(sql예약어) 제거
function checkSearchedWord(obj){
	obj.value = obj.value+" ";
	//특수문자 제거
	if(obj.value.length >0){
		var expText = /[%=><]/ ;
		if(expText.test(obj.value) == true){
			obj.value = obj.value.split(expText).join(""); 
		}
		//체크 문자열
		var sqlArray = new Array( //sql 예약어
			"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC", "UNION",  "FETCH", "DECLARE", "TRUNCATE"
		);
		
		var regex;
		var regex_plus ;
		for(var i=0; i<sqlArray.length; i++){
			regex = new RegExp("\\s" + sqlArray[i] + "\\s","gi") ;
			if (regex.test(obj.value)) {
				obj.value =obj.value.replace(regex, "");
				alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
			}
			regex_plus = new RegExp( "\\+" + sqlArray[i] + "\\+","gi") ;
			if (regex_plus.test(obj.value)) {
				obj.value =obj.value.replace(regex_plus, "");
				alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
			}
		}
	}
	return obj.value = obj.value;
}

function searchUrlJuso(){
	$("#resultData").hide();
	var frm = document.AKCFrm;
	frm.keyword.value = checkSearchedWord(frm.keyword); // 특수문자 및 sql예약어 제거, 20160912
	$("#keyword").val(validateJuso($("#keyword").val())); //공백 및 특수문자 제거
	if(!checkValidate1(frm.keyword, "검색어")) return;
	else if(!checkValidate2(frm.keyword.value)) return;
	$("#keyword").val(regExpCheckJuso($("#keyword").val()));
	
	//우선정렬
	if($("input:radio[name=raFirstSort]:checked").val() != undefined){
		var firstSort = $("input:radio[name=raFirstSort]:checked").val();
		$('#firstSort').val(firstSort);
	}else{
		$('#firstSort').val("none");
	}

	
	if( "Y" == "Y" ){
		$.ajax({
			 url :"https://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
			,type:"post"
			,data:$("#AKCFrm").serialize()
			,dataType:"jsonp"
			,crossDomain:true
			,success:function(xmlStr){
				if(navigator.appName.indexOf("Microsoft") > -1){
					var xmlData = new ActiveXObject("Microsoft.XMLDOM");
					xmlData.loadXML(xmlStr.returnXml)
				}else{
					var xmlData = xmlStr.returnXml;
				}
				$(".popSearchNoResult").html("");
				var errCode = $(xmlData).find("errorCode").text();
				var errDesc = $(xmlData).find("errorMessage").text();
				
				var totalCount = $(xmlData).find("totalCount").text();
				var currentPage = $(xmlData).find("currentPage").text();
				
				if( parseInt(totalCount) > 1000 && currentPage == "1" )
					alert("검색 결과가 너무 많습니다(1,000건 이상)\n검색어 예를 참조하여 검색하시기 바랍니다.");
				
				if(errCode != "0"){
					alert(errDesc);
				}else{
					if(xmlStr != null){
						makeList(xmlData);
					}
				}
			}
			,error: function(xhr,status, error){
				//alert("에러발생");
				alert("검색에 실패하였습니다 \n 다시 검색하시기 바랍니다.");
			}
		});

		
	}else{
		alert("addrLinkUrlSearch.do");
		//$("#AKCFrm").attr("action","/addrlink/addrLinkUrlSearch.do").submit();  
	}
}


function makeList(xmlStr){
	
	
	var htmlStr = "";
	
	if( $(xmlStr).find("totalCount").text() == "0" ){

		htmlStr +=' ';
		htmlStr += '<div class="popSearchNoResult" style="padding:10px 0 5px 0;">';
		htmlStr += '    검색된 내용이 없습니다.';
		htmlStr += '</div>';
		htmlStr +='';
		
	}else{
		
		htmlStr += '<p class="text-guide">도로명주소 검색 결과 <strong>('+ $(xmlStr).find("totalCount").text()+'건)</strong></p>';
		// 220317-접근성
//		htmlStr += '<fieldset>';
//		htmlStr += '    <legend>검색순서</legend>';
//		htmlStr += '    <div class="result_select">';
//		htmlStr += '        <span class="select_group">';
//		htmlStr += '            <input type="radio" tabindex="5" name="raFirstSort" id="raFirstSortNone" value="none" title="정확도가 높은 결과 우선 표출">';
//		htmlStr += '            <label for="raFirstSortNone" title="정확도가 높은 결과 우선 표출">정확도순</label>';
//		htmlStr += '        </span>';
//		htmlStr += '        <span class="select_group">';
//		htmlStr += '            <input type="radio" tabindex="6" name="raFirstSort" id="raFirstSortRoad" value="road" title="도로명주소에 입력 값이 포함된 결과 우선 표출">';
//		htmlStr += '            <label for="raFirstSortRoad" title="도로명주소에 입력 값이 포함된 결과 우선 표출">도로명 포함</label>';
//		htmlStr += '        </span>';
//		htmlStr += '        <span class="select_group">';
//		htmlStr += '            <input type="radio" tabindex="7" name="raFirstSort" id="raFirstSortLocation" value="location" title="지번주소에 입력 값이 포함된 결과 우선 표출">';
//		htmlStr += '            <label for="raFirstSortLocation" title="지번주소에 입력 값이 포함된 결과 우선 표출">지번 포함</label>';
//		htmlStr += '        </span>';
//		htmlStr += '    </div>';
//		htmlStr += '</fieldset>';
		htmlStr += '<table class="data-col" style="margin-top:3px;">';
		htmlStr += '    <caption>검색 결과</caption>';
		htmlStr += '    <colgroup>';
		htmlStr += '        <col style="width:8%">';
		htmlStr += '        <col>';
		htmlStr += '        <col style="width:11%">';
		htmlStr += '        <col style="width:14%">';
		htmlStr += '    </colgroup>';
		htmlStr += '    <thead>';
		htmlStr += '        <tr>';
		htmlStr += '            <th scope="col">No</th>';
		htmlStr += '            <th scope="col">도로명주소</th>';
		htmlStr += '            <th scope="col">&nbsp;</th>';
		htmlStr += '            <th scope="col">우편번호</th>';
		htmlStr += '        </tr>';
		htmlStr += '    </thead>';
		htmlStr += '    <tbody>';
		
		
		
		var currentPage = parseInt($(xmlStr).find("currentPage").text());
		var countPerPage = parseInt($(xmlStr).find("countPerPage").text());
		var listNum = (currentPage*countPerPage)-(--countPerPage);
		var num = 0; 
		$(xmlStr).find("juso").each(function(){
			num++;
			
			var resultType = "4"; 

			htmlStr += '<tr>';
			htmlStr +=' <td class="subj" style="text-align:center;">'+(listNum++)+'</td>';
				
			if( resultType == "1" ){

				htmlStr += '    <td class="subj" id="roadAddrTd'+num+'">';
				htmlStr += '        <a href="javascript:setMaping(\''+num+'\')" style="color:inherit;">';
				htmlStr += '            <div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b>';
				if($(this).find('ablYn').text() == '1'){
					htmlStr += '            <span class="cancelBtn">폐지</span>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '            <span class="reportBtn">이력</span>';
				}
				htmlStr += '            </div>';
				htmlStr += '        </a>';
				htmlStr += '        <div id="detListDivX'+num+'" style="display:none;" class="juso-detail">';
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '        <div><span class="infoSearch">** 검색 창에 입력한 키워드가 주소변동이력에 존재하는 경우, 현재 기준의 주소정보 표출</span></div>';
				}
				htmlStr += '            <span id="jibunAddrDiv'+num+'" style="display:none;">'+$(this).find('jibunAddr').text()+'</span>';
				htmlStr +='             <div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='             <div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='             <div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr += '        </div>';
				htmlStr += '    </td>';
				htmlStr +=' <td class="subj" style="text-align:center;">';
				htmlStr +='     <div id="detDiv'+num+'" style="font-size:12px;">';
				if($(this).find('hstryYn').text() == '1'){
					htmlStr +='         <a href="javascript:addrJuminRenew('+num+');" class="infoBtn">상세보기</a>';
				}
				htmlStr +='     </div>';
				htmlStr +='     <div id="detDivX'+num+'" style="display:none;" class="closeBtn"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
				htmlStr +=' </td>';
				
			}else if( resultType == "2" ){
				
				htmlStr += '    <td class="subj" id="roadAddrTd'+num+'">';
				htmlStr += '        <a href="javascript:setMaping(\''+num+'\')" style="color:inherit;">';
				htmlStr += '            <div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b>';
				if($(this).find('ablYn').text() == '1'){
					htmlStr += '            <span class="cancelBtn">폐지</span>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '            <span class="reportBtn">이력</span>';
				}
				htmlStr += '            </div>';
				htmlStr +='             <span>[지번]</span> <span id="jibunAddrDiv'+num+'">'+$(this).find('jibunAddr').text()+'</span>';
				htmlStr += '        </a>';
				htmlStr += '        <div id="detListDivX'+num+'" style="display:none;" class="juso-detail">';
				if($(this).find('relJibun').text() != ''){
					htmlStr +='     <div class="margin_top_3"><span class="infoBox">[관련지번]</span>';
					if($(this).find('relJibun').text().length<100){
						htmlStr +='<span>'+$(this).find('relJibun').text()+'</span>';
					}else{
						htmlStr +='<span id="label_relJibun_'+num+'}">'+$(this).find('relJibun').text().substring(0,100)+'...</span><a href="#this" class="info-more" onclick="javascript:fullText(\'label_relJibun_'+num+'\',\''+$(this).find('relJibun').text()+'\');">더보기</a>';
					}
					htmlStr +='     </div>';
				}
				if($(this).find('hemdNm').text() != ''){
					htmlStr +='         <div class="margin_top_3">';
					htmlStr +='             <span class="infoBox">[관할주민센터]</span> <span>'+$(this).find('hemdNm').text()+'</span>';
					if($(this).find('hemdNm').text().indexOf(',') > -1){
						htmlStr +='         <br/><span class="infoSearch">※ 해당주소는 관할주민센터가 2개이상이므로, 자세한 사항은 자치단체에 문의하시기 바랍니다.</span>';
					}
					htmlStr +='         <br/><span class="infoBox"><b>※ 관할주민센터는 참고정보이며, 실제와 다를 수 있습니다.</b></span>';
					htmlStr +='         </div>';
				}else{
					htmlStr +='         <div class="margin_top_3">';
					htmlStr +='             <span class="infoBox">[관할주민센터]</span> <span>-</span>';
					htmlStr +='             <br/><span class="infoBox"><b>※ 관할주민센터 정보가 제공되지 않는 주소입니다.</b></span>';
					htmlStr +='         </div>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '        <div><span class="infoSearch">** 검색 창에 입력한 키워드가 주소변동이력에 존재하는 경우, 현재 기준의 주소정보 표출</span></div>';
				}
				htmlStr +='             <div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='             <div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='             <div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr += '        </div>';
				htmlStr += '    </td>';
				htmlStr +=' <td class="subj" style="text-align:center;">';
				htmlStr +='     <div id="detDiv'+num+'" style="font-size:12px;">';
				if($(this).find('hstryYn').text() == '1' || $(this).find('relJibun').text() != '' || $(this).find('hemdNm').text() != ''){
					htmlStr +='     <a href="javascript:addrJuminRenew('+num+');" class="infoBtn">상세보기</a>';
				}
				htmlStr +='     </div>';
				htmlStr +='     <div id="detDivX'+num+'" style="display:none;" class="closeBtn"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
				htmlStr +=' </td>';
				
			}else if( resultType == "3" ){
				
				htmlStr +=' <td class="subj" id="roadAddrTd'+num+'">';
				htmlStr +='     <a href="javascript:setMaping(\''+num+'\')" style="color:inherit;">';
				htmlStr +='         <div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b>';
				if($(this).find('ablYn').text() == '1'){
					htmlStr += '        <span class="cancelBtn">폐지</span>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '        <span class="reportBtn">이력</span>';
				}
				htmlStr += '        </div>';
				htmlStr +='     </a>';
				htmlStr +='     <div id="detListDivX'+num+'" style="display:none;" class="juso-detail">';
				if($(this).find('detBdNmList').text() != ''){
					htmlStr +='     <div class="margin_top_3"><span class="infoBox">[상세건물명]</span>';
					if($(this).find('detBdNmList').text().length<100){
						htmlStr +='<span>'+$(this).find('detBdNmList').text()+'</span>';
					}else{
						htmlStr +='<span id="label_detBdNmList_'+num+'}">'+$(this).find('detBdNmList').text().substring(0,80)+'...</span><a href="#this" class="info-more" onclick="javascript:fullText(\'label_detBdNmList_'+num+'\',\''+$(this).find('detBdNmList').text()+'\');">더보기</a>';
					}
					htmlStr +='     </div>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '    <div><span class="infoSearch">** 검색 창에 입력한 키워드가 주소변동이력에 존재하는 경우, 현재 기준의 주소정보 표출</span></div>';
				}
				htmlStr += '        <span id="jibunAddrDiv'+num+'" style="display:none;">'+$(this).find('jibunAddr').text()+'</span>';
				htmlStr +='         <div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='         <div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='         <div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr +='     </div>';
				htmlStr +=' </td>';
				htmlStr +=' <td class="subj" style="text-align:center;">';
				htmlStr +='     <div id="detDiv'+num+'" style="font-size:12px;">';
				if($(this).find('hstryYn').text() == '1' || $(this).find('detBdNmList').text() != ''){
					htmlStr +='     <a href="javascript:addrJuminRenew('+num+');" class="infoBtn">상세보기</a>';
				}
				htmlStr +='     </div>';
				htmlStr +='     <div id="detDivX'+num+'" style="display:none;" class="closeBtn"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
				htmlStr +=' </td>';             
				
			}else{
				
				htmlStr +=' <td class="subj" id="roadAddrTd'+num+'">';
				htmlStr +='     <a href="javascript:setMaping(\''+num+'\')" style="color:inherit;">';
				htmlStr +='         <div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b>';
				if($(this).find('ablYn').text() == '1'){
					htmlStr += '        <span class="cancelBtn">폐지</span>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '        <span class="reportBtn">이력</span>';
				}
				htmlStr += '        </div>';
				htmlStr +='         <span>[지번]</span> <span id="jibunAddrDiv'+num+'">'+$(this).find('jibunAddr').text()+'</span>';
				htmlStr +='     </a>';
				htmlStr +='     <div id="detListDivX'+num+'" style="display:none;" class="juso-detail">';
				if($(this).find('relJibun').text() != ''){
					htmlStr +='     <div class="margin_top_3"><span class="infoBox">[관련지번]</span>';
					if($(this).find('relJibun').text().length<100){
						htmlStr +='<span>'+$(this).find('relJibun').text()+'</span>';
					}else{
						htmlStr +='<span id="label_relJibun_'+num+'}">'+$(this).find('relJibun').text().substring(0,100)+'...</span><a href="#this" class="info-more" onclick="javascript:fullText(\'label_relJibun_'+num+'\',\''+$(this).find('relJibun').text()+'\');">더보기</a>';
					}
					htmlStr +='     </div>';
				}
				if($(this).find('hemdNm').text() != ''){
					htmlStr +='         <div class="margin_top_3">';
					htmlStr +='             <span class="infoBox">[관할주민센터]</span> <span>'+$(this).find('hemdNm').text()+'</span>';
					if($(this).find('hemdNm').text().indexOf(',') > -1){
						htmlStr +='         <br/><span class="infoSearch">※ 해당주소는 관할주민센터가 2개이상이므로, 자세한 사항은 자치단체에 문의하시기 바랍니다.</span>';
					}
					htmlStr +='         <br/><span class="infoBox"><b>※ 관할주민센터는 참고정보이며, 실제와 다를 수 있습니다.</b></span>';
					htmlStr +='         </div>';
				}else{
					htmlStr +='         <div class="margin_top_3">';
					htmlStr +='             <span class="infoBox">[관할주민센터]</span> <span>-</span>';
					htmlStr +='             <br/><span class="infoBox"><b>※ 관할주민센터 정보가 제공되지 않는 주소입니다.</b></span>';
					htmlStr +='         </div>';
				}
				if($(this).find('detBdNmList').text() != ''){
					htmlStr +='     <div class="margin_top_3"><span class="infoBox">[상세건물명]</span>';
					if($(this).find('detBdNmList').text().length < 100){
					//if(true){
						htmlStr +='<span>'+$(this).find('detBdNmList').text()+'</span>';
					}else{
						htmlStr +='<span id="label_detBdNmList_'+num+'}">'+$(this).find('detBdNmList').text().substring(0,80)+'...</span><a href="#this" class="info-more" onclick="javascript:fullText(\'label_detBdNmList_'+num+'\',\''+$(this).find('detBdNmList').text()+'\');">더보기</a>';
					}
					htmlStr +='     </div>';
				}
				if($(this).find('hstryYn').text() == '1'){
					htmlStr += '    <div><span class="infoSearch">** 검색 창에 입력한 키워드가 주소변동이력에 존재하는 경우, 현재 기준의 주소정보 표출</span></div>';
				}
				htmlStr +='         <div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='         <div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='         <div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr +='     </div>';
				htmlStr +=' </td>';
				htmlStr +=' <td class="subj" style="text-align:center;">';
				htmlStr +='     <div id="detDiv'+num+'" style="font-size:12px;">';
				if($(this).find('hstryYn').text() == '1' || $(this).find('detBdNmList').text() != '' || $(this).find('relJibun').text() != '' || $(this).find('hemdNm').text() != ''){
					htmlStr +='     <a href="javascript:addrJuminRenew('+num+');" class="infoBtn">상세보기</a>';
				}
				htmlStr +='     </div>';
				htmlStr +='     <div id="detDivX'+num+'" style="display:none;" class="closeBtn"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
				htmlStr +=' </td>';
				
			}
			
			htmlStr +=' <td class="subj" style="text-align:center" id="zipNoTd'+num+'"> ';
			htmlStr +='     <div id="zipNoDiv'+num+'">'+$(this).find('zipNo').text()+'</div>';
			htmlStr +=' </td>';
			htmlStr +=' <input type="hidden" id="admCdHid'+num+'" value="'+$(this).find('admCd').text()+'">';
			htmlStr +=' <input type="hidden" id="rnMgtSnHid'+num+'" value="'+$(this).find('rnMgtSn').text()+'">';
			htmlStr +=' <input type="hidden" id="bdMgtSnHid'+num+'" value="'+$(this).find('bdMgtSn').text()+'">';
			htmlStr +=' <input type="hidden" id="detBdNmListHid'+num+'" value="'+$(this).find('detBdNmList').text()+'"> ';
			htmlStr +=' <input type="hidden" id="bdNmHid'+num+'" value="'+$(this).find('bdNm').text()+'"> ';
			htmlStr +=' <input type="hidden" id="bdKdcdHid'+num+'" value="'+$(this).find('bdKdcd').text()+'"> ';
			htmlStr +=' <input type="hidden" id="siNmHid'+num+'" value="'+$(this).find('siNm').text()+'">';
			htmlStr +=' <input type="hidden" id="sggNmHid'+num+'" value="'+$(this).find('sggNm').text()+'"> ';
			htmlStr +=' <input type="hidden" id="emdNmHid'+num+'" value="'+$(this).find('emdNm').text()+'"> ';
			htmlStr +=' <input type="hidden" id="liNmHid'+num+'" value="'+$(this).find('liNm').text()+'"> ';
			htmlStr +=' <input type="hidden" id="rnHid'+num+'" value="'+$(this).find('rn').text()+'"> ';
			htmlStr +=' <input type="hidden" id="udrtYnHid'+num+'" value="'+$(this).find('udrtYn').text()+'">  ';
			htmlStr +=' <input type="hidden" id="buldMnnmHid'+num+'" value="'+$(this).find('buldMnnm').text()+'">  ';
			htmlStr +=' <input type="hidden" id="buldSlnoHid'+num+'" value="'+$(this).find('buldSlno').text()+'">  ';
			htmlStr +=' <input type="hidden" id="mtYnHid'+num+'" value="'+$(this).find('mtYn').text()+'">  ';
			htmlStr +=' <input type="hidden" id="lnbrMnnmHid'+num+'" value="'+$(this).find('lnbrMnnm').text()+'">   ';
			htmlStr +=' <input type="hidden" id="lnbrSlnoHid'+num+'" value="'+$(this).find('lnbrSlno').text()+'">  ';
			htmlStr +=' <input type="hidden" id="emdNoHid'+num+'" value="'+$(this).find('emdNo').text()+'">  ';
			htmlStr +='</tr> ';             
		});
		
		htmlStr += '    </tbody>';
		htmlStr += "</table>";
		htmlStr += '<div class="paginate" id="pageApi"></div>';
	}
	
	$(".popSearchNoResult").addClass("result");
	$(".popSearchNoResult").html(htmlStr);
	$("input[name=raFirstSort][value="+ $("#firstSort").val() +"]").attr("checked", true);  // 정확도순, 도로명포함, 지번포함 선택
	$(".result").show();
	$("#resultData").hide();
	$("#searchContentBox").css("min-height","");
	$("#searchContentBox").css("min-height","466px");
	pageMake(xmlStr);
	
}
// xml타입 페이지 처리 (주소정보 리스트 makeList(xmlData); 다음에서 호출) 
function pageMake(xmlStr){
	var total = $(xmlStr).find("totalCount").text(); // 총건수
	var pageNum =  $(xmlStr).find("currentPage").text();// 현재페이지
	var paggingStr = "";
	if(total < 1){
	}else{
		var PAGEBLOCK= parseInt( $(xmlStr).find("countPerPage").text() );
		var pageSize= parseInt( $(xmlStr).find("countPerPage").text() );
		var totalPages = Math.floor((total-1)/pageSize) + 1;
		var firstPage = Math.floor((pageNum-1)/PAGEBLOCK) * PAGEBLOCK + 1;      
		if( firstPage <= 0 ) firstPage = 1;     
		var lastPage = firstPage-1 + PAGEBLOCK;
		if( lastPage > totalPages ) lastPage = totalPages;      
		var nextPage = lastPage+1 ;
		var prePage = firstPage-5 ;     
		if( firstPage > PAGEBLOCK ){
			paggingStr +=  "<a class='skip prev' href='javascript: $(\"#currentPage\").val("+prePage+");  searchUrlJuso();'>이전 5페이지</a>  " ;
		}       
		for( i=firstPage; i<=lastPage; i++ ){
			if( pageNum == i )
				//paggingStr += "<a style='font-weight:bold;color:blue;font-size:15px;' href='javascript:$(\"#currentPage\").val("+i+");  searchUrlJuso();'>" + i + "</a>  ";
				paggingStr += "<strong>"+ i +"</strong>";
			else
				paggingStr += "<a href='javascript:$(\"#currentPage\").val("+i+");  searchUrlJuso();'>" + i + "</a>  ";
		}       
		if( lastPage < totalPages ){
			paggingStr +=  "<a class='skip next' href='javascript: $(\"#currentPage\").val("+nextPage+");  searchUrlJuso();'>다음 5페이지</a>";
		}       
		$("#pageApi").html(paggingStr);
	}   
}   


function setParent(){
	var encodingType = "";
	if(encodingType=="EUC-KR"){
		document.charset ="EUC-KR";//파이어폭스에서 이것만쓰면 깨진다고함
		$("#rtForm").attr("accept-charset","EUC-KR");//이것만사용하면 ie에서 깨진다고함
	}
	var returnUrl = "http://member1.assembly.go.kr:7001/member/pop/jusoPopup.do";
	var rtRoadAddr = $.trim($("#rtRoadAddr").val());
	var rtAddrPart1 = $.trim($("#rtAddrPart1").val());
	var rtAddrPart2 = $.trim($("#rtAddrPart2").val());
	var rtEngAddr = $.trim($("#rtEngAddr").val());
	var rtJibunAddr = $.trim($("#rtJibunAddr").val());
	var rtAddrDetail = '';
	if( $("input:radio[name=raSelectDetailAddrInput]:checked").val() == "select" && 'Y' == '' ){
		var dongNm = $.trim($("#detailAddrDong").val());
		if(dongNm == 'none') dongNm ='';
		var floorNm = $.trim($("#detailAddrFloor").val());
		if(floorNm == 'none') floorNm ='';
		var hoNm = $.trim($("#detailAddrHo").val());
		if(hoNm == 'none') hoNm ='';
		
		// 호정보에 층정보 체크
		if( hoNm.substring(0,hoNm.indexOf("호")).length >= 3 && (hoNm.substring(0,hoNm.length-3) == floorNm.substring(0,floorNm.length-1) )){
			if(dongNm!=''){
				rtAddrDetail = dongNm + (hoNm!='' ? ' '+ hoNm : '');
			}else{
				rtAddrDetail = hoNm;
			}
		}else{
			if(dongNm!=''){
				rtAddrDetail = dongNm + (floorNm!='' ? ' '+ floorNm : '') + (hoNm!='' ? ' '+ hoNm : '');
			}else{
				rtAddrDetail = (floorNm!='' ? floorNm : '') + (hoNm!='' ? ' '+ hoNm : '');
			}
		}
	}else{
		rtAddrDetail = $.trim($("#rtAddrDetail").val());
	}
	var rtZipNo = $.trim($("#rtZipNo").val());
	var rtAdmCd = $.trim($("#rtAdmCd").val());
	var rtRnMgtSn = $.trim($("#rtRnMgtSn").val());
	var rtBdMgtSn = $.trim($("#rtBdMgtSn").val());
	
	// 20170208 API 서비스 제공항목 확대
	var rtDetBdNmList = $.trim($("#rtDetBdNmList").val());
	var rtBdNm = $.trim($("#rtBdNm").val());
	var rtBdKdcd = $.trim($("#rtBdKdcd").val());
	var rtSiNm = $.trim($("#rtSiNm").val());
	var rtSggNm = $.trim($("#rtSggNm").val());
	var rtEmdNm = $.trim($("#rtEmdNm").val());
	var rtLiNm = $.trim($("#rtLiNm").val());
	var rtRn = $.trim($("#rtRn").val());
	var rtUdrtYn = $.trim($("#rtUdrtYn").val());
	var rtBuldMnnm = $.trim($("#rtBuldMnnm").val());
	var rtBuldSlno = $.trim($("#rtBuldSlno").val());
	var rtMtYn = $.trim($("#rtMtYn").val());
	var rtLnbrMnnm = $.trim($("#rtLnbrMnnm").val());
	var rtLnbrSlno = $.trim($("#rtLnbrSlno").val());
	var rtEmdNo = $.trim($("#rtEmdNo").val());
	
	var rtRoadFullAddr = rtAddrPart1;
	if(rtAddrDetail != "" && rtAddrDetail != null){
		rtRoadFullAddr += ", " + rtAddrDetail;
	}
	if(rtAddrPart2 != "" && rtAddrPart2 != null){
		rtRoadFullAddr += "" + rtAddrPart2;
	}
	
	$("#roadFullAddr").val(rtRoadFullAddr);
	$("#roadAddrPart1").val(rtAddrPart1);
	$("#roadAddrPart2").val(rtAddrPart2);
	$("#engAddr").val(rtEngAddr);
	$("#jibunAddr").val(rtJibunAddr);
	$("#addrDetail").val(rtAddrDetail);
	$("#zipNo").val(rtZipNo);
	$("#admCd").val(rtAdmCd);
	$("#rnMgtSn").val(rtRnMgtSn);
	$("#bdMgtSn").val(rtBdMgtSn);
	
	// 20170208 API 서비스 제공항목 확대
	$("#detBdNmList").val(rtDetBdNmList);
	$("#bdNm").val(rtBdNm);
	$("#bdKdcd").val(rtBdKdcd);
	$("#siNm").val(rtSiNm);
	$("#sggNm").val(rtSggNm);
	$("#emdNm").val(rtEmdNm);
	$("#liNm").val(rtLiNm);
	$("#rn").val(rtRn);
	$("#udrtYn").val(rtUdrtYn);
	$("#buldMnnm").val(rtBuldMnnm);
	$("#buldSlno").val(rtBuldSlno);
	$("#mtYn").val(rtMtYn);
	$("#lnbrMnnm").val(rtLnbrMnnm);
	$("#lnbrSlno").val(rtLnbrSlno);
	$("#emdNo").val(rtEmdNo);
	
	
	var jusoJson = {
			"roadAddr": rtRoadFullAddr,
			"addrDetail":  rtAddrDetail,
			"roadAddrPart1": rtAddrPart1,
			"roadAddrPart2": rtAddrPart2,
			"jibunAddr": rtJibunAddr,
			"engAddr": rtEngAddr,
			"zipNo": rtZipNo,
			"admCd": rtAdmCd,
			"rnMgtSn": rtRnMgtSn,
			"bdMgtSn": rtBdMgtSn,
			"detBdNmList": rtDetBdNmList,
			"bdNm": rtBdNm,
			"bdKdcd": rtBdKdcd,
			"siNm":   rtSiNm,
			"sggNm": rtSggNm,
			"emdNm": rtEmdNm,
			"liNm": rtLiNm,
			"rn": rtRn,
			"udrtYn": rtUdrtYn,
			"buldMnnm": rtBuldMnnm,
			"buldSlno": rtBuldSlno,
			"mtYn": rtMtYn,
			"lnbrMnnm": rtLnbrMnnm,
			"lnbrSlno": rtLnbrSlno,
			"emdNo": rtEmdNo
		};
  
  //window.parent.postMessage( jusoJson ,"*");
	if(opener.document.getElementById("apl_zpno") == null){
		opener.$("form[name=writeAccount-dtl-form]").find("input[name=aplZpno]").val(jusoJson.zipNo);
		opener.$("form[name=writeAccount-dtl-form]").find("input[name=apl1Addr]").val(jusoJson.roadAddrPart1);
		opener.$("form[name=writeAccount-dtl-form]").find("input[name=apl2Addr]").val(jusoJson.addrDetail + jusoJson.roadAddrPart2);
	}else{
		opener.document.getElementById("apl_zpno").value = jusoJson.zipNo;
		opener.document.getElementById("apl_addr1").value = jusoJson.roadAddrPart1;
		opener.document.getElementById("apl_addr2").value = jusoJson.addrDetail + jusoJson.roadAddrPart2;
	}

	window.close();
  // opener.doAction.callbackJusoPop(jusoJson);

  
  return;
	
	var iframeFlg = "null";
	if(iframeFlg == "Y"){

		var jusoJson = {
				  "roadAddr": rtRoadFullAddr,
				  "addrDetail":  rtAddrDetail,
				  "roadAddrPart1": rtAddrPart1,
				  "roadAddrPart2": rtAddrPart2,
				  "jibunAddr": rtJibunAddr,
				  "engAddr": rtEngAddr,
				  "zipNo": rtZipNo,
				  "admCd": rtAdmCd,
				  "rnMgtSn": rtRnMgtSn,
				  "bdMgtSn": rtBdMgtSn,
				  "detBdNmList": rtDetBdNmList,
				  "bdNm": rtBdNm,
				  "bdKdcd": rtBdKdcd,
				  "siNm":   rtSiNm,
				  "sggNm": rtSggNm,
				  "emdNm": rtEmdNm,
				  "liNm": rtLiNm,
				  "rn": rtRn,
				  "udrtYn": rtUdrtYn,
				  "buldMnnm": rtBuldMnnm,
				  "buldSlno": rtBuldSlno,
				  "mtYn": rtMtYn,
				  "lnbrMnnm": rtLnbrMnnm,
				  "lnbrSlno": rtLnbrSlno,
				  "emdNo": rtEmdNo
			  };
		
		//window.parent.postMessage( jusoJson ,"*");
		opener.doAction.callbackJusoPop(jusoJson);
	
	}else{
		$("#rtForm").attr("action",returnUrl).submit();
	}
	
	
	
}

function setMaping(idx){
	var browerName = navigator.appName;
	var browerAgent = navigator.userAgent.toLowerCase();
	if(browerName === 'Microsoft Internet Explorer' || browerAgent.indexOf('trident') > -1) {
		$("#searchContentBox").css("min-height","447px");  // 로고 위치 지정
	}else{
		$("#searchContentBox").css("min-height","466px");  // 로고 위치 지정
	}
	
	var roadAddr = $("#roadAddrDiv"+idx).text()
	var addrPart1 = $("#roadAddrPart1Div"+idx).text();
	var addrPart2 = $("#roadAddrPart2Div"+idx).text();
	var engAddr = $("#engAddrDiv"+idx).text();
	var jibunAddr = $("#jibunAddrDiv"+idx).text();
	var zipNo = $("#zipNoDiv"+idx).text();
	
	var admCd = $("#admCdHid"+idx).val();
	var rnMgtSn = $("#rnMgtSnHid"+idx).val();
	var bdMgtSn = $("#bdMgtSnHid"+idx).val();
	
	// 20170208 API 서비스 제공항목 확대 
	var detBdNmList = $("#detBdNmListHid"+idx).val();
	var bdNm = $("#bdNmHid"+idx).val();
	var bdKdcd = $("#bdKdcdHid"+idx).val();
	var siNm = $("#siNmHid"+idx).val();
	var sggNm = $("#sggNmHid"+idx).val();
	var emdNm = $("#emdNmHid"+idx).val();
	var liNm = $("#liNmHid"+idx).val();
	var rn = $("#rnHid"+idx).val();
	var udrtYn = $("#udrtYnHid"+idx).val();
	var buldMnnm = $("#buldMnnmHid"+idx).val();
	var buldSlno = $("#buldSlnoHid"+idx).val();
	var mtYn = $("#mtYnHid"+idx).val();
	var lnbrMnnm = $("#lnbrMnnmHid"+idx).val();
	var lnbrSlno = $("#lnbrSlnoHid"+idx).val();
	var emdNo = $("#emdNoHid"+idx).val();
	
	$("#rtRoadAddr").val(roadAddr);
	$("#rtAddrPart1").val(addrPart1);
	$("#rtAddrPart2").val(addrPart2);
	$("#rtEngAddr").val(engAddr);
	$("#rtJibunAddr").val(jibunAddr);
	$("#rtZipNo").val(zipNo);
	$("#rtAdmCd").val(admCd);
	$("#rtRnMgtSn").val(rnMgtSn);
	$("#rtBdMgtSn").val(bdMgtSn);
	
	// 20170208 API 서비스 제공항목 확대 
	$("#rtDetBdNmList").val(detBdNmList);
	$("#rtBdNm").val(bdNm);
	$("#rtBdKdcd").val(bdKdcd);
	$("#rtSiNm").val(siNm);
	$("#rtSggNm").val(sggNm);
	$("#rtEmdNm").val(emdNm);
	$("#rtLiNm").val(liNm);
	$("#rtRn").val(rn);
	$("#rtUdrtYn").val(udrtYn);
	$("#rtBuldMnnm").val(buldMnnm);
	$("#rtBuldSlno").val(buldSlno);
	$("#rtMtYn").val(mtYn);
	$("#rtLnbrMnnm").val(lnbrMnnm);
	$("#rtLnbrSlno").val(lnbrSlno);
	$("#rtEmdNo").val(emdNo);

	
	if( "Y" == "Y" ){
		$(".result").hide();
	}else{
		$("#resultList").hide();
	}
	$("#resultData").show();
	
	$("#addrPart1").html(addrPart1);
	$("#addrPart2").html(addrPart2);
	
	if( "Y" == "" ){
		$("#raSelectDetailAddrInput01").prop("checked", true);
		clkDAInput($("#raSelectDetailAddrInput01"));
		$("#addrPartDetailNoneGuide").css('visibility', 'hidden');
		
		// 상세주소(동) 가져오기
		$.ajax({
			 url :"/addrlink/addrDetailApi.do"
			,type:"post"
			,data:{ "confmKey": $("#AKCFrm").find("input[name=confmKey]").val(), "admCd": admCd, "rnMgtSn": rnMgtSn, "udrtYn": udrtYn, "buldMnnm": buldMnnm, "buldSlno": buldSlno, "searchType": "dong", "resultType": "json" }
			,dataType:"json"
			,success:function(data){
				if(data.results != undefined){
					detailAddrDongArry = data.results.juso;
					
					// 상세주소(동) selectbox 생성
					getDetailAddrDong();
				}
			}
			,error: function(xhr,status, error){
				alert("오류발생");
			}
		});
	}else{
		$("#rtAddrDetail").focus();
	}
}

var detailAddrDongArry = [];
var detailAddrArry = [];

function getDetailAddrDong(){
	var dong_arry = [];
	var dong_html = '<option value="">\"동\" 선택</option>';
	
	for(var i=0; i < detailAddrDongArry.length; i++){
		if(dong_arry.indexOf(detailAddrDongArry[i].dongNm) == -1){
			dong_arry.push(detailAddrDongArry[i].dongNm);
			if(detailAddrDongArry[i].dongNm != ''){
				dong_html += '<option value="'+detailAddrDongArry[i].dongNm+'">' + detailAddrDongArry[i].dongNm + '</option>';
			}else{
				dong_html += '<option value="none">\"동\" 표기 없음</option>';
			}
		}
	}
	if(dong_arry.length == 0) dong_html = '<option value="none">\"동\" 표기 없음</option>';
	$("#detailAddrDong").html(dong_html);
	
	if(dong_arry.length == 0){
		getDetailAddrFloor('none');
	}
}

function getDetailAddrFloor(val){
	var floor_arry = [];
	var floor_html = '<option value="">\"층\" 선택</option>';
	var under_floor_arry = [];
	var under_floor_html = '';
	
	// 상세주소(층/호) 가져오기
	$.ajax({
		 url :"/addrlink/addrDetailApi.do"
		,type:"post"
		,data:{ "confmKey": $("#AKCFrm").find("input[name=confmKey]").val(), "admCd": $("#rtAdmCd").val(), "rnMgtSn": $("#rtRnMgtSn").val(), "udrtYn": $("#rtUdrtYn").val(), "buldMnnm": $("#rtBuldMnnm").val(), "buldSlno": $("#rtBuldSlno").val(), "searchType": "floorho", "dongNm": val, "resultType": "json" }
		,dataType:"json"
		,success:function(data){
			if(data.results != undefined){
				detailAddrArry = data.results.juso;
				
				for(var i=0; i < detailAddrArry.length; i++){
					if(detailAddrArry[i].floorNm != '' && detailAddrArry[i].floorNm.indexOf("지하") > -1 && under_floor_arry.indexOf(detailAddrArry[i].floorNm) == -1){
						//지하
						if((val == '' || val == 'none') || (val != '' && detailAddrArry[i].dongNm == val)){
							under_floor_arry.push(detailAddrArry[i].floorNm);
							if(val != '') under_floor_html += '<option value="'+detailAddrArry[i].floorNm+'">' + detailAddrArry[i].floorNm + '</option>';
						}
					}else if(detailAddrArry[i].floorNm.indexOf("지하") == -1 && floor_arry.indexOf(detailAddrArry[i].floorNm) == -1){
						//지상
						if((val == '' || val == 'none') || (val != '' && detailAddrArry[i].dongNm == val)){
							floor_arry.push(detailAddrArry[i].floorNm);
							if(val != '') {
								if(detailAddrArry[i].floorNm != ''){
									floor_html += '<option value="'+detailAddrArry[i].floorNm+'">' + detailAddrArry[i].floorNm + '</option>';
								}else{
									floor_html += '<option value="none">\"층\" 표기 없음</option>';
								}
							}
						}
					}
				}
				
				if(floor_arry.length == 0 && under_floor_arry.length == 0 ) floor_html = '<option value="none">\"층\" 표기 없음</option>';
				if(floor_arry.length == 0 && under_floor_arry.length != 0 ) floor_html += '<option value="none">\"층\" 표기 없음</option>';
				if(under_floor_arry.length != 0) floor_html += under_floor_html;
				if(val!=''){
					$("#detailAddrFloor").html(floor_html);
				}else{
					$("#detailAddrFloor").html('<option value="">\"층\" 선택</option>');
				}
				
				if(val != '' && (floor_arry.length != 0 || under_floor_arry.length != 0)){
					$("#detailAddrHo").html('<option value="">\"호\" 선택</option>');
				}else if((val == '' || val=='none')){
					getDetailAddrHo('floor', val);
				}else if(val != '' && (floor_arry.length == 0 && under_floor_arry.length == 0)){
					getDetailAddrHo('dong', val);
				}
			}
		}
		,error: function(xhr,status, error){
			alert("오류발생");
		}
	});
}

function getDetailAddrHo(gubun, val){
	var ho_arry = [];
	var ho_html = '<option value="">\"호\" 선택</option>';
	// 층 선택하기전에 선택한 동 정보
	var dong_selected = ($("#detailAddrDong option:selected").val() == "none" ? "" : $("#detailAddrDong option:selected").val());
	var floor_selected = (val == "none" ? "" : val);
	
	for(var i=0; i < detailAddrArry.length; i++){
		if(gubun == 'floor'){
			if(ho_arry.indexOf(detailAddrArry[i].hoNm) == -1){
				if((val == '') || ((val != '' || val == 'none') && detailAddrArry[i].dongNm == dong_selected && detailAddrArry[i].floorNm == floor_selected)){
					ho_arry.push(detailAddrArry[i].hoNm);
					if(val != ''){
						if(detailAddrArry[i].hoNm != ''){
							ho_html += '<option value="'+detailAddrArry[i].hoNm+'">' + detailAddrArry[i].hoNm + '</option>';
						}else{
							ho_html += '<option value="none">\"호\" 표기 없음</option>';
						}
					}
				}
			}
		}else if(gubun == 'dong'){
			if(ho_arry.indexOf(detailAddrArry[i].hoNm) == -1){
				if(val != '' && detailAddrArry[i].dongNm == val){
					ho_arry.push(detailAddrArry[i].hoNm);
					if(val != ''){
						if(detailAddrArry[i].hoNm != ''){
							ho_html += '<option value="'+detailAddrArry[i].hoNm+'">' + detailAddrArry[i].hoNm + '</option>';
						}else{
							ho_html += '<option value="none">\"호\" 표기 없음</option>';
						}
					}
				}
			}
		}
	}
	
	if(ho_arry.length == 0) ho_html = '<option value="none">\"호\" 표기 없음</option>';
	if(val == 'none' && ho_arry.length == 0){
		$("#detailAddrHo").html('<option value="none">\"호\" 표기 없음</option>');
		if(detailAddrDongArry.length == 0 && detailAddrArry == 0){
			$("#addrPartDetailNoneGuide").css('visibility', 'visible');
		}
	}else if(val == 'none' && ho_arry.length != 0){
		$("#detailAddrHo").html('<option value="">\"호\" 선택</option>');
	}else if(val != ''){
		$("#detailAddrHo").html(ho_html);
	}else if(val == ''){
		$("#detailAddrHo").html('<option value="">\"호\" 선택</option>');
	}
	
}

function init(){
	var browerName = navigator.appName;
	var browerAgent = navigator.userAgent.toLowerCase();
	if(browerAgent.indexOf('edge/') > -1 || browerAgent.indexOf('edg/') > -1){
		self.resizeTo(590, 640);
	}else{
		self.resizeTo(590, 640);
	}
	
	if("E0005" =="P0001" && "" == "1"){
		alert("검색 결과가 너무 많습니다(1,000건 이상)\n검색어 예를 참조하여 검색하시기 바랍니다.");
	}
	
	if("E0005" =="E0005"){
		//alert("검색어가 입력되지 않았습니다.");
	}
	$("#keyword").focus();
	
}

$(document).ready(function(){
	placeHolder();
	$('#searchRdNm').bind('click', function(){
		$('.popWrap3').css({'display':'block','top':'21px','right':'121px'});
	});
	$('#popupClose2').bind('click', function(){
		$('.popWrap3').css('display','none');
	});
	
	$('.choIdx a').click(function(event){
		$('.choIdx a').removeClass('on');
		if($(this).hasClass('off')){
			return;
		}else{
			$(this).addClass('on');
			event.preventDefault();
			var target =this.hash;
			var $target=$(target);
			var top = $(target).position().top-106;
			if(prevPosition ==0){
				$('#roadNameList2').scrollTop(top);
				prevPosition = top;
			}else{
				$('#roadNameList2').scrollTop(prevPosition+top);
				prevPosition = prevPosition + top;
			}
			
			if($('#roadNameList2')[0].scrollHeight - $('#roadNameList2').scrollTop() == $('#roadNameList2').innerHeight()){
				prevPosition = $('#roadNameList2').scrollTop();
			}
		}
	});
	$('#roadNameList2').children().css('display','none');
	$('#roadNameList2').scroll(function(){prevPosition = this.scrollTop;});
});
window.onresize = placeHolderPoint;

function placeHolderPoint(){
	$(":input[placeholderTxt]").each(function(){
		var labelId = "label"+this.id;
		var objVal = $(this).val();
		var placeTxt = $(this).attr("placeholderTxt");
		var left = parseInt($(this).offset().left);
		var top = parseInt($(this).offset().top);
		
		$("#"+labelId).css({"left":left+"px","top":top+"px"});
	});
}

function placeHolder(){
	$(":input[placeholderTxt]").each(function(){
		var labelId = "label"+this.id;
		var objVal = $(this).val();
		var placeTxt = $(this).attr("placeholderTxt");
		var left = parseInt($(this).offset().left);
		var top = parseInt($(this).offset().top);
		$(this).after("<label for='"+this.id+"' id='"+labelId+"' style ='position:absolute;left:"+left+"px;top:"+top+"px; font-size:15px;color:#1898d2;font-weight:bold; padding-left:10px;padding-top:11px;'><b>"+placeTxt+"</b></label>");
		
		if(objVal !=""){
			$("#"+labelId).hide();
		}
		
		$(this).focus(function(){
			$("#"+labelId).hide();
		});
		
		$(this).blur(function(){ 
			if($(this).val() == ""){
				$("#"+labelId).show();
			}
		});
	});
}

function searchTab(tabNum){
	resetDetailSearch()
	if(tabNum == 0){
		$("#roadTr1").show();
		$("#roadTr2").show();
		$("#jibunTr1").hide();
		$("#jibunTr2").hide();
		$("#buildTr1").hide();
		$("#buildTr2").hide();
	}else if(tabNum == 1){
		$("#roadTr1").hide();
		$("#roadTr2").hide();
		$("#jibunTr1").show();
		$("#jibunTr2").show();
		$("#buildTr1").hide();
		$("#buildTr2").hide();
	}else if(tabNum == 2){
		$("#roadTr1").hide();
		$("#roadTr2").hide();
		$("#jibunTr1").hide();
		$("#jibunTr2").hide();
		$("#buildTr1").show();
		$("#buildTr2").show();
	}
}

function detailSearch(){
	var dssearchType1 = $("input:radio[name=dssearchType1]:checked").val();
	var dscity1Val = $("#dscity1 option:selected").val();
	var dscounty1Val = $("#dscounty1 option:selected").val();
	if(dscity1Val == ""){
		alert("시도를 선택하세요.");
		return;
	}
	if(dscounty1Val == ""){
		alert("시군구를 선택하세요.");
		return;
	}

	var dscity1 = $("#dscity1 option:selected").text();
	var dscounty1 = $("#dscounty1 option:selected").text();
	var dstown = "";
	var dssan=0;
	var searchStr =  dscity1 + " " + dscounty1
	if(dssearchType1 == "road"){
		var dsrdNm1Val = $("#dsrd_nm1 option:selected").val();
		if(dsrdNm1Val == ""){
			alert("도로명을 선택하세요.");
			return;
		}
		var dsrdNm1 = $("#dsrd_nm1 option:selected").text();
		var dsma = $("#dsma").val();
		if(dsma == ""){
			alert("건물본번을 입력하세요.");
			return;
		}
		var dssb = $("#dssb").val();
		var dssbDash = "";
		if(dssb != ""){
			dssbDash = "-";
		}
		searchStr =  searchStr + " " + dsrdNm1 +" "+ dsma +dssbDash+dssb
	}else if(dssearchType1 == "jibun"){
		var dstown1Val = $("#dstown1 option:selected").val();
		
		if(dstown1Val == ""){
			alert("읍면동/리 를 선택하세요.");
			return;
		}
		dstown = $("#dstown1 option:selected").text();
		
		searchStr =  searchStr + " " + dstown;
		
		var dsri1Val = $("#dsri1 option:selected").val();
		if(dsri1Val != ""){
			var dsri1 = $("#dsri1 option:selected").text();
			searchStr =  searchStr + " " + dsri1
		}
		
		var dschSan = $("input:checkbox[name='dsch_san']").is(":checked");
		if(dschSan == true){
			searchStr =  searchStr + " 산";
			dssan = 1;
		}
		
		var dsbun1 = $("#dsbun1").val();
		if(dsbun1 == ""){
			alert("본번을 입력하세요.");
			return;
		}
		var dsbun2 = $("#dsbun2").val();
		var dsbun2Dash=""
		if(dsbun2 != ""){
			dsbun2Dash = "-";
		}
		searchStr =  searchStr + " " +dsbun1 + dsbun2Dash + dsbun2
	}else if(dssearchType1 == "building"){
		var dstown2Val = $("#dstown2 option:selected").val();
		if(dstown2Val == ""){
			alert("읍면동을 입력하세요.");
			return;
		}
		dstown = $("#dstown2 option:selected").text();
		searchStr = searchStr + " " + dstown;
		var dsbuilding1 = $.trim($("#dsbuilding1").val());
		if(dsbuilding1 == ""){
			alert("건물명을 입력하세요.");
			$("#dsbuilding1").val("");
			return;
		}
		searchStr = searchStr + " " + dsbuilding1;
	}
	$("#keyword").focus();
	$("#keyword").val(searchStr);
	$("#resultList").hide();
	$("#resultData").hide();
	
	$("#searchType").val("DETAIL");
	$("#dsgubuntext").val(dssearchType1); //구분
	$("#dscity1text").val(dscity1); //시도
	$("#dscounty1text").val(dscounty1); //시군구
	$("#dsemd1text").val(dstown); //읍면동
	$("#dsri1text").val(dsri1); //리
	$("#dsrd_nm1text").val(dsrdNm1); //도로명
	$("#dsbuilding1").val(dsbuilding1); //건물명
	$("#dssan1text").val(dssan); //산
	$("#dsma").val(dsma); //건물본번
	$("#dssb").val(dssb); //건물부번
	$("#dsbun1").val(dsbun1); //본번
	$("#dsbun2").val(dsbun2); //부번       
	$("#AKCFrm").attr("action","/addrlink/addrLinkUrlSearch.do").submit();
}

function isNumChk(){
	var evtCode = (window.netscape) ? ev.which : event.keyCode;
	if((evtCode < 48 || evtCode > 57) && evtCode!=8){ 
		event.preventDefault(); 
	}
}
function detailEnterSearch(){
	var evtCode = (window.netscape) ? ev.which : event.keyCode;
	if (evtCode == 13) {
		event.keyCode = 0;  
		detailSearch();
	} 
}

function addrDetailChk(){
	var evtCode = (window.netscape) ? ev.which : event.keyCode;
	if(evtCode == 63 || evtCode == 35 || evtCode == 38 || evtCode == 43 || evtCode == 92 || evtCode == 34){ // # & + \ " 문자제한
		alert('특수문자 ? # & + \\ " 를 입력 할 수 없습니다.');
		if(event.preventDefault){
			event.preventDefault();
		}else{
			event.returnValue=false;
		}
	}
}

function addrDetailChk1(obj){
	if(obj.value.length > 0){
		var expText = /^[^?#&+\"\\]+$/;
		if(expText.test(obj.value) != true){
			alert('특수문자 ? # & + \\ " 를 입력 할 수 없습니다.');
			obj.value="";
		}
	}
}

function popClose(){
	window.close();
}

function addrJuminRenew(idx){
	$("#detDivX"+idx).show();
	$("#detListDivX"+idx).show();
	$("#detDiv"+idx).hide();
	
	var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
	if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
		docHeight += 128;
		$("#searchContentBox").css("min-height",docHeight+"px");// 로고 위치 지정
	}else{
		$("#searchContentBox").css("min-height","466px");// 로고 위치 지정
	}
}
function addrJuminRenewX(idx){
	$("#detDivX"+idx).hide();
	$("#detListDivX"+idx).hide();
	$("#detDiv"+idx).show();
	
	var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
	if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
		docHeight += 128;
		$("#searchContentBox").css("min-height",docHeight+"px");// 로고 위치 지정
	}else{
		$("#searchContentBox").css("min-height","466px");// 로고 위치 지정
	}
}

function inputTxt(){
	$('#keyword').val($('#selectRdNm').val());
	$('.popWrap3').css('display','none');
	$('.choIdx a').removeClass('on');
}

function fullText(obj,idx,fulText){
	$("#"+idx).html(fulText);
	$(obj).hide();
}

$(function(){
	var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
	
	if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
		docHeight += 128;
		$("#searchContentBox").css("min-height",docHeight+"px");// 로고 위치 지정
	}else{
		$("#searchContentBox").css("min-height","466px");// 로고 위치 지정
	}
	
	//우선정렬 라디오 클릭
	$(document).on("click", "input:radio[name=raFirstSort]", function(){
		$('#firstSort').val(this.value);
		$('#currentPage').val(1);
		searchUrlJuso();
	});
	//변동된 주소정보 포함여부 클릭
	$("#ckHstryYn").click(function(){
		if($( "#ckHstryYn").is(":checked")){
			$("#hstryYn").val('Y');
		}else{
			$("#hstryYn").val('N');
		}
		//$("#keyword").focus();
		$(this).focus();	// 접근성
	}).on("keydown", function(event) {
		// 접근성
		if (event.which == 13) {
			$("#ckHstryYn").click();
		}
	});
	
	$("#keyword").focus();
	
	$("#keyword").on("keydown", function(event){
		if (event.which == 13) {
			event.keyCode = 0;
			$("#currentPage").val(1);
			$('#raFirstSortNone').prop('checked',true);
			searchUrlJuso(); 
		}
	});
	
});

function clkDAInput(obj){
	if($(obj).val() == 'select'){
		$('#divSelectDetailAddr').css("display", "block");
		if(detailAddrDongArry.length == 0 && detailAddrArry == 0){
			$("#addrPartDetailNoneGuide").css('visibility', 'visible');
		}
		$('#rtAddrDetail').css("display", "none");
		$('#rtAddrDetail').val("");
	}else{
		$('#divSelectDetailAddr').css("display", "none");
		$("#addrPartDetailNoneGuide").css('visibility', 'hidden');
		$('#rtAddrDetail').css("display", "block");
		$('#detailAddrDong option:eq(0)').prop("selected", true);
		$('#detailAddrFloor').children('option:not(:first)').remove();
		$('#detailAddrHo').children('option:not(:first)').remove();
		
	}
}