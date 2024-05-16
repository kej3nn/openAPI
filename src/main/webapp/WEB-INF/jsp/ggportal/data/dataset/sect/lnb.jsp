<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)lnb.jsp 1.0 2015/06/15                                             --%>
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
<%-- 좌측 메뉴 섹션 화면이다.                                               --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
    <aside class="area_LNB">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/snb.jsp" %>
        <!-- 인기데이터 --> 
        <article class="bestData">
            <div class="area_tit">
                <h4 class="tit"><img src="<c:url value="/img/ggportal/desktop/common/tit_bestData.png" />" alt="인기데이터" /></h4>
                <span class="btn_more">
                    <a href="#none" title="인기데이터 1순위에서 5순위까지 보기" class="btn_bestData_L"><img src="<c:url value="/img/ggportal/desktop/common/btn_bestData_L.png" />" alt="인기데이터 1순위에서 5순위까지 보기 버튼" /></a>
                    <a href="#none" title="인기데이터 6순위에서 10순위까지 보기" class="btn_bestData_R"><img src="<c:url value="/img/ggportal/desktop/common/btn_bestData_R.png" />" alt="인기데이터 6순위에서 10순위까지 보기 버튼" /></a>
                </span>
            </div>
            <div class="cont">
                <ol id="bestData"></ol>
            </div>
        </article>
        <!-- // 인기데이터 -->
        <!-- 인기태그 --> 
        <article class="bestTag">
            <h4 class="tit"><img src="<c:url value="/img/ggportal/desktop/common/tit_bestTag.png" />" alt="인기태그" /></h4>
            <div class="cont hashtag-data-sect"></div>
            <a href="#layerPopup_bestTag" id="btn_more_bestTag" class="btn_more_bestTag btn_view_layerPopup btn_view_layerPopup_bestTag" title="인기태그 더보기"><span>더보기</span></a>
        </article>
        <!-- // 인기태그 -->
        <!-- layerPopup 태그 -->
        <div class="layout_layerPopup_A layout_layerPopup_A_bestTag">
            <div class="transparent"></div>
            <div id="layerPopup_bestTag" class="layerPopup_A">
                <h4 class="pop h4_pop_bestTag">인기태그</h4>
                <!-- 내용 -->
                <div class="cont scroll">
                    <div class="bestTag hashtag-data-sect"></div>
                </div>
                <!-- //내용 -->
                <a href="#btn_more_bestTag" class="btn_close"><span>레이어 팝업 닫기</span></a>
            </div>
        </div>
        <!-- layerPopup 태그 -->
        <!-- 제공기관 --> 
        <article class="providingOrganization">
            <h4 class="tit"><img src="<c:url value="/img/ggportal/desktop/common/tit_providingOrganization.png" />" alt="제공기관" /></h4>
            <ul class="organization-data-sect"></ul>
            <a href="#layerPopup_providingOrganization" id="btn_more_providingOrganization" class="btn_more_bestTag btn_view_layerPopup btn_view_layerPopup_providingOrganization" title="제공기관 더보기"><span>더보기</span></a>
        </article>
        <!-- // 제공기관 -->
        <!-- layerPopup 제공기관 -->
        <div class="layout_layerPopup_A layout_layerPopup_A_providingOrganization">
            <div class="transparent"></div>
            <div id="layerPopup_providingOrganization" class="layerPopup_A">
                <h4 class="pop h4_pop_providingOrganization">제공기관</h4>
                <!-- 내용 -->
                <div class="cont scroll">
                    <div class="providingOrganization_pop">
                        <ul class="organization-data-sect"></ul>
                    </div>
                </div>
                <!-- //내용 -->
                <a href="#btn_more_providingOrganization" class="btn_close"><span>레이어 팝업 닫기</span></a>
            </div>
        </div>
        <!-- layerPopup 제공기관 -->
        <script type="text/javascript">
            $(function() {
                // 공공데이터 데이터셋 인기순위를 검색한다.
                searchPopular();
                
                // 공공데이터 데이터셋 인기태그를 검색한다.
                searchHashtag();
                
                // 공공데이터 데이터셋 제공기관을 검색한다.
                searchOrganization();
            });
            
            /**
             * 공공데이터 데이터셋 인기순위를 검색한다.
             */
            function searchPopular() {
                // 데이터를 검색한다.
                doSearch({
                    url:"/portal/data/dataset/searchPopular.do",
                    before:beforeSearchPopular,
                    after:afterSearchPopular
                });
            }
            
            /**
             * 공공데이터 데이터셋 인기순위 검색 전처리를 실행한다.
             * 
             * @param options {Object} 옵션
             * @returns {Object} 데이터
             */
            function beforeSearchPopular(options) {
                var data = {
                    // Nothing do do.
                };
                
                return data;
            }
            
            /**
             * 공공데이터 데이터셋 인기순위 검색 후처리를 실행한다.
             * 
             * @param data {Array} 데이터
             */
            function afterSearchPopular(data) {
                var list = $(".bestData ol");
                
                list.find("li").each(function(index, element) {
                    $(this).remove();
                });
                
                for (var i = 0, n = 1; i < data.length; i++, n++) {
                    var item = $("<li><img alt=\"" + n + "\" /> <a href=\"#\"></a></li>");
                    
                    item.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/common/txt_num_" + n + ".png"));
                    item.find("a").text(data[i].infNm);
                    
                    // 공공데이터 데이터셋 인기순위 링크에 클릭 이벤트를 바인딩한다.
                    item.find("a").bind("click", {
                        infId:data[i].infId,
                        infSeq:data[i].infSeq
                    }, function(event) {
                        // 공공데이터 서비스를 조회한다.
                        selectService(event.data);
                        return false;
                    });
                    
                    // 공공데이터 데이터셋 인기순위 링크에 키다운 이벤트를 바인딩한다.
                    item.find("a").bind("keydown", {
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
             * 공공데이터 데이터셋 인기태그를 검색한다.
             */
            function searchHashtag() {
                // 데이터를 검색한다.
                doSearch({
                    url:"/portal/data/dataset/searchHashtag.do",
                    before:beforeSearchHashtag,
                    after:afterSearchHashtag
                });
            }
            
            /**
             * 공공데이터 데이터셋 인기태그 검색 전처리를 실행한다.
             * 
             * @param options {Object} 옵션
             * @returns {Object} 데이터
             */
            function beforeSearchHashtag(options) {
                var data = {
                    // Nothing do do.
                };
                
                return data;
            }
            
            /**
             * 공공데이터 데이터셋 인기태그 검색 후처리를 실행한다.
             * 
             * @param data {Array} 데이터
             */
            function afterSearchHashtag(data) {
                $(".hashtag-data-sect").each(function(index, element) {
                    var sect = $(this);
                    
                    sect.find("a").each(function(index, element) {
                        $(this).remove();
                    });
                    
                    var length = data.length;
                    
                    if (index == 0 && length > 10) {
                        length = 10;
                    }
                    
                    for (var i = 0; i < length; i++) {
                        if (i > 0) {
                            sect.append(" ");
                        }
                        
                        var link = $("<a class=\"dataset-hashtag-link\"></a>");
                        
                        if (data[i].viewCntRank <= Math.ceil(data.length / 5)) {
                            link.addClass("level_2");
                        }
                        
                        link.attr("href", "#" + data[i].tagNm).text(data[i].tagNm);
                        
                        // 공공데이터 데이터셋 인기태그 링크에 클릭 이벤트를 바인딩한다.
                        link.bind("click", {
                            tagNm:data[i].tagNm
                        }, function(event) {
                            // 공공데이터 데이터셋 인기태그를 변경한다.
                            changeHashtag(event.data.tagNm);
                            return false;
                        });
                        
                        // 공공데이터 데이터셋 인기태그 링크에 키다운 이벤트를 바인딩한다.
                        link.bind("keydown", {
                            tagNm:data[i].tagNm
                        }, function(event) {
                            if (event.which == 13) {
                                // 공공데이터 데이터셋 인기태그를 변경한다.
                                changeHashtag(event.data.tagNm);
                                return false;
                            }
                        });
                        
                        sect.append(link);
                    }
                });
                
                // 공공데이터 데이터셋 인기태그 링크를 초기화한다.
                $("#dataset-search-form :hidden[name=infTag]").each(function(index, element) {
                    $(".dataset-hashtag-link[href='#" + $(this).val() + "']").each(function(index, element) {
                        $(this).addClass("on");
                    });
                    
                    if (index == 0) {
                        // 공공데이터 데이터셋 키워드를 추가한다.
                        addDatasetKeyword("infTag", $(this).val(), $(this).val());
                    }
                });
            }
            
            /**
             * 공공데이터 데이터셋 인기태그를 변경한다.
             * 
             * @param tag {String} 태그
             */
            function changeHashtag(tag) {
                $(".dataset-hashtag-link[href='#" + tag + "']").each(function(index, element) {
                    var link = $(this);
                    
                    if (!link.hasClass("on")) {
                        if (index == 0) {
                            $(".dataset-category-button.on, .dataset-hashtag-link.on, .dataset-organization-link.on, .dataset-service-button.on").each(function(index, element) {
                                $(this).removeClass("on");
                            });
                            
                            link.addClass("on");
                            
                            var form = $("#dataset-search-form");
                            
                            form.find("[name=cateId], [name=infTag], [name=orgCd], [name=srvCd], [name=searchWord]").each(function(index, element) {
                                $(this).remove();
                            });
                            
                            var list = $("#dataset-keyword-list");
                            
                            list.find(".infTag").each(function(index, element) {
                                $(this).remove();
                            });
                            
                            $(".dataset-hashtag-link.on").each(function(index, element) {
                                var hidden = $("<input type=\"hidden\" name=\"infTag\" />");
                                
                                hidden.val($(this).attr("href").substring(1));
                                
                                form.append(hidden);
                                
                                // 공공데이터 데이터셋 키워드를 추가한다.
                                addDatasetKeyword("infTag", $(this).attr("href").substring(1), $(this).text());
                            });
                            
                            $("#dataset-searchword-field").val("");
                            
                            $("#layerPopup_bestTag .btn_close").click();
                            
                            // 공공데이터 데이터셋 전체목록을 검색한다.
                            searchDataset();
                        }
                        else {
                            link.addClass("on");
                        }
                    }
                });
            }
            
            /**
             * 공공데이터 데이터셋 제공기관을 검색한다.
             */
            function searchOrganization() {
                // 데이터를 검색한다.
                doSearch({
                    url:"/portal/data/dataset/searchOrganization.do",
                    before:beforeSearchOrganization,
                    after:afterSearchOrganization
                });
            }
            
            /**
             * 공공데이터 데이터셋 제공기관 검색 전처리를 실행한다.
             * 
             * @param options {Object} 옵션
             * @returns {Object} 데이터
             */
            function beforeSearchOrganization(options) {
                var data = {
                    // Nothing do do.
                };
                
                return data;
            }
            
            /**
             * 공공데이터 데이터셋 제공기관 검색 후처리를 실행한다.
             * 
             * @param data {Array} 데이터
             */
            function afterSearchOrganization(data) {
                $(".organization-data-sect").each(function(index, element) {
                    var list = $(this);
                    
                    list.find("li").each(function(index, element) {
                        $(this).remove();
                    });
                    
                    var length = data.length;
                    
                    if (index == 0 && length > 5) {
                        length = 5;
                    }
                    
                    for (var i = 0; i < length; i++) {
                        var item = $("<li><a class=\"dataset-organization-link\"></a></li>");
                        
                        item.find("a").attr("href", "#" + data[i].orgCd).text(data[i].orgNm);
                        
                        // 공공데이터 데이터셋 제공기관 링크에 클릭 이벤트를 바인딩한다.
                        item.find("a").bind("click", {
                            orgCd:data[i].orgCd
                        }, function(event) {
                            // 공공데이터 데이터셋 제공기관을 변경한다.
                            changeOrganization(event.data.orgCd);
                            return false;
                        });
                        
                        // 공공데이터 데이터셋 제공기관 링크에 키다운 이벤트를 바인딩한다.
                        item.find("a").bind("keydown", {
                            orgCd:data[i].orgCd
                        }, function(event) {
                            if (event.which == 13) {
                                // 공공데이터 데이터셋 제공기관을 변경한다.
                                changeOrganization(event.data.orgCd);
                                return false;
                            }
                        });
                        
                        list.append(item);
                    }
                });
                
                // 공공데이터 데이터셋 제공기관 링크를 초기화한다.
                $("#dataset-search-form :hidden[name=orgCd]").each(function(index, element) {
                    $(".dataset-organization-link[href='#" + $(this).val() + "']").each(function(index, element) {
                        $(this).addClass("on");
                        
                        if (index == 0) {
                            // 공공데이터 데이터셋 키워드를 추가한다.
                            addDatasetKeyword("orgCd", $(this).attr("href").substring(1), $(this).text());
                        }
                    });
                });
            }
            
            /**
             * 공공데이터 데이터셋 제공기관을 변경한다.
             * 
             * @param code {String} 코드
             */
            function changeOrganization(code) {
                $(".dataset-organization-link[href='#" + code + "']").each(function(index, element) {
                    var link = $(this);
                    
                    if (!link.hasClass("on")) {
                        if (index == 0) {
                            $(".dataset-category-button.on, .dataset-hashtag-link.on, .dataset-organization-link.on, .dataset-service-button.on").each(function(index, element) {
                                $(this).removeClass("on");
                            });
                            
                            link.addClass("on");
                            
                            var form = $("#dataset-search-form");
                            
                            form.find("[name=cateId], [name=infTag], [name=orgCd], [name=srvCd], [name=searchWord]").each(function(index, element) {
                                $(this).remove();
                            });
                            
                            var list = $("#dataset-keyword-list");
                            
                            list.find(".orgCd").each(function(index, element) {
                                $(this).remove();
                            });
                            
                            $(".dataset-organization-link.on").each(function(index, element) {
                                var hidden = $("<input type=\"hidden\" name=\"orgCd\" />");
                                
                                hidden.val($(this).attr("href").substring(1));
                                
                                form.append(hidden);
                                
                                // 공공데이터 데이터셋 키워드를 추가한다.
                                addDatasetKeyword("orgCd", $(this).attr("href").substring(1), $(this).text());
                            });
                            
                            $("#dataset-searchword-field").val("");
                            
                            $("#layerPopup_providingOrganization .btn_close").click();
                            
                            // 공공데이터 데이터셋 전체목록을 검색한다.
                            searchDataset();
                        }
                        else {
                            link.addClass("on");
                        }
                    }
                });
            }
            
            /**
             * 공공데이터 데이터셋 키워드를 추가한다.
             * 
             * @param type {String} 유형
             * @param code {String} 코드
             * @param name {String} 이름
             */
            function addDatasetKeyword(type, code, name) {
                // var list = $("#dataset-keyword-list");
                // 
                // var template = "";
                // 
                // template += "<span class=\"sort_bestTag " + type + "\">";
                // template += "    <strong></strong>";
                // template += "    <a href=\"#\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete_bestTag.png") + "\" alt=\"\" /></a>";
                // template += "</span>";
                // 
                // var item = $(template);
                // 
                // item.find("strong").text(name);
                // item.find("a").attr("href", "#" + code);
                // 
                // item.find("a").bind("click", function(event) {
                //     // 공공데이터 데이터셋 키워드를 삭제한다.
                //     removeDatasetKeyword(this);
                // });
                // 
                // item.find("a").bind("keydown", function(event) {
                //     if (event.which == 13) {
                //         // 공공데이터 데이터셋 키워드를 삭제한다.
                //         removeDatasetKeyword(this);
                //     }
                // });
                // 
                // if (list.find("span").length > 0) {
                //     list.append(" ");
                // }
                // 
                // list.append(item);
                // 
                // // 공공데이터 데이터셋 키워드를 토글한다.
                // toggleDatasetKeyword();
                switch (type) {
                    case "cateId":
                        $("#dataset-keyword-sect").html("<strong>" + name + "</strong> 분류 선택");
                        break;
                    case "infTag":
                        $("#dataset-keyword-sect").html("<strong>" + name + "</strong> 태그 선택");
                        break;
                    case "orgCd":
                        $("#dataset-keyword-sect").html("<strong>" + name + "</strong> 제공기관 선택");
                        break;
                }
            }
            
            /**
             * 공공데이터 데이터셋 키워드를 삭제한다.
             * 
             * @param link {Element} 링크
             */
            function removeDatasetKeyword(link) {
                var form = $("#dataset-search-form");
                
                if ($(link).parent("span").hasClass("cateId")) {
                    $(".dataset-category-button.on[href=" + $(link).attr("href") +"]").each(function(index, element) {
                        $(this).removeClass("on");
                    });
                    
                    if ($("#dataset-category-combo").val()) {
                        $("#dataset-category-combo").val("");
                    }
                            
                    form.find("[name=cateId][value=" + $(link).attr("href").substring(1) + "]").each(function(index, element) {
                        $(this).remove();
                    });
                }
                else if ($(link).parent("span").hasClass("infTag")) {
                    $(".dataset-hashtag-link.on[href=" + $(link).attr("href") +"]").each(function(index, element) {
                        $(this).removeClass("on");
                    });
                            
                    form.find("[name=infTag][value=" + $(link).attr("href").substring(1) + "]").each(function(index, element) {
                        $(this).remove();
                    });
                }
                else {
                    $(".dataset-organization-link.on[href=" + $(link).attr("href") +"]").each(function(index, element) {
                        $(this).removeClass("on");
                    });
                            
                    form.find("[name=orgCd][value=" + $(link).attr("href").substring(1) + "]").each(function(index, element) {
                        $(this).remove();
                    });
                }
                
                $(link).parent("span").remove();
                
                // 공공데이터 데이터셋 키워드를 토글한다.
                toggleDatasetKeyword();
                
                // 공공데이터 데이터셋 전체목록을 검색한다.
                searchDataset();
            }
            
            /**
             * 공공데이터 데이터셋 키워드를 토글한다.
             */
            function toggleDatasetKeyword() {
                var list = $("#dataset-keyword-list")
                
                if (list.find("span").length > 0) {
                    if (list.hasClass("hide")) {
                        list.removeClass("hide");
                    }
                }
                else {
                    if (!list.hasClass("hide")) {
                        list.addClass("hide");
                    }
                }
            }
            
            
            /**
             * 공공데이터 데이터셋 제공기관(최상위) 목록을 검색한다.
             */
            function searchOpenDsTopOrgList() {
                // 데이터를 검색한다.
                doSearch({
                    url:"/portal/data/dataset/searchPopular.do",
                    before:beforeSearchOpenDsTopOrgList,
                    after:afterSearchOpenDsTopOrgList
                });
            }
            
            
        </script>
    </aside>