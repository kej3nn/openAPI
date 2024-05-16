
$(function(){
	

	$("#city").change(function(){
		
		var from = "city";
		var to = "county";
		var valFrom = $(this, "option: selected").val();
		
		if(valFrom == '36'){
			$('#county').attr('disabled', 'disabled');
		}else{
			$('#county').removeAttr('disabled');
		}
		
		if(valFrom == "36") {
			
		} else if(valFrom != null && valFrom != ""){
			$("#"+to).html("<option value=\"\">선택</option>");	
			searchCounty(from, to, valFrom);	
		}else{
			alert("시/도를 선택하세요.");
		}
		
		
	});
	
});


/**
 * 도시 검색 
 * @param from
 * @param to
 * @param valFrom
 */
function searchCounty(from, to, valFrom){
	
	
	$.ajax({
		type: "post",
		url: "https://www.assembly.go.kr/join/ajaxResultGungus.do",
		data: {city:valFrom},
		dataType: "jsonp",
		jsonpCallback : "myCallback",
		error: function(e){
			alert("error: " + e);
		},
		success: function(data){

			var html = "<option value=\"\">선택</option>";
			
			$.each(data.arrykey, function(index,item) {
				html += "<option value=\""+item+"\">"+item+"</option>";
			});
			
			if(html != null && html != ""){
				$("#"+to).html(html);	
			}
		}
	});
	
}


/**
 * 지번검색
 * @param currentPage
 */
function searchJibunAddress(currentPage){

	var engineCity = $('#city').val(); 
	var engineCounty = $('#county').val();

	var engineEmdNm = $('#engineEmdNm').val(); 
	var engineBdMaSn = $('#engineBdMaSn').val();
	var engineBdSbSn = $('#engineBdSbSn').val();
	
	if(engineCity == null || engineCity == ''){
		alert('시도를 선택해주세요');
		$('#city').focus();
		return false;
	}	
	
	if((engineCounty == null || engineCounty == '')  && engineCity != '36'){
		alert('시군구를 선택해주세요');
		$('#county').focus();
		return false;
	}	
	
	
	if(engineEmdNm == null || engineEmdNm == ''){
		alert('지역명을 입력해주세요');
		$('#engineEmdNm').focus();
		return false;
	}

	$('#currentPage').val(currentPage); 
	
	$.ajax({
		type: "post",
		url: "https://www.assembly.go.kr/join/ajaxResultPosts.do",
		data: {
			searchType:encodeURI($('#searchType').val())
			, city:$('#city').val()
			, county:encodeURI($('#county').val())
			, engineEmdNm:encodeURI($('#engineEmdNm').val())
			, currentPage:$('#currentPage').val()
			, engineBdMaSn:$('#engineBdMaSn').val()
			, engineBdSbSn:$('#engineBdSbSn').val()
		},
		dataType: "jsonp",
		jsonpCallback : "myCallback",
		error: function(e){
			alert("error: " + e);
		},
		success: function(data){
			parsingResult(data);
		}
	});
}



/**
 * 도로명주소 검색 
 * @param currentPage
 * @returns {Boolean}
 */
function searchDoroAddress(currentPage){

	var cityText = $('#city option:selected').text();
	var countyText= $('#county option:selected').text();
	
	var rd_nm = $('#rd_nm').val();
	
	var townText='';
	var orgNm='서울시청', orgCode='';
	
	if($('#city option:selected').val() == '' || $('#city option:selected').val() == null){
		alert('시/도를 선택하세요');
		$('#city').focus();
		return false;
		
	}
	
	
	if(($('#county option:selected').val() == '' || $('#county option:selected').val() == null) && $('#city option:selected').val() != '36'){
		alert('시군구를 선택하세요');
		$('#county').focus();
		return false;
	}
	
	if($('#rd_nm').val() == ''){
		alert('도로명을 입력하세요');
		$('#rd_nm').focus();
		return false;
	}

	$('#currentPage').val(currentPage); 
	
	$.ajax({
		type: "post",
		url: "https://www.assembly.go.kr/join/ajaxResultPosts.do",
		data: {
			searchType:encodeURI($('#searchType').val())
			, city:encodeURI($('#city option:selected').val())
			, county:encodeURI($('#county option:selected').val())
			,rd_nm:encodeURI($('#rd_nm').val())
			, currentPage:$('#currentPage').val()
			, ma:$('#ma').val()
			, sb:$('#sb').val()
		},
		dataType: "jsonp",
		jsonpCallback : "myCallback",
		error: function(e){
			alert("error: " + e);
		},
		success: function(data){
			parsingResult(data);
		}
	});
}


function parsingData(data){
	var html = "<option value=\"\">선택</option>";
	
	$(data).find("name").each(function(){
		var name = $(this).text();
		var value = $(this).next().next().text();
		html += "<option value=\""+value+"\">"+name+"</option>";
		
	});
	
	return html;
}




function parsingResult(data){

	var pageHtml = "";
	var addrHtml = "";
	
	if(data.postList.length > 0){
		var currentPage = data.intCurrentPage;
		var totalCount = data.totalCount;
		var intCountPerPage = data.intCountPerPage;
		var blockFirstPage = data.blockFirstPage;
		var blockLastPage = data.blockLastPage;
		var lastPage = data.lastPage;
		var moveURL = "";
		
		pageHtml = getPaging2(totalCount, "10", currentPage, lastPage, moveURL, blockFirstPage, blockLastPage);
		
		$.each(data.postList, function(i, item){
			
			addrHtml += "<ul>";
			addrHtml += "<li>";
			
			var addrDisplayVal = "";
			var addrReturnVal = "";
			
			addrDisplayVal += "<span class=\"addr_si\">" +item["sido"] + "</span> <span class=\"addr_sgg\">";
			addrReturnVal += item["sido"];
			
			if(item["gungu"] != null && item["gungu"] != "" && item["gungu"] != 0){
				addrDisplayVal += " " + item["gungu"];
				addrReturnVal += " " + item["gungu"];
			}
			
			if(item["eupmyun"] != null && item["eupmyun"] != "" && item["eupmyun"] != 0){
				addrDisplayVal += " " + item["eupmyun"];
				addrReturnVal += " " + item["eupmyun"];
			}

			addrDisplayVal += "</span> <span class=\"addr_rod\"> " + item["doroNm"]+" "+item["bldgNo1"];
			addrReturnVal += " " + item["doroNm"]+" "+item["bldgNo1"];
			
			if(item["bldgNo2"] != null && item["bldgNo2"] != "" && item["bldgNo2"] != 0){
				addrDisplayVal += "-" + item["bldgNo2"];
				addrReturnVal += "-" + item["bldgNo2"];
			}
			
			addrHtml += "<a href=\"#\" class=\"result_item\" onclick=\"javascript:setDataParent('"+item["areaCode"]+"','"+addrReturnVal+"');\">";
			addrHtml += "<span class=\"result_zip\">"+item["areaCode"]+ "</span> <span class=\"result_address\"> ";
			addrHtml += addrDisplayVal;
			addrHtml += "</span></span><span id='gldbMnoKey' style='display:none;'>"+item["gldbMno"]+"</span></a>";
			addrHtml += "</li>";
			addrHtml += "</ul>";
		});

	}else{
		var addrHtml = "<ul><li>조회 된 정보가 없습니다.</li></ul>";
	}
	
	$('#doro_info').hide();
	$('#result_data_list').html(addrHtml);
	$('#result_data_list').show();

	$('#result_data_page').html(pageHtml);
	$('#result_data_page').show();
}


function getPaging2(totalCount, pagePerRows, currentPage, lastPage, moveURL, blockFirstPage, blockLastPage) {
	 if(totalCount <= pagePerRows)  return "";
	 
	 var returnStr = "";
	 
	 if(currentPage > 1 ) {
		 returnStr += " <a href=\"javascript:goPage('1');\" class=\"addr_page\">처음</a> ";
		
	 }
	 if(blockLastPage > 10 ) {
		 returnStr  += "<a href=\"javascript:goPage('"+(blockFirstPage-1)+"');\" class='addr_page'>이전</a> "; 
	 }
	 
	 for(i=blockFirstPage; i <= blockLastPage ; i++) {
		 
		 if(currentPage != i ) {
			 returnStr += " <a href=\"javascript:goPage('"+i+"');\" class='addr_page'>" + i + "</a> ";	 
		 } else {
			 returnStr += " <span>"+i+"</span> ";	 
		 }
		 
	 }
	 
     // sPageScale 만큼 뒤로 이동
	 if(blockLastPage < lastPage ) {
    	 returnStr += " <a href=\"javascript:goPage('"+(blockLastPage+1)+"');\" class='addr_page'>다음</a> ";
     }
	 
     if(currentPage < lastPage ) {
    	 returnStr += "<a href=\"javascript:goPage('"+lastPage+"');\" class='addr_page'>마지막</a>";
     }
	 
	 return returnStr;
	 
}

function getPaging(fListScale,fPageScale,fTotal,fStart,fPagingUrl) {
	 if(fStart=='1')
		 fStart = fStart-1;
    var fReturn = "";
    var fPage;
    var fPP;
    var fNP;
    var fPreStart;
    var fLn;
    var fVk;
    var fNstart;
    var fLast;
    if(fTotal > fListScale) {
        fPage =  Math.floor(fStart/(fListScale*fPageScale));


        fPP=fStart-fListScale;
        fNP=parseInt(fStart)+parseInt(fListScale);
        // 처음으로 이동
        if(fPP>=0) {
       	 fReturn = fReturn + " <a href=\"javascript:goPage('1');\" class=\"addr_page\">처음</a> ";
        }

        // sPageScale 만큼 앞으로 이동
        if( fStart+1 >  fListScale*fPageScale ) {
            fPreStart = fListScale*(fPage*fPageScale - 1);
            if(fPreStart<0)
           	 fPreStart=-fPreStart;
            fReturn  = fReturn + "<a href=\"javascript:goPage('"+fPreStart+"');\" class='addr_page'>이전</a> ";

        }

        // sPageScale 만큼 출력
        for(i=0; i < fPageScale ; i++) {
            fLn = (fPage * fPageScale + i)*fListScale;
            fVk= fPage * fPageScale + i+1;

            if(fLn<fTotal) {

					if(fLn!=fStart) {
						fReturn  = fReturn + " <a href=\"javascript:goPage('"+fVk+"');\" class='addr_page'>" + fVk + "</a> "; }
					else {
						fReturn  = fReturn + " <span>" + fVk + "</span> ";}
	          }
        }

        // sPageScale 만큼 뒤로 이동
        if(fTotal > ((fPage+1)*fListScale*fPageScale)) {
            fNstart=(fPage+1)*fListScale*fPageScale;
            fReturn  = fReturn + " <a href=\"javascript:goPage('"+fNstart+"');\" class='addr_page'>다음</a> ";
        }

        // 마지막 페이지

        if(fNP<fTotal) {
            fLast = (Math.floor(fTotal/fListScale))*fListScale;
            fReturn  = fReturn + "<a href=\"javascript:goPage('"+fLast+"');\" class='addr_page'>마지막</a>";
        }
    }
    return fReturn;
}

function setDataParent(zipcode, addr){
	if(opener.document.getElementById("apl_zpno") == null){
		opener.$("form[name=writeAccount-dtl-form]").find("input[name=aplZpno]").val(zipcode);
		opener.$("form[name=writeAccount-dtl-form]").find("input[name=apl1Addr]").val(addr);
	}else{
		opener.document.getElementById("apl_zpno").value = zipcode;
		opener.document.getElementById("apl_addr1").value = addr;
	}
	
	window.close();
}

function goPage(page){
	$("#currentPage").val(page);
	if($("#searchType").val() == "DORO") searchDoroAddress(page);
	else searchJibunAddress(page);
}
