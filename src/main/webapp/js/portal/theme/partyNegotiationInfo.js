/**
 * 정당 및 교섭단체 관련 스크립트 파일이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/24
 */

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {

	// 이벤트를 바인딩한다.
	bindEvent();
	
	// 데이터를 조회한다.
	loadData();
});


/**
 * 데이터를 조회한다.
 */
function loadData() {
	
	//트리맵 데이터 조회(정당별)
	//selectTreeMapData();
	
	//아이템차트 데이터 조회(정당별)
	selectParliamentData();
	
	// 정당 및 교섭단체 의석수
	selectHgNumSeat();
	
	//호출 url 따라 타이틀변경;; ( 국회의원 > 정당 및 교섭단체 현황 / 테마정보 공개 > 정당 및 교섭단체 정보) 
	if(window.location.href.indexOf("assm")> -1) {
		$(".contents-title-wrapper h3").text("정당 및 교섭단체 현황");
	}else {
		$(".contents-title-wrapper h3").text("정당 및 교섭단체 정보");
	}
	
}

/**
 * 이벤트를 바인딩한다.
 * @returns
 */
function bindEvent() {
	//팝업창 닫기
	$("#btn_close").bind("click", function(event) {
		window.close();
	});
}

/** 
 * TreeMap 데이터 조회
* @returns
*/
function selectTreeMapData() {
	doAjax({
		url: "/portal/theme/visual/selectTreeMapData.do",
		callback: function(res) {
			var data = res.data;
			loadTreeMapChart(data);
		}
	});
}

/** 
 * Parliamen차트 데이터 조회
* @returns
*/
function selectParliamentData() {
	doAjax({
		url: "/portal/theme/visual/selectParliamentData.do",
		callback: function(res) {
			var data = res.data;
			loadParliamenChart(data);
		}
	});
}

/**
 * 트리맵 차트 로드
 * @param data	
 * @returns
 */
function loadTreeMapChart(data) {
	var chart = Highcharts.chart('chartTreeMapContainer', {
		series: [{
	        type: 'treemap',
	        layoutAlgorithm: 'squarified',
	        data: data,
	        dataLabels: {
	        	enabled: true,
			    formatter: function() {
			    	var key = this.key,
           			point = this.point,
           			value = point.value;
         			return value && point ? key + ': ' + value +'명': key;
         			}
	    		}
	    }],
	    title: {
	        text: ''
	    },
	    plotOptions: {
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                             var name = this.name;
                        	goMemberSchPage(name);
                        }
                    }
                }
            }
        },
	    credits: {enabled: false},
	    exporting: {enabled: false}
	    
	});
}

/**
 * Parliamen차트 데이터 조회 로드
 * @param data	
 * @returns
 */
function loadParliamenChart(data) {
	
	var chart = Highcharts.chart('chartParliamenContainer', {
		chart: {
			type: 'item'
		},

	    title: {
	        text: ''
	    },
	    legend: {
	        labelFormat: '{name} <span>{y}</span>'
	    },
	    plotOptions: {
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                             var name = this.name;
                             goMemberSchPage(name);
                        }
                    }
                }
            }
        },
	    series: [{
	    	name: '인원',
	        data: data,
	        dataLabels: {
	        	enabled: false,
	            format: '{point.label}'
	        },
	        center: ['50%', '88%'],
	        size: '170%',
	        startAngle: -100,
	        endAngle: 100
	    }],
	    credits: {enabled: false},
	    exporting: {enabled: false}
	});
}


function selectHgNumSeat() {
	doAjax({
		url: "/portal/theme/visual/selectHgNumSeat.do",
		callback: function(res) {
			//var data = res.data;
			//console.log(data);
			var sect = $("#hgNuMSeat-result-sect");
			
			if ( res.data.length > 0 ) {
				sect.empty();
				
				_.each(res.data, function(data, idx) {
					var row = $("<tr><td></td><td class=\"pgn\"></td><td class=\"pn\"></td><td></td><td></td><td></td><td></td></tr>");
					row.find("td").eq(0).text(idx+1);
					row.find("td").eq(1).text(data.polyGroupNm);
					row.find("td").eq(2).text(data.polyNm);
					row.find("td").eq(3).text(data.n1);
					row.find("td").eq(4).text(data.n2);
					row.find("td").eq(5).text(data.n3);
					row.find("td").eq(6).text(data.n4);
					sect.append(row);
				});
				
				
				setTableColMerge();			// 테이블의 교섭단체, 정당 컬럼을 머지한다.
				
				gfn_tableRowMerge("pgn");	// 테이블 행을 머지한다.
			}
		}
	});
}

// 테이블의 교섭단체, 정당 컬럼을 머지한다.
function setTableColMerge() {
	var sect = $("#hgNuMSeat-result-sect");
	
	sect.find("tr").each(function() {
		var pgn = $(this).find(".pgn");
		var pn = $(this).find(".pn");

		if ( pn.text() == pgn.text() ) {
			pgn.attr("colspan", 2);
			pn.remove();
		}
	});
}

/**
 * 국회의원 검색 페이지로 이동한다.
 * @param name
 * @returns
 */
function goMemberSchPage(name){
	
	//초기화
	$("input[name=name]").val("");
	 
	var form = $("form[name=searchForm]");
	 
    $("input[name=name]").val(name);
	
	
	//청구서(팝업) 조회 페이지 이동
	form.attr("action", com.wise.help.url("/portal/assm/search/memberSchPage.do"));
	form.attr("target", "_blank");
	form.submit();
}