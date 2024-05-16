<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head> 

<script type="text/javascript" src="/assets/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/assets/juso/rnic-search.js"></script>
<script type="text/javascript" src="/assets/juso/rnic-common.js"></script>
<script type="text/javascript" src="/assets/juso/jusoApiPop.js"></script>
<link rel="stylesheet" type="text/css" href="/assets/juso/common.css">
<link rel="stylesheet" type="text/css" href="/assets/juso/addrlink.css">
<link rel="stylesheet" type="text/css" href="/assets/juso/jusoApiPop.css">
<title>주소검색</title>
</head>

<body onload="init();" class="visualSection"> 
    <form name="rtForm" id="rtForm" method="post">
        <input type="hidden" name="inputYn" id="inputYn" value="Y">  
        <input type="hidden" name="roadFullAddr" id="roadFullAddr">  
        <input type="hidden" name="roadAddrPart1" id="roadAddrPart1">
        <input type="hidden" name="roadAddrPart2" id="roadAddrPart2">
        <input type="hidden" name="engAddr" id="engAddr">            
        <input type="hidden" name="jibunAddr" id="jibunAddr">        
        <input type="hidden" name="zipNo" id="zipNo">                
        <input type="hidden" name="addrDetail" id="addrDetail">
        <input type="hidden" name="admCd" id="admCd">
        <input type="hidden" name="rnMgtSn" id="rnMgtSn">
        <input type="hidden" name="bdMgtSn" id="bdMgtSn">
        
        <input type="hidden" name="detBdNmList" id="detBdNmList"> 
        <input type="hidden" name="bdNm" id="bdNm"> 
        <input type="hidden" name="bdKdcd" id="bdKdcd"> 
        <input type="hidden" name="siNm" id="siNm"> 
        <input type="hidden" name="sggNm" id="sggNm"> 
        <input type="hidden" name="emdNm" id="emdNm"> 
        <input type="hidden" name="liNm" id="liNm"> 
        <input type="hidden" name="rn" id="rn"> 
        <input type="hidden" name="udrtYn" id="udrtYn"> 
        <input type="hidden" name="buldMnnm" id="buldMnnm"> 
        <input type="hidden" name="buldSlno" id="buldSlno"> 
        <input type="hidden" name="mtYn" id="mtYn"> 
        <input type="hidden" name="lnbrMnnm" id="lnbrMnnm"> 
        <input type="hidden" name="lnbrSlno" id="lnbrSlno"> 
        <input type="hidden" name="emdNo" id="emdNo"> 
    </form>

    <form name="AKCFrm" id="AKCFrm" method="post">
        <!--<input type="text" name="" id="" style="display:none;"/> textbox한개일경우 엔터시 자동 submit되는거 막기위해-->
        <!-- iframe 추가 S-->
        <input type="hidden" name="iframe" value="null">
        <input type="hidden" name="confmKey" value="U01TX0FVVEgyMDIyMDYwMjE1MTQzODExMjYzODY=">
        <input type="hidden" name="encodingType" value="">
        <input type="hidden" name="cssUrl" value="">
        <input type="hidden" name="resultType" value="4">
        <!-- <input type="hidden" name="resultType" value="xml"> -->
        <input type="hidden" name="currentPage" id="currentPage" value="1">
        <input type="hidden" name="countPerPage" value="5">
        <!-- iframe 추가 E-->     
        
        <input type="hidden" name="rtRoadAddr" id="rtRoadAddr">
        <input type="hidden" name="rtAddrPart1" id="rtAddrPart1">
        <input type="hidden" name="rtAddrPart2" id="rtAddrPart2">
        <input type="hidden" name="rtEngAddr" id="rtEngAddr">
        <input type="hidden" name="rtJibunAddr" id="rtJibunAddr">
        <input type="hidden" name="rtZipNo" id="rtZipNo">
        <input type="hidden" name="rtAdmCd" id="rtAdmCd">
        <input type="hidden" name="rtRnMgtSn" id="rtRnMgtSn">
        <input type="hidden" name="rtBdMgtSn" id="rtBdMgtSn">
        
        <input type="hidden" name="rtDetBdNmList" id="rtDetBdNmList">
        <input type="hidden" name="rtBdNm" id="rtBdNm">
        <input type="hidden" name="rtBdKdcd" id="rtBdKdcd">
        <input type="hidden" name="rtSiNm" id="rtSiNm">
        <input type="hidden" name="rtSggNm" id="rtSggNm">
        <input type="hidden" name="rtEmdNm" id="rtEmdNm">
        <input type="hidden" name="rtLiNm" id="rtLiNm">
        <input type="hidden" name="rtRn" id="rtRn">
        <input type="hidden" name="rtUdrtYn" id="rtUdrtYn">
        <input type="hidden" name="rtBuldMnnm" id="rtBuldMnnm">
        <input type="hidden" name="rtBuldSlno" id="rtBuldSlno">
        <input type="hidden" name="rtMtYn" id="rtMtYn">
        <input type="hidden" name="rtLnbrMnnm" id="rtLnbrMnnm">
        <input type="hidden" name="rtLnbrSlno" id="rtLnbrSlno">
        <input type="hidden" name="rtEmdNo" id="rtEmdNo">
        
        <input type="hidden" name="searchType" id="searchType">
        <input type="hidden" name="dsgubuntext" id="dsgubuntext">   
        <input type="hidden" name="dscity1text" id="dscity1text">
        <input type="hidden" name="dscounty1text" id="dscounty1text">
        <input type="hidden" name="dsemd1text" id="dsemd1text">
        <input type="hidden" name="dsri1text" id="dsri1text">
        <input type="hidden" name="dsrd_nm1text" id="dsrd_nm1text">
        <input type="hidden" name="dssan1text" id="dssan1text">
        <input type="hidden" name="hstryYn" id="hstryYn" value=""><!-- 변동된 주소정보 포함여부 -->
        <input type="hidden" name="firstSort" id="firstSort" value=""><!-- 우선정렬 -->
        <input type="hidden" name="addInfoYn" id="addInfoYn" value="Y"><!-- 추가된 항목(hstryYn, relJibun, hemdNm) 제공여부 -->
    
    
        <div class="pop-address-search pop-address-search-line">
            <div class="pop-address-search-inner">
            <div id="searchContentBox" style="min-height: 466px;">
                <div class="search-wrap">
                    <fieldset>
                        <legend>도로명주소 검색</legend>       
                        <span class="wrap">
                            <input type="text" class="popSearchInput" title="검색어 -예시 : 도로명(반포대로 58), 건물명(독립기념관), 지번(삼성동 25)" name="keyword" id="keyword" value="" tabindex="1">
                            <input type="button" title="검색" tabindex="2" onclick="javascript:$('#currentPage').val(1);$('#raFirstSortNone').prop('checked',true); searchUrlJuso();" style=" cursor: pointer;">
                        </span>
                        <div class="juso_info">
                            <div class="juso_info_w">
                                <input type="checkbox" tabindex="4" id="ckHstryYn" name="ckHstryYn" title="변동된 주소정보 포함" style="cursor: pointer;">
                                <label for="ckHstryYn">변동된 주소정보 포함</label>
                            </div>
                            <p class="search-sampletxt">예시 : 도로명(반포대로 58), 건물명(독립기념관), 지번(삼성동 25)</p>
                        </div>
                    </fieldset>
                </div>
                
                <!-- nodata -->
                
                   <div class="popSearchNoResult" style="padding:10px 0 5px 0;">
                        
                    </div>
                
                
                <!-- //nodata -->

                <!-- 검색결과 -->
                
                
                <!-- //검색결과 -->
                <!-- 상세주소 -->
                <div class="detail" style="display:none;" id="resultData">
                    <p><strong>상세주소 입력</strong></p>
                    <table class="data-row">
                        <caption>주소 입력</caption>
                        <colgroup>
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">도로명주소</th>
                                <td id="addrPart1" style="font-size:15px; height:20px; line-height:20px; background-color: #FFFFFF;padding: 10px 20px;"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="inputPopAddress">상세주소입력</label></th>
                                <td style="background-color: #FFFFFF;padding: 10px 20px;">
                                    
                                        <input type="text" name="rtAddrDetail" id="rtAddrDetail" style="width: 100%; font-size: 13px;" onkeypress="addrDetailChk();" onkeyup="addrDetailChk1(this);" title="상세주소">
                                    
                                    <div id="addrPart2" style="font-size: 13px;"></div>
                                    <div id="addrPartDetailNoneGuide" style="font-size: 11px;visibility: hidden;margin-top: 8px;">
                                         ※ 해당 주소지는 상세주소가 등록되어 있지 않습니다.
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <div class="btns-submit">
                        <a class="btn-bl" href="javascript:setParent();">주소입력</a>
                    </div>
                </div>
            </div>
            </div>
            <div class="logo" style="display: block;">도로명주소 로고</div>
            <a class="close" href="javascript:popClose();" title="창닫기" tabindex="3">닫기</a>
        </div>
        </form>


</body></html>