<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page  import="egovframework.admin.basicinf.service.CommUsr" %>      
<script language="javascript"> 
//<![CDATA[
$(document).ready(function() {                
	var dp01 = $(".lnb .dp01");     
	var dp02 = $(".lnb .dp02");  
	var dp03 = $(".lnb .dp03");  
	$(".lnb ul").css("width","1000px");     
	                   
	dp01.each(function(index,item){ // 1레벨
	    var titleIndex = $(".title p").text().indexOf(">");
		if($(item).find("a").eq(0).text() == $(".title p").text().substring(0,titleIndex-1)){
			$(item).find("a").eq(0).addClass("menuOn");      
		}                    
		$(item).hover(                                                  
				function(){
					$(item).find("ul").eq(0).css("visibility","");      
					$(item).find("ul").eq(0).slideDown("fast");   
					$(item).find("a").eq(0).addClass("on");
				},           
				function(){                                   
					$(item).find("ul").eq(0).hide();              
					$(item).find("a").eq(0).removeClass("on");
				}
		);              
	});       
	   
	dp02.each(function(index,item){ //2레벨                   
		var width = 160;
		var position = $(item).parent().position();  
		$(item).css("top", "48px").css("left",position.left);
		$(item).children("li[name=dp02name]").each(function(index,item){      
			if(index == 0){
				width = 160;
			}
			$(item).hover(                                 
					function(){          
						 $(item).find("ul").eq(0).css("visibility","");                                                 
						$(item).find("ul").eq(0).css("top",$(item).position().top);                                          
						$(item).find("a").eq(0).addClass("on");
						$(item).find("ul").eq(0).slideDown("fast");              
					},
					function(){                        
						 $(item).find("a").eq(0).removeClass("on");
						$(item).find("ul").eq(0).hide();                             
					}
			); 
			var span1 = $(item).find("span").eq(1).position();  
			var span0 =  $(item).find("span").eq(0).position();                         
			if(width < (span1.left - span0.left)+10){                  
				width = (span1.left - span0.left)+10;                                                                                                                                                                                                          
			} 
		});                                                     
		$(item).css("width",width);                        
	});         
	 
	dp03.each(function(index,item){  // 3레벨                             
		var width = 130;
		var width = $(item).parent().parent().width();
		$(item).css("left",(width+8)+"px");
		$(item).children("li[name=dp03name]").each(function(index,item){      
			if(index == 0){
				width = 130;           
			}
			var span1 = $(item).find("span").eq(1).position();  
			var span0 =  $(item).find("span").eq(0).position();  
			if(width < (span1.left - span0.left)+10){
				width = (span1.left - span0.left)+10;                                                                                                                                                                                                                     
			}             
		});                                     
		$(item).css("width",width);                
	});
	$("span[name=removeSpan]").remove();    
	aAndButtonSet();     
	myInfoUpd();
});                
                           
function adminTopMenu(url) {
	location.href = "<c:url value='"+url+"'/>";
}

function aAndButtonSet(){
	$(".logout").click(function(e) {
		location.href = "<c:url value='/admin/adminlogOut.do'/>"; //로그아웃
		return false;
	}); 
	
	$("a[name=mainHome]").click(function(e) {
		location.href = "<c:url value='/admin/adminMain.do'/>"; //메인페이지로 이동
		return false;                  
	});
}

//개인정보 수정
function myInfoUpd(){ 
	$("a[name=myInfoUpd]").click(function(e) {
		location.href = "<c:url value='/admin/user/pwConfirm.do'/>";
		return false;
	});                         
}

//]]> 
</script>      
<!-- 상단 -->
		<div class="header">
			<!-- 로고 및 유틸메뉴 -->  
			<h1><a href="#" name="mainHome">열린국회정보 관리시스템</a></h1>
                                                                                    
			<div class="user_info">   
			    <strong><c:out value="${sessionScope.loginVO.usrNm}"/>님</strong> 환영합니다     
			    <a href="#" name="myInfoUpd" class="set">개인정보수정</a>                    
				<a href="#" class="logout"><spring:message code='a.logout'/></a>
			</div>
		</div>          
		${admintop} 