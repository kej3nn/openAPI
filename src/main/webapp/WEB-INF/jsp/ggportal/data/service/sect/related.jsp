<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)related.jsp 1.0 2015/06/15                                         --%>
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
<%-- 관련 서비스 섹션 화면이다.                                             --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
            <div id="related-service-sect" class="hide">
            <h4 class="ty_A">관련서비스</h4>
            <div class="area_btn_D">
                <a href="#layerPopup_dataSet_service" id="btn_allView_dataSet_service" class="btn_D btn_view_layerPopup_dataSet_service">전체보기</a>
            </div>
            <!-- layerPopup 관련서비스 -->
            <div class="layout_layerPopup_A layout_layerPopup_A_dataSet_service">
                <div class="transparent"></div>
                <div id="layerPopup_dataSet_service" class="layerPopup_A">
                    <h4 class="pop h4_pop_dataSet_service">관련서비스</h4>
                    <!-- 내용 -->
                    <div class="cont scroll">
                        <div id="window-related-service-sect" class="dataSet_service_pop module_dataSet_service"></div>
                    </div>
                    <!-- //내용 -->
                    <a href="#btn_allView_dataSet_service" class="btn_close"><span>레이어 팝업 닫기</span></a>
                </div>
            </div>
            <!-- layerPopup 관련서비스 -->   
            <!-- 관련서비스 PC, tablet -->
            <div class="area_dataSet_service mq_tablet">
                <div class="dataSet_service"><div class="service module_dataSet_service">
                <ul id="tablet-related-service-list" class="list_dataSet_service"></ul>
            </div></div></div>
            <!-- // 관련서비스 PC, tablet -->
            <!-- 관련서비스 mobile -->
            <div class="area_dataSet_service mq_mobile"><div class="dataSet_service"><div class="service module_dataSet_service">
                <ul id="mobile-related-service-list" class="list_dataSet_service"></ul>
            </div></div></div>
            </div>
            <!-- // 관련서비스 mobile -->
            <script type="text/javascript">
                $(function() {
                    // 데이터를 검색한다.
                    doSearch({
                        url:"/portal/data/dataset/searchRelated.do",
                        before:beforeSearchRelated,
                        after:afterSearchRelated
                    });
                });
                
                /**
                 * 공공데이터 데이터셋 관련목록 검색 전처리를 실행한다.
                 * 
                 * @param options {Object} 옵션
                 */
                function beforeSearchRelated(options) {
                    var data = {
                        infId:$("#dataset-search-form [name=infId]").val()
                    };
                    
                    if (com.wise.util.isBlank(data.infId)) {
                        return null;
                    }
                    
                    return data;
                }
                
                /**
                 * 공공데이터 데이터셋 관련목록 검색 후처리를 실행한다.
                 * 
                 * @param data {Object} 데이터
                 */
                function afterSearchRelated(data) {
                    if (data.length > 0) {
                        $("#related-service-sect").removeClass("hide");
                        
                        // 공공데이터 데이터셋 관련목록을 윈도우에 설정한다.
                        setRelatedOnWindow(data);
                    
                        // 공공데이터 데이터셋 관련목록을 태블릿에 설정한다.
                        setRelatedOnTablet(data);
                        
                        // 공공데이터 데이터셋 관련목록을 모바일에 설정한다.
                        setRelatedOnMobile(data);
                        
                        // bxslider.js 관련사이트 slide 스크립트 참조
                        mbo = $(".list_dataSet_service").bxSlider({
                            auto:false, 
                            pause:2000, 
                            speed:500,
                            pager:true,
                            pagerType:"short",
                            controls:true
                        });
                    }
                }
                
                /**
                 * 공공데이터 데이터셋 관련목록을 윈도우에 설정한다.
                 * 
                 * @param data {Object} 데이터
                 */
                function setRelatedOnWindow(data) {
                    var sect = $("#window-related-service-sect");
    
                    sect.find("a").each(function(index, element) {
                        $(this).remove();
                    });
                    
                    var template = "";
                    
                    template += "<a href=\"#\" class=\"link icon_sort\">";
                    template += "    <strong class=\"tit topCateNm infNm\"></strong>";
                    template += "    <span class=\"sort cateNm\"></span> &#47;";
                    template += "    <span class=\"date regDttm\"></span>";
                    template += "    <span class=\"area_txt_A srvCd\">";
                    template += "    </span>";
                    template += "</a>";
                    
                    for (var i = 0; i < data.length; i++) {
                        var link = $(template);
                        
                        if (data[i].topCateId) {
                            link.addClass(getCategoryIconClass(data[i].topCateId));
                        }
                        
                        var name = "";
                        
                        if (data[i].topCateNm) {
                            name += "[" + data[i].topCateNm + "]";
                        }
                        if (data[i].infNm) {
                            if (name) {
                                name += " ";
                            }
                            
                            name += data[i].infNm;
                        }
                        if (name) {
                            link.find(".topCateNm.infNm").text(name);
                        }
                        if (data[i].cateNm) {
                            link.find(".cateNm").text(data[i].cateNm);
                        }
                        if (data[i].regDttm) {
                            link.find(".regDttm").text(data[i].regDttm);
                        }
                        if (data[i].scolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_1\">SHEET</span>");
                        }
                        if (data[i].ccolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_2\">CHART</span>");
                        }
                        if (data[i].mcolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_3\">MAP</span>");
                        }
                        if (data[i].fileInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_4\">FILE</span>");
                        }
                        if (data[i].acolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_5\">API</span>");
                        }
                        if (data[i].linkInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_6\">LINK</span>");
                        }
                        
                        // 공공데이터 데이터셋 관련목록 배너에 클릭 이벤트를 바인딩한다.
                        link.bind("click", {
                            infId:data[i].infId,
                            infSeq:data[i].infSeq
                        }, function(event) {
                            // 공공데이터 서비스를 조회한다.
                            selectService(event.data);
                            return false;
                        });
                        
                        // 공공데이터 데이터셋 관련목록 배너에 키다운 이벤트를 바인딩한다.
                        link.bind("keydown", {
                            infId:data[i].infId,
                            infSeq:data[i].infSeq
                        }, function(event) {
                            if (event.which == 13) {
                                // 공공데이터 서비스를 조회한다.
                                selectService(event.data);
                                return false;
                            }
                        });
                        
                        sect.append(link);
                    }
                }
                
                /**
                 * 공공데이터 데이터셋 관련목록을 태블릿에 설정한다.
                 * 
                 * @param data {Object} 데이터
                 */
                function setRelatedOnTablet(data) {
                    var list = $("#tablet-related-service-list");
    
                    list.find("li").each(function(index, element) {
                        $(this).remove();
                    });
                    
                    var template = "";
                    
                    template += "<a href=\"#\" class=\"link icon_sort\">";
                    template += "    <strong class=\"tit topCateNm infNm\"></strong>";
                    template += "    <span class=\"sort cateNm\"></span> &#47;";
                    template += "    <span class=\"date regDttm\"></span>";
                    template += "    <span class=\"area_txt_A srvCd\">";
                    template += "    </span>";
                    template += "</a>";
                    
                    var item = null;
                    
                    for (var i = 0; i < data.length; i++) {
                        if (item == null || item.find("a").length == 3) {
                            item = $("<li></li>");
                        }
                        
                        var link = $(template);
                        
                        if (data[i].topCateId) {
                            link.addClass(getCategoryIconClass(data[i].topCateId));
                        }
                        
                        var name = "";
                        
                        if (data[i].topCateNm) {
                            name += "[" + data[i].topCateNm + "]";
                        }
                        if (data[i].infNm) {
                            if (name) {
                                name += " ";
                            }
                            
                            name += data[i].infNm;
                        }
                        if (name) {
                            link.find(".topCateNm.infNm").text(name);
                        }
                        if (data[i].cateNm) {
                            link.find(".cateNm").text(data[i].cateNm);
                        }
                        if (data[i].regDttm) {
                            link.find(".regDttm").text(data[i].regDttm);
                        }
                        if (data[i].scolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_1\">SHEET</span>");
                        }
                        if (data[i].ccolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_2\">CHART</span>");
                        }
                        if (data[i].mcolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_3\">MAP</span>");
                        }
                        if (data[i].fileInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_4\">FILE</span>");
                        }
                        if (data[i].acolInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_5\">API</span>");
                        }
                        if (data[i].linkInfSeq) {
                            if (link.find(".txt_A").length > 0) {
                                link.find(".area_txt_A").append(" ");
                            }
                            link.find(".srvCd").append("<span class=\"txt_A txt_A_6\">LINK</span>");
                        }
                        
                        // 공공데이터 데이터셋 관련목록 배너에 클릭 이벤트를 바인딩한다.
                        link.bind("click", {
                            infId:data[i].infId,
                            infSeq:data[i].infSeq
                        }, function(event) {
                            // 공공데이터 서비스를 조회한다.
                            selectService(event.data);
                            return false;
                        });
                        
                        // 공공데이터 데이터셋 관련목록 배너에 키다운 이벤트를 바인딩한다.
                        link.bind("keydown", {
                            infId:data[i].infId,
                            infSeq:data[i].infSeq
                        }, function(event) {
                            if (event.which == 13) {
                                // 공공데이터 서비스를 조회한다.
                                selectService(event.data);
                                return false;
                            }
                        });
                        
                        item.append(link);
                        
                        if (item.find("a").length == 3 || i == data.length - 1) {
                            list.append(item);
                        }
                    }
                }
                
                /**
                 * 공공데이터 데이터셋 관련목록을 모바일에 설정한다.
                 * 
                 * @param data {Object} 데이터
                 */
                function setRelatedOnMobile(data) {
                    var list = $("#mobile-related-service-list");
    
                    list.find("li").each(function(index, element) {
                        $(this).remove();
                    });
                    
                    var template = "";
                    
                    template += "<li>";
                    template += "    <a href=\"#\" class=\"link icon_sort topCateId\">";
                    template += "        <strong class=\"tit topCateNm infNm\"></strong>";
                    template += "        <span class=\"sort cateNm\"></span> &#47;";
                    template += "        <span class=\"date regDttm\"></span>";
                    template += "        <span class=\"area_txt_A srvCd\">";
                    template += "        </span>";
                    template += "    </a>";
                    template += "</li>";
                    
                    for (var i = 0; i < data.length; i++) {
                        var item = $(template);
                        
                        if (data[i].topCateId) {
                            item.find(".topCateId").addClass(getCategoryIconClass(data[i].topCateId));
                        }
                        
                        var name = "";
                        
                        if (data[i].topCateNm) {
                            name += "[" + data[i].topCateNm + "]";
                        }
                        if (data[i].infNm) {
                            if (name) {
                                name += " ";
                            }
                            
                            name += data[i].infNm;
                        }
                        if (name) {
                            item.find(".topCateNm.infNm").text(name);
                        }
                        if (data[i].cateNm) {
                            item.find(".cateNm").text(data[i].cateNm);
                        }
                        if (data[i].regDttm) {
                            item.find(".regDttm").text(data[i].regDttm);
                        }
                        if (data[i].scolInfSeq) {
                            if (item.find(".txt_A").length > 0) {
                                item.find(".area_txt_A").append(" ");
                            }
                            item.find(".srvCd").append("<span class=\"txt_A txt_A_1\">SHEET</span>");
                        }
                        if (data[i].ccolInfSeq) {
                            if (item.find(".txt_A").length > 0) {
                                item.find(".area_txt_A").append(" ");
                            }
                            item.find(".srvCd").append("<span class=\"txt_A txt_A_2\">CHART</span>");
                        }
                        if (data[i].mcolInfSeq) {
                            if (item.find(".txt_A").length > 0) {
                                item.find(".area_txt_A").append(" ");
                            }
                            item.find(".srvCd").append("<span class=\"txt_A txt_A_3\">MAP</span>");
                        }
                        if (data[i].fileInfSeq) {
                            if (item.find(".txt_A").length > 0) {
                                item.find(".area_txt_A").append(" ");
                            }
                            item.find(".srvCd").append("<span class=\"txt_A txt_A_4\">FILE</span>");
                        }
                        if (data[i].acolInfSeq) {
                            if (item.find(".txt_A").length > 0) {
                                item.find(".area_txt_A").append(" ");
                            }
                            item.find(".srvCd").append("<span class=\"txt_A txt_A_5\">API</span>");
                        }
                        if (data[i].linkInfSeq) {
                            if (item.find(".txt_A").length > 0) {
                                item.find(".area_txt_A").append(" ");
                            }
                            item.find(".srvCd").append("<span class=\"txt_A txt_A_6\">LINK</span>");
                        }
                        
                        // 공공데이터 데이터셋 관련목록 배너에 클릭 이벤트를 바인딩한다.
                        item.bind("click", {
                            infId:data[i].infId,
                            infSeq:data[i].infSeq
                        }, function(event) {
                            // 공공데이터 서비스를 조회한다.
                            selectService(event.data);
                            return false;
                        });
                        
                        // 공공데이터 데이터셋 관련목록 배너에 키다운 이벤트를 바인딩한다.
                        item.bind("keydown", {
                            infId:data[i].infId,
                            infSeq:data[i].infSeq
                        }, function(event) {
                            if (event.which == 13) {
                                // 공공데이터 서비스를 조회한다.
                                selectService(event.data);
                                return false;
                            }
                        });
                        
                        list.append(item);
                    }
                }
                
                /**
                 * 공공데이터 데이터셋 카테고리 아이콘 클래스를 반환한다.
                 * 
                 * @param code {String} 코드
                 * @returns {String} 클래스
                 */
                function getCategoryIconClass(code) {
                    var clazz = "";
                    
                    switch (code) {
                        case "GG01":
                            clazz = "icon_sort_1";
                            break;
                        case "GG05":
                            clazz = "icon_sort_2";
                            break;
                        case "GG09":
                            clazz = "icon_sort_3";
                            break;
                        case "GG13":
                            clazz = "icon_sort_4";
                            break;
                        case "GG16":
                            clazz = "icon_sort_5";
                            break;
                        case "GG20":
                            clazz = "icon_sort_6";
                            break;
                        case "GG23":
                            clazz = "icon_sort_7";
                            break;
                        case "GG26":
                            clazz = "icon_sort_8";
                            break;
                        case "GG29":
                            clazz = "icon_sort_9";
                            break;
                    }
                    
                    return clazz;
                }
            </script>
            <!-- // 관련사이트 -->