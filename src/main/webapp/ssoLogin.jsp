<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="egovframework.common.util.HashEncrypt"%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 전자문서 시스템에서 정보공개포털로 접근할경우 데이터 정보를 전달한다.  	--%>
<%--                                                                        	--%>
<%-- @author jhkim                                                          	--%>
<%-- @version 1.0 2019/12/01	Initial Creation.                           	--%>
<%-- @version 1.1 2020/01/16    Charset 확인(meta page utf-8 속성 제거)     	--%>
<%-- @version 1.2 2020/02/20    name, grade, position, deptname 컬럼(한글) 삭제 --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	--%>
<%
	/* SEED 암호 키(보내는쪽과 받는쪽의 키가 맞아야 함) */
	String SEED_SECRET_KEY = "wjdqhrhdrovhxjf!";

	String strLoginID		= (String)session.getAttribute("LOGINID");
	String strUserID		= (String)session.getAttribute("USERID");
System.out.println("strUserID = " + strUserID);	
	String strDeptCode		= "";
	String strDeptName		= "";
	String strUserName		= "";
	String strUserGrade		= "";
	String strUserPosition	= "";
	String strSysMail		= "";
	String strOfficeTel		= "";

	String strSendData		= "";
	String strUserFlag      = "inner";

	String strResultCode    = "1";
	String strResultDesc	= "사용자 정보를 정상적으로 가져왔습니다.";
	String strTime			= ""
	String strTime2			= ""

	String login_ip = request.getRemoteAddr();
System.out.println(" ######## login_ip = " + login_ip);
	
	OrgProviderHome orgproviderhome = null;
	
	try{
		orgproviderhome = (OrgProviderHome)EJBHomeFactory.getFactory().lookUpHome("OrgProvider",com.sds.acube.cn.org.service.OrgProviderHome.class);
	   
		OrgProvider orgprovider = orgproviderhome.create();

		IUser iUser = orgprovider.getUserByUID(strUserID);

		strDeptCode		= iUser.getDeptID();			// 부서코드	
		strDeptName		= iUser.getDeptName();			// 부서명
		strUserName		= iUser.getUserName();			// 사용자명
		strUserGrade	= iUser.getGradeName();			// 직급명	
		strUserPosition = iUser.getPositionName();		// 직위명
		strSysMail		= iUser.getSysMail();			// 내부메일주소
		strOfficeTel	= iUser.getOfficeTel();			// 내선번호
		
		SimpleDateFormat format = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		Date time = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(time);
		cal.add(Calendar.HOUR, 8);	// 8시간 후..
		
		// 접근시간
		strTime = format.format(cal.getTime());		// 8시간 후
		strTime2 = format.format(time);				// 현재시간
		
System.out.println("strDeptCode :"+strDeptCode);
System.out.println("strDeptName :"+strDeptName);
System.out.println("strUserGrade :" +strUserGrade);
System.out.println("strUserName : "+strUserName);
System.out.println("strUserPosition : "+strUserPosition);
System.out.println("strSysMail : "+strSysMail);
System.out.println("strOfficeTel : "+strOfficeTel);
System.out.println("strTime : "+strTime);
System.out.println("strTime2 : "+strTime2);

	}
	catch(Exception e){
           e.printStackTrace();
	}
		
	strSendData	=
		"<?xml version='1.0' encoding='euc-kr'?>\n" +
		"<openportal>\n" +
		"	<user>\n" +
		"		<id>"+strLoginID+"</id>\n" +
		"		<uid>"+strUserID+"</uid>\n" +		
		"		<mail>"+strSysMail+"</mail>\n" +
		"		<inphone>"+strOfficeTel+"</inphone>\n" +
		"		<deptcode>"+strDeptCode+"</deptcode>\n" +
		"		<lastlogin>"+strTime2+"</lastlogin>\n" +
		"	</user>\n" +
		"</openportal>\n";
		
		
	System.out.println("portal : ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
	System.out.println("portal : "+strSendData);
System.out.println("portal : ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("portal : "+strSendData);

	byte [] key = HashEncrypt.makeHashByte(SEED_SECRET_KEY);
	strSendData = HashEncrypt.encrypt(key, strSendData);

System.out.println("portal-enc : "+strSendData);
%>
<html>
<title></title>
<head>
<script language="javascript">

function onLoad()
{
	document.openPortal.submit();
}
</script>

</head>
<body onLoad="onLoad();return false;">
<form METHOD="post" NAME="openPortal" ACTION="https://open.assembly.go.kr/portal/user/ssoLoginProc.do">
<input TYPE="hidden" NAME="userdata" VALUE="<%=strSendData%>">
</FORM>
</body>
</html>