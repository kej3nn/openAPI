/**
 * 광명의 하루 메뉴를 관리하는 스크립트 파일이다.
 *
 * @author 김정호
 * @version 1.0 2018/01/22
 */
$(function() {
	
    bindEvent();

    loadData();
    
});

//////////////////////////////////////////////////////////
//////////////// global /////////////////////////////
/////////////////////////////////////////////////////////
function bindEvent() {
	$("#wrttimeStartYear").bind("change", function(e) {
		selectStatOnedayList();
	});
}

function loadData() {
	
	selectStatOnedayList();
}

//////////////////////////////////////////////////////////
/////////////////// 조회 서비스 //////////////////////
/////////////////////////////////////////////////////////
// 데이터 조회
function selectStatOnedayList() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/custom/gmOnedayList.do",
        before:function () {
        	var data = {
        		wrttimeIdtfrId : $("#wrttimeStartYear").val() + "00"
        	};
        	return data;
        },
        after: afterStatOnedayList
    });
}

/////////////////////////////////////////////////
///////////////// 후처리 함수 ////////////////
////////////////////////////////////////////////

function afterStatOnedayList(data) {
	for ( var i=0; i < data.length; i ++ ) {
		$("#itm" + data[i].datano).text(data[i].dtaVal);
	}
}


//////////////////////////////////////////////////////////
