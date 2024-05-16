$(function() {
    // �̺�Ʈ�� ���ε��Ѵ�.
    bindEvent();
    
    // �����͸� �ε��Ѵ�.
    loadData();
});

////////////////////////////////////////
//////// global ///////////
/////////////////////////////////
// ���� ����
var filter;

/**
 * �̺�Ʈ�� ���ε��Ѵ�.
 */
function bindEvent() {
	
	// ��� ��ư�� Ű�ٿ� �̺�Ʈ�� ���ε��Ѵ�.
    $("#visual-search-btn").bind("keydown", function(event) {
        if (event.which == 13) {
            // �Խ��� ������ �˻��Ѵ�.
            searchVisual($("#visual-search-form [name=page]").val());
            return false;
        }
    });
    
    // ��� ��ư�� Ŭ�� �̺�Ʈ�� ���ε��Ѵ�.
    $("#visual-search-btn").bind("click", function(event) {
        // ������ �Խ��� ������ �˻��Ѵ�.
    	searchVisual($("#visual-search-form [name=page]").val());
        return false;
    });

}

/**
 * �����͸� �ε��Ѵ�.
 */
function loadData() {
    // �Խ��� ������ ��ȸ�Ѵ�.
    selectVisual();
}

////////////////////////////////////////////////////////////////////////////////
//���� �Լ�
////////////////////////////////////////////////////////////////////////////////
/**
* �Խ��� ������ ��ȸ�Ѵ�.
*/
function selectVisual() {
	// �����͸� ��ȸ�Ѵ�.
	doSelect({
		url:"/portal/data/visual/selectVisualData.do",
		before:beforeSelectVisual,
		after:afterSelectVisual
	});
}

/**
 * ������� �̵��Ѵ�.
 */
function searchVisual(page) {
    // �����͸� �˻��ϴ� ȭ������ �̵��Ѵ�.
    goSearch({
        url:"/portal/data/visual/searchVisualMainPage.do",
        form:"visual-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}

/**
 * �����ͼ� ȭ������ �̵��Ѵ�.
 * 
 * @param data {Object} ������
 */
function selectDataset() {
    // �����͸� ��ȸ�ϴ� ȭ������ �̵��Ѵ�.
    goSelect({
        url:"/portal/data/service/selectServicePage.do",
        form:"dataset-select-form"/*,
        data:[{
            name:"infId",
            value:data.infId
        }, {
            name:"infSeq",
            value:data.infSeq
        }]*/
    });
}

////////////////////////////////////////////////////////////////////////////////
//��ó�� �Լ�
////////////////////////////////////////////////////////////////////////////////

/**
 *  �Խ��� ���� ��ȸ ��ó���� �����Ѵ�.
 * 
 * @param options {Object} �ɼ�
 * @returns {Object} ������
 */
function beforeSelectVisual(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#visual-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "page":
            case "rows":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.vistnSrvSeq)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
//��ó�� �Լ�
////////////////////////////////////////////////////////////////////////////////
/**
 * �Խ��� ���� ��ȸ ��ó���� �����Ѵ�.
 * 
 * @param data {Object} ������
 */
function afterSelectVisual(data) {
    var form = $("#visual-select-form");

    form.find("[name=vistnSrvSeq]").val(data.vistnSrvSeq);
    
    form.find(".visualNm").append(data.vistnNm);
        
    form.find(".visualCont").text(data.vistnSrvDesc);
    
    form.find(".userNm").text(data.prdNm);
    form.find(".userDttm").text(data.regDttm);
    form.find(".visualType").text(data.vistnTyNm);
    
    // �����׷����� ��� ������ ���ƾ��´�.
    if($('#visual-search-form [name=vistnCd]').val() == 'I') {
    	form.empty();
    	form.html("<div id=\"chart_dataVisualization\"></div>");
    }
    
    // ���� ����
    filter = [
              {name : data.filt1Nm, value : data.filt1Val}
              , {name : data.filt2Nm, value : data.filt2Val}
              , {name : data.filt3Nm, value : data.filt3Val}
              ];

    // html 5 ������ ��Ʈ url ���
    var noHtml5Arr = [
                      	// ---- ��Ʈ ----
                      	"/portal/data/visual/selectListPublsvntHBChart.do"		// ������ ��Ȳ Hierarical Bar Chart
                      	, "/portal/data/visual/selectListPublsvntCPChart.do"		// ������ ��Ȳ Circle packing
                      	, "/portal/data/visual/selectListBudgetTreemap.do"		// ���� ��Ȳ Tree map
                      	, "/portal/data/visual/selectListHedofcLocalMeta.do"		// ��⵵ �κ� ���� ��ŸTree map
                      	, "/portal/data/visual/selectDeathCause.do"					// ��� ���κ� ��� Heat map
                      	, "/portal/data/visual/selectHouseForm.do"					// �����������º� ���� heat map
                      	, "/portal/data/visual/selectListLocalTax.do"					// ���漼 ¡�� ��Ȳ Zoomable Sunburst
                      	, "/portal/data/visual/selectListPopltnTreeMap.do"		// �ñ��� �α���Ȳ ���� ��/�ܱ��� ���� Tree map
                      	// ---- �����׷��� ----
                      	, "/portal/data/visual/selectInfographicTapwaterPrice2.do"		// ����� ���
                      	, "/portal/data/visual/selectInfographicFinance.do"				// ���� �ڸ���
                      	, "/portal/data/visual/selectInfographicSocialWelfareBudget.do"	// ���� ��� ��ȸ�������� ��⵵ �����׷���
                      ];
    
    var ieVerText = "IE 9.0 �̻�";
    var noHtml5Flag = false;
    $.each(noHtml5Arr, function(i, d) {
    	if(d == data.vistnUrl) {
    		noHtml5Flag = true;
    		return;
    	}
    });
    
    // ie 10 ���� ����
    var ie10UpArr = [
//                     "/portal/data/visual/selectDeathCause.do" // ������κ� ���
//                     , "/portal/data/visual/selectHouseForm.do" // �����������º� �Ϲݰ���
                     ];
    var ie10UpFlag = false;
    $.each(ie10UpArr, function(i, d) {
    	if(d == data.vistnUrl) {
    		ie10UpFlag = true;
    		ieVerText = "IE 10.0 �̻�";
    		return;
    	}
    });
    
    
	// html5�� �������� �ʴ� URL �̰� IE ������ �̸� 9���� �̸��� ���
    if((noHtml5Flag && getBrowserType() == "IEold") || (ie10UpFlag && getBrowserType() == "IE9")) {
       	var template = 
   				'<div id="noHtml5">'                 
   				+'	<div class="back2"></div>'                 
   				+'	<div class="backBox2">'
   				+'		<img src="'+ com.wise.help.url("/img/ggportal/desktop/data/no_html5.jpg")+'" alt="HTML5 ���� ����" /><br/>'
   				+'		�� ������ �ð�ȭ ��Ʈ�� �ֽ� ����� HTML5�� ���۵Ǿ�<br/>'
   				+'		<a href="http://windows.microsoft.com/ko-kr/internet-explorer/download-ie" target="_new">'+ieVerText+'</a>,'
   				+'		<a href="http://www.google.com/chrome" target="_new">Chrome</a>,'
   				+'		<a href="http://www.mozilla.org/ko/firefox/" target="_new">Firefox</a>,'
   				+'		<a href="http://www.apple.com/kr/safari/" target="_new">Safari</a> ���� ������������ ��ȸ�˴ϴ�.<br/><br/>'
   				+'	</div>'
   				+'</div>';
       	$("#chart_dataVisualization").html(template);
    } else {
	    // iframe ���� ����ߵǴ� ��Ʈ url ���
	    var iframeUrlArr = [
	                        {path:"/portal/data/visual/selectBudgetMotionChart.do", style : "min-height:530px;"}		// ���� ��Ȳ Motion Chart
	                        , {path:"/portal/data/visual/selectListPopltnMotionChart.do", style : "min-height:530px;"}		// �α� ��Ȳ Motion Chart
	                      ];
	    
	    var iframeFlag = false;
	    var style = "";
	    $.each(iframeUrlArr, function(i, d) {
	    	if(d.path == data.vistnUrl) {
	    		style = d.style;
	    		iframeFlag = true;
	    		return;
	    	}
	    });
	    var url = com.wise.help.url(data.vistnUrl+"?"+filter[0].name+"="+filter[0].value+"&"+filter[1].name+"="+filter[1].value+"&"+filter[2].name+"="+filter[2].value);
	    // iframe ���� ����ߵǴ� ���
	    if(iframeFlag) {
	    	// ���ĸ��� �÷��� ������
//	    	if(getBrowserType() == "Safari") {
//	    		var template = 
//	   				'<div id="noHtml5">'                 
//	   				+'	<div class="back2"></div>'                 
//	   				+'	<div class="backBox2">'
//	   				+'		���ĸ������� Flash �� ��ȸ �Ҽ� �����ϴ�.<br/>'
//	   				+'		<a href="http://windows.microsoft.com/ko-kr/internet-explorer/download-ie" target="_new">IE 9.0 �̻�</a>,'
//	   				+'		<a href="http://www.google.com/chrome" target="_new">Chrome</a>,'
//	   				+'		<a href="http://www.mozilla.org/ko/firefox/" target="_new">Firefox</a>���� ������������ ��ȸ�˴ϴ�.<br/><br/>'
//	   				+'	</div>'
//	   				+'</div>';
//	           	$("#chart_dataVisualization").html(template);
//	    	} else {
		    	var temp = "<iframe src=\""+url+"\" scrolling=\"no\" frameborder=0 style=\"width:980px; "+style +"\"></iframe>";
		    	$("#chart_dataVisualization").html(temp);
//	    	}
	    } else {
		    $("#chart_dataVisualization").load(url);
	    }
	    
	    if(data.infId) {
	    	var dataSetForm = $('#dataset-select-form');
	    	dataSetForm.find("[name=infId]").val(data.infId);
	    	dataSetForm.find("[name=infSeq]").val(data.trnSrvCd);
	    	
	    	var btn = $('#visual-dataset-btn');
	    	btn.show();
	        // �󼼵����ͺ��� ��ư�� Ŭ�� �̺�Ʈ
	    	btn.bind("click", function(event) {
	    		selectDataset();
	            return false;
	        });
	    }
    }
}

function getBrowserType(){
    
    var _ua = navigator.userAgent;
    var rv = -1;
     
    //IE 11,10,9,8
    var trident = _ua.match(/Trident\/(\d.\d)/i);
    if( trident != null )
    {
        if( trident[1] == "7.0" ) return rv = "IE";
        if( trident[1] == "6.0" ) return rv = "IE";
        if( trident[1] == "5.0" ) return rv = "IE9";
        if( trident[1] == "4.0" ) return rv = "IEold";
    }
     
    //IE 7...
    if( navigator.appName == 'Microsoft Internet Explorer' ) return rv = "IEold";
     
    //other
    var agt = _ua.toLowerCase();
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}