<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)meta.jsp 1.0 2015/06/15                                            --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메타 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
    
        <!-- // Sheet dataset 정보 -->
        <script type="text/javascript">
        /*
         * @(#)selectSheet.js 1.0 2015/06/15
         * 
         * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
         */

        /**
         * 공공데이터 시트 서비스를 조회하는 스크립트이다.
         *
         * @author 김은삼
         * @version 1.0 2015/06/15
         */
        $(function() {
        	
            // 컴포넌트를 초기화한다.
            initComp();
            
            // 마스크를 바인딩한다.
            bindMask();
            
            // 이벤트를 바인딩한다.
            bindEvent();
            
            // 옵션을 로드한다.
            loadOptions();
            
            // 데이터를 로드한다.
            loadData();
            

            
        });

        ////////////////////////////////////////////////////////////////////////////////
        // 글로벌 변수
        ////////////////////////////////////////////////////////////////////////////////
        /**
         * 템플릿
         */
        var templates = {
            data:
                "<tr>"                                                       +
                    "<td align=\"center\"><input type=\"checkbox\" /></td>"  +
                    "<td align=\"center\"><span class=\"code\"></span></td>" +
                    "<td align=\"left\"><span class=\"name\"></span></td>"   +
                "</tr>",
            none:
                "<tr>"                                                                               +
                    "<td colspan=\"3\"><span class=\"noData\">검색된 데이터가 없습니다.</span></td>" +
                "</tr>"
        };

        /**
         * 추천 템플릿
         */
        var templates2 = {
            data:
                "<li><a href=\"#none\">"                                                       +
                    "<span class=\"img\"><img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\"></span>"                                                  +
                    "<span class=\"txt\"></span>"                                               +
                "</a></li>",  
               none:
                   "<li><a href=\"#none\">"                                                       +
                   "<img src=\"\" alt=\"\">"                                                  +
                   "<span class=\"txt\">데이터가 없습니다.</span>" +
               "</a></li>"  
        };


        ////////////////////////////////////////////////////////////////////////////////
        // 초기화 함수
        ////////////////////////////////////////////////////////////////////////////////

        function initComp() {
        	var meta = $("#dataset-search-form").find("input[name=infId]").val();
        	//alert(meta);
        	var sheet = $("#sheet-search-form").find("input[name=infId]").val();
        	//alert(sheet);
        	if (meta != sheet ) {
        		 $("#sheet-search-form").find("input[name=infId]").val(meta) ;
        	}
        	alert("시트쪽 id : "+$("#sheet-search-form").find("input[name=infId]").val())
        	
            // 윈도우 단위에서 키가 눌리면
            $(window).keyup(function (e) {
                // 발생한 이벤트에서 키 코드 추출, BackSpace 키의 코드는 8
            	if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
                if (e.keyCode == 8) {        	
                	searchDataset();	       	
                }
            	}
            });
            
        }






        /**
         * 컴포넌트를 초기화한다.
         */
        //function initComp() {
//            // Nothing to do.
        //}

        /**
         * 마스크를 바인딩한다.
         */
        function bindMask() {
            // Nothing to do.
        }

        /**
         * 이벤트를 바인딩한다.
         */
        function bindEvent() {
        	
            // 공공데이터 시트 서비스 필터검색 버튼에 클릭 이벤트를 바이딩한다.
            $("#sheet-search-button").bind("click", function(event) {
                // 공공데이터 시트 서비스 데이터를 검색한다.
                searchSheetData();
                return false;
            });
            
            // 공공데이터 시트 서비스 필터검색 버튼에 키다운 이벤트를 바이딩한다.
            $("#sheet-search-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 시트 서비스 데이터를 검색한다.
                    searchSheetData();
                    return false;
                }
            });
            
            // // 공공데이터 시트 서비스 팝업 코드 검색어 필드에 키다운 이벤트를 바이딩한다.
            // $("#sheet-popup-search-form").find("[name=searchWord]").bind("keydown", function(event) {
            //     if (event.which == 13) {
            //         // 공공데이터 시트 서비스 팝업 코드를 검색한다.
            //         searchSheetPopupCode();
            //         return false;
            //     }
            // });
            
            // // 공공데이터 시트 서비스 팝업 코드 조회 버튼에 클릭 이벤트를 바이딩한다.
            // $("#sheet-popup-search-button").bind("click", function(event) {
            //     // 공공데이터 시트 서비스 팝업 코드를 검색한다.
            //     searchSheetPopupCode();
            //     return false;
            // });
            
            // // 공공데이터 시트 서비스 팝업 코드 조회 버튼에 키다운 이벤트를 바이딩한다.
            // $("#sheet-popup-search-button").bind("keydown", function(event) {
            //     if (event.which == 13) {
            //         // 공공데이터 시트 서비스 팝업 코드를 검색한다.
            //         searchSheetPopupCode();
            //         return false;
            //     }
            // });
            
            // // 공공데이터 시트 서비스 팝업 코드 닫기 버튼에 클릭 이벤트를 바이딩한다.
            // $("#sheet-popup-close-button").bind("click", function(event) {
            //     // 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
            //     hideSheetPopupCode();
            //     return false;
            // });
            
            // // 공공데이터 시트 서비스 팝업 코드 닫기 버튼에 키다운 이벤트를 바이딩한다.
            // $("#sheet-popup-close-button").bind("keydown", function(event) {
            //     if (event.which == 13) {
            //         // 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
            //         hideSheetPopupCode();
            //         return false;
            //     }
            // });
            
            // 공공데이터 시트 서비스 XML 버튼에 클릭 이벤트를 바인딩한다.
            $("#sheet-xml-button").bind("click", function(event) {
                // 공공데이터 시트 서비스 데이터를 다운로드한다.
                downloadSheetData("X");
                return false;
            });
            
            // 공공데이터 시트 서비스 XML 버튼에 키다운 이벤트를 바인딩한다.
            $("#sheet-xml-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 시트 서비스 데이터를 다운로드한다.
                	
                    downloadSheetData("X");
                    return false;
                }
            });
            
            // 공공데이터 시트 서비스 JSON 버튼에 클릭 이벤트를 바인딩한다.
            $("#sheet-json-button").bind("click", function(event) {
                // 공공데이터 시트 서비스 데이터를 다운로드한다.
                downloadSheetData("J");
                return false;
            });
            
            // 공공데이터 시트 서비스 JSON 버튼에 키다운 이벤트를 바인딩한다.
            $("#sheet-json-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 시트 서비스 데이터를 다운로드한다.
                    downloadSheetData("J");
                    return false;
                }
            });
            
            // 공공데이터 시트 서비스 EXCEL 버튼에 클릭 이벤트를 바인딩한다.
            $("#sheet-excel-button").bind("click", function(event) {
                // 공공데이터 시트 서비스 데이터를 다운로드한다.
                downloadSheetData("E");
                return false;
            });
            
            // 공공데이터 시트 서비스 EXCEL 버튼에 키다운 이벤트를 바인딩한다.
            $("#sheet-excel-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 시트 서비스 데이터를 다운로드한다.
                    downloadSheetData("E");
                    return false;
                }
            });
            
            // 공공데이터 시트 서비스 CSV 버튼에 클릭 이벤트를 바인딩한다.
            $("#sheet-csv-button").bind("click", function(event) {
                // 공공데이터 시트 서비스 데이터를 다운로드한다.
                downloadSheetData("C");
                return false;
            });
            
            // 공공데이터 시트 서비스 CSV 버튼에 키다운 이벤트를 바인딩한다.
            $("#sheet-csv-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 시트 서비스 데이터를 다운로드한다.
                    downloadSheetData("C");
                    return false;
                }
            });
            
            // 공공데이터 시트 서비스 TXT 버튼에 클릭 이벤트를 바인딩한다.
            $("#sheet-txt-button").bind("click", function(event) {
                // 공공데이터 시트 서비스 데이터를 다운로드한다.
                downloadSheetData("T");
                return false;
            });
            
            // 공공데이터 시트 서비스 TXT 버튼에 키다운 이벤트를 바인딩한다.
            $("#sheet-txt-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 시트 서비스 데이터를 다운로드한다.
                    downloadSheetData("T");
                    return false;
                }
            });
            
            // 공공데이터 데이터셋 목록 버튼에 클릭 이벤트를 바인딩한다.
            $("#dataset-search-button").bind("click", function(event) {
                // 공공데이터 데이터셋 전체목록을 검색한다.
                searchDataset();
                return false;
            });
            
            // 공공데이터 데이터셋 목록 버튼에 키다운 이벤트를 바인딩한다.
            $("#dataset-search-button").bind("keydown", function(event) {
                if (event.which == 13) {
                    // 공공데이터 데이터셋 전체목록을 검색한다.
                    searchDataset();
                    return false;
                }
            });
            
            
        }

        /**
         * 옵션을 로드한다.
         */
        function loadOptions() {
            // Nothing do do.
        }

        /**
         * 데이터를 로드한다.
         */
        function loadData() {
            // 공공데이터 시트 서비스 메타정보를 조회한다.
            selectSheetMeta();
        }

        ////////////////////////////////////////////////////////////////////////////////
        // 서비스 함수
        ////////////////////////////////////////////////////////////////////////////////
        /**
         * 공공데이터 시트 서비스 메타정보를 조회한다.
         */
        function selectSheetMeta() {
            // 데이터를 조회한다.
            doSelect({
                url:"/portal/data/sheet/selectSheetMeta.do",
                before:beforeSelectSheetMeta,
                after:afterSelectSheetMeta
            });
        }

        /**
         * 공공데이터 시트 서비스 데이터를 검색한다.
         */
        function searchSheetData() {
            // 공공데이터 시트 서비스 검색 필터를 검증한다.
            if (!checkSearchFilters("sheet-search-table")) {
                return;
            }
            
            // 시트 데이터를 로드한다.
            loadSheetData({
                SheetId:"SheetObject",
                PageUrl:"/portal/data/sheet/searchSheetData.do"
            }, {
                FormParam:"sheet-search-form"
            }, {
                // Nothing to do.
            });
        }

        /**
         * 공공데이터 시트 서비스 데이터를 다운로드한다.
         * 
         * @param type {String} 유형
         */
        function downloadSheetData(type) {

            // 공공데이터 시트 서비스 검색 필터를 검증한다.
            if (!checkSearchFilters("sheet-search-table")) {
                return;
            }
            
        if (window["SheetObject"].GetTotalRows() >= 10000) {
            	
            	if ( !confirm("대용량 데이터는(10000건 이상) 전체 데이터를 CSV파일로 다운로드 받으실 수 있습니다.다운로드 하시겠습니까?")) {
        			return;
        		}
            	
            	goSelect({
                    url:"/portal/data/sheet/downloadBigSheetData.do",
                    form:"sheet-search-form",
                    data:[
//                        name:"infId",
//                        value:data.infId
//                    }
//                    , {
//                        name:"infSeq",
//                        value:data.infSeq
//                    }
                    ]
                });
                
            	//var downloadUrl = "/portal/data/sheet/downloadBigSheetData.do?"+form.serialize();
                //$.fileDownload(downloadUrl);
            	
                return;
            }
            
            if (type == "E" && window["SheetObject"].GetTotalRows() > 10000) {
                alert("데이터 양이 많은 경우에는 엑셀저장이 제한됩니다. CSV로 받아 주시기 바랍니다.");
                return;
            }
            else {
//                alert("클릭은 한번만 해 주세요. 데이터 양에 따라 파일변환에 시간이 소요될 수 있습니다. 변환이 완료되는 동안 잠시 기다려 주시기 바랍니다.");
            }
            
            // 데이터를 다운로드하는 화면으로 이동한다.
            /*goDownload({
                url:"/portal/data/sheet/downloadSheetData.do",
                form:"sheet-search-form",
                target:"global-process-iframe",
                data:[{
                    name:"downloadType",
                    value:type
                }]
            });*/
            
            var form = $('#sheet-search-form');
            form.find("[name=downloadType]").val(type);
            
            var downloadUrl = "/portal/data/sheet/downloadSheetData.do?"+form.serialize();
            $.fileDownload(downloadUrl);
            return false;
        }

        /**
         * 공공데이터 데이터셋 전체목록을 검색한다.
         */
        function searchDataset() {
            // 데이터를 검색하는 화면으로 이동한다.
            goSearch({
                url:"/portal/data/dataset/searchDatasetPage.do",
                form:"dataset-search-form"
            });
        }

        /**
         * 공공데이터 시트 서비스 검색 필터를 추가한다.
         * 
         * @param filters {Array} 필터
         */
        function addSheetSearchFilters(filters) {
            if (filters.length > 0) {
                $("#sheet-search-sect").removeClass("hide");
            }
            
            var form = $('#sheet-search-form');
            var sigunFlag = form.find("[name=sigunFlag]").val();
            
            // // 검색 필터를 추가한다.
            // addSearchFilters("sheet-search-table", filters, {
            //     idPrefix:"sheet-filter-",
            //     idKey:"srcColId",
            //     showPopupCode:showSheetPopupCode
            // });
            // 검색 필터를 추가한다.
            addSearchFilters("sheet-search-table", filters, {
                idPrefix:"sheet-filter-",
                idKey:"srcColId",
                onKeyDown:searchSheetData
            }, sigunFlag);
        }

        // /**
        //  * 공공데이터 시트 서비스 팝업 코드 검색 화면을 보인다.
        //  * 
        //  * @param title {String} 타이틀
        //  * @param table {String} 테이블
        //  */
        // function showSheetPopupCode(title, table) {
//             var form = $("#sheet-popup-search-form");
//             
//             form.find("[name=page]").val("1");
//             form.find("[name=tblId]").val(table);
//             form.find("[name=searchWord]").val("");
//             
//             // 타이틀을 변경한다.
//             $("#sheet-popup-header-sect").text(title);
//             
//             // 데이터를 삭제한다.
//             afterSearchSheetPopupCode([
//                 // Nothing to do.
//             ]);
//             
//             // 레이어를 보인다.
//             $("#sheet-popup-sect").show();
//             
//             // 공공데이터 시트 서비스 팝업 코드를 검색한다.
//             searchSheetPopupCode();
        // }

        // /**
        //  * 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
        //  */
        // function hideSheetPopupCode() {
//             var form = $("#sheet-popup-search-form");
//             
//             form.find("[name=page]").val("1");
//             form.find("[name=tblId]").val("");
//             form.find("[name=searchWord]").val("");
//             
//             // 타이틀을 삭제한다.
//             $("#sheet-popup-header-sect").text("");
//             
//             // 데이터를 삭제한다.
//             afterSearchSheetPopupCode([
//                 // Nothing to do.
//             ]);
//             
//             // 레이어를 숨긴다.
//             $("#sheet-popup-sect").hide();
        // }

        // /**
        //  * 공공데이터 시트 서비스 팝업 코드를 검색한다.
        //  */
        // function searchSheetPopupCode() {
//             // 데이터를 검색한다.
//             doSearch({
//                 url:"/portal/common/code/searchPopupCode.do",
//                 before:beforeSearchSheetPopupCode,
//                 after:afterSearchSheetPopupCode,
//                 pager:"sheet-popup-pager-sect",
//                 counter:{
//                     count:"sheet-popup-count-sect"
//                 }
//             });
        // }

        // /**
        //  * 공공데이터 시트 서비스 팝업 코드를 설정한다.
        //  * 
        //  * @param code {String} 코드
        //  * @param name {String} 코드
        //  */
        // function setSheetPopupCode(code, name) {
//             $("#sheet-search-table").find(".header").each(function(index, element) {
//                 if ($(this).text() == $("#sheet-popup-header-sect").text()) {
//                     var row = $(this).parent("th").parent("tr");
//                     
//                     row.find(".hidden").val(code);
//                     row.find(":text").val(name);
//                     
//                     return false;
//                 }
//             });
//             
//             // 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
//             hideSheetPopupCode();
        // }

        ////////////////////////////////////////////////////////////////////////////////
        // 전처리 함수
        ////////////////////////////////////////////////////////////////////////////////
        /**
         * 공공데이터 시트 서비스 메타정보 조회 전처리를 실행한다.
         * 
         * @param options {Object} 옵션
         * @returns {Object} 데이터
         */
        function beforeSelectSheetMeta(options) {
            var data = {
                // Nothing do do.
            };
            
            var form = $("#sheet-search-form");
            
            $.each(form.serializeArray(), function(index, element) {
                switch (element.name) {
                    case "infId":
                    case "infSeq":
                        data[element.name] = element.value;
                        break;
                }
            });
            
            if (com.wise.util.isBlank(data.infId)) {
                return null;
            }
            if (com.wise.util.isBlank(data.infSeq)) {
                return null;
            }
            
            return data;
        }

        // /**
        //  * 공공데이터 시트 서비스 팝업 코드 검색 전처리를 실행한다.
        //  * 
        //  * @param options {Object} 옵션
        //  * @returns {Object} 데이터
        //  */
        // function beforeSearchSheetPopupCode(options) {
//             var data = {
//                 // Nothing do do.
//             };
//             
//             var form = $("#sheet-popup-search-form");
//             
//             if (com.wise.util.isBlank(options.page)) {
//                 form.find("[name=page]").val("1");
//             }
//             else {
//                 form.find("[name=page]").val(options.page);
//             }
//             
//             $.each(form.serializeArray(), function(index, element) {
//                 data[element.name] = element.value;
//             });
//             
//             return data;
        // }

        ////////////////////////////////////////////////////////////////////////////////
        // 후처리 함수
        ////////////////////////////////////////////////////////////////////////////////
        /**
         * 공공데이터 시트 서비스 메타정보 조회 후처리를 실행한다.
         * 
         * @param data {Object} 데이터
         */
        function afterSelectSheetMeta(data) {
            // 시트 그리드를 생성한다.
            initSheetGrid({
                ElementId:"sheet-object-sect",
                SheetId:"SheetObject",
                Height:"100%"
            }, {
                Page:$("#sheet-search-form [name=rows]").val()
            }, {
                HeaderCheck:0
            }, data.columns, {
                // Nothing do do.
            });
            
            var sheet = window["SheetObject"];
            
            var width = 0;
            
            //var max = data.columns.length;;
            
            for (var i = 0; i < data.columns.length; i++) {
                width += sheet.GetColWidth(i);
            }
            
            if (sheet.GetSheetWidth() > width) {
                sheet.FitColWidth();
            }
            
            // 공공데이터 시트 서비스 검색 필터를 추가한다.
            addSheetSearchFilters(data.filters);    
            
            // 공공데이터 시트 서비스 데이터를 검색한다.
            searchSheetData();
            
            //추천 데이터셋을 검색한다.
            //selectRecommandDataSet();
        }


        function selectRecommandDataSet() {
        	doSelect({
                url:"/portal/data/sheet/selectRecommandDataSet.do",
                before:beforeSelectRecommandDataSet,
                after:afterSelectRecommandDataSet
            });
        }

        function beforeSelectRecommandDataSet(options) {
        	
            var data = {
                // Nothing do do.
            };
            
            var form = $("#sheet-search-form");
            
            $.each(form.serializeArray(), function(index, element) {
                switch (element.name) {
                    case "infId":
                    case "infSeq":
                        data[element.name] = element.value;
                        break;
                }
            });
            
            if (com.wise.util.isBlank(data.infId)) {
                return null;
            }
            if (com.wise.util.isBlank(data.infSeq)) {
                return null;
            }
            
            return data;
        }

        /**
         * 공공데이터 시트 서비스 메타정보 조회 후처리를 실행한다.
         * 
         * @param data {Object} 데이터
         */
        function afterSelectRecommandDataSet(data) {
        	  var table = $(".bxslider");
        	  var infsq = 1;
        	  
        	//데이터가 없다면
        	  if (data.length == 0) {
        		 $(".recommendDataset").remove();
        	  }
        	  
        	  for (var i = 0; i < data.length; i++) {
        	      var row = $(templates2.data);
        	     
        	      table.append(row);
          
        	     
        	      if (data[i].metaImagFileNm || data[i].CATESAVEFILENM) {
        	            var url = com.wise.help.url("/portal/data/dataset/selectThumbnail.do");
        	            //alert("asd");
        	            // url += "?infId=" + data[i].infId;
        	            url += "?seq="            + data[i].seq;
        	            url += "&metaImagFileNm=" + (data[i].metaImagFileNm ? data[i].metaImagFileNm : "");
        	            url += "&cateSaveFileNm=" + (data[i].CATESAVEFILENM ? data[i].CATESAVEFILENM : "");

        	            row.find(".metaImagFileNm").attr("src", url);
        	            row.find(".metaImagFileNm").attr("alt", data[i].INFNM);
        	        }
        	      
        	      row.find("span").eq(1).text(data[i].INFNM);
        	      
        	      row.each(function(index, element) {
        	            // 서비스 링크에 클릭 이벤트를 바인딩한다.   	  
        	            $(this).bind("click", {
        	                infId:data[i].INFID,
        	                infSeq:infsq
        	                //currentPage : $(this).val()
        	               
        	            }, function(event) {
        	                // 공공데이터 서비스를 조회한다.
        	            	//currentPage = $(this).val();
        	            	//document.location.hash = "#" + currentPage;
        	            	recoService(event.data);
        	                return false;
        	            });
        	            
        	            // 서비스 링크에 키다운 이벤트를 바인딩한다.
        	            $(this).bind("keydown", {
        	                infId:data[i].INFID,
        	                infSeq:infsq
        	            }, function(event) {
        	                if (event.which == 13) {
        	                    // 공공데이터 서비스를 조회한다.
        	                	//currentPage = $(this).val();
        	                	//document.location.hash = "#" + currentPage;
        	                	recoService(event.data);
        	                    return false;
        	                }
        	            });
        	        });
        	  	      
        	  }
        		var ww = ($('.recommendDataset').width()-75) / 4;
        		setTimeout(dataset, 700, ww);
        		
        		function dataset(ww){
        			dataSet = $('.dataSetSlider').bxSlider({
        				mode : 'horizontal',
        				speed : 500,
        				moveSlider : 1,
        				autoHover : true,
        				controls : false,
        				slideMargin : 0,
        				startSlide : 0,
        				slideWidth: ww,
        				minSlides: 1,
        				maxSlides: 4,
        				moveSlides: 1
        			});

        		  $( '#dataset_prev' ).on( 'click', function () {
        		   dataSet.goToPrevSlide();  //이전 슬라이드 배너로 이동
        		   return false;              //<a>에 링크 차단
        		  } );

        		  $( '#dataset_next' ).on( 'click', function () {
        		   dataSet.goToNextSlide();  //다음 슬라이드 배너로 이동
        		   return false;
        		  } );
        		}
        }

        function recoService(data) {
            // 데이터를 조회하는 화면으로 이동한다.
            goSelect({
                url:"/portal/data/service/selectServicePage.do",
                form:"sheet-search-form",
                data:[{
                    name:"infId",
                    value:data.infId
                }
                , {
                    name:"infSeq",
                    value:data.infSeq
                }
                ]
            });
        }

        // /**
        //  * 공공데이터 시트 서비스 팝업 코드 검색 후처리를 실행한다.
        //  * 
        //  * @param data {Array} 데이터
        //  */
        // function afterSearchSheetPopupCode(data) {
//             var table = $("#sheet-popup-data-table");
//             
//             table.find("tr").each(function(index, element) {
//                 if (index > 0) {
//                     $(this).remove();
//                 }
//             });
//             
//             for (var i = 0; i < data.length; i++) {
//                 var row = $(templates.data);
//                 
//                 row.find(".code").text(data[i].code);
//                 row.find(".name").text(data[i].name);
//                 
//                 row.find(":checkbox").bind("click", {
//                     code:data[i].code,
//                     name:data[i].name
//                 }, function(event) {
//                     // 공공데이터 시트 서비스 팝업 코드를 설정한다.
//                     setSheetPopupCode(event.data.code, event.data.name);
//                 });
//                 
//                 table.append(row);
//             }
//             
//             if (data.length == 0) {
//                 var row = $(templates.none);
//                 
//                 table.append(row);
//             }
        // }

        ////////////////////////////////////////////////////////////////////////////////
        // 이벤트 함수
        ////////////////////////////////////////////////////////////////////////////////
        /**
         * 시트 조회 완료 이벤트를 처리한다.
         * 
         * @param code {Number} 코드
         * @param message {String} 메시지
         * @param statusCode {Number} 상태 코드
         * @param statusMessage {String} 상태 메시지
         */
        function SheetObject_OnSearchEnd(code, message, statusCode, statusMessage) {
            if (code >= 0) {
                if (message) {
                    alert(message);
                }
            }
            else {
                if (message) {
                    alert(message);
                }
                else {
                    handleSheetError(statusCode, statusMessage);
                }
            }
        }

        /////////////////아이비시트 추가

        function SheetObject_OnTab(Row, Col, Orow, Ocol, isShift, isLast) {
            if(isLast){
            	SheetObject.SetBlur(); // focus를 이동시킬 준비를 합니다.
            	$("#dataset-search-button").focus(); //다른 객체에 focus를 이동합니다.
            }
        }

        </script>