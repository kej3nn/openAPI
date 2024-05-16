package egovframework.common.nice.util;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.nice.domain.CheckPlusClient;
import egovframework.common.nice.domain.NiceClient;

public class NiceCert {
    private static final Logger logger = Logger.getLogger(NiceCert.class);

    // NICE 로부터 부여받은 본인인증 서비스 사이트 코드
    private static final String CHECK_PLUS_SITE_CODE = EgovProperties.getProperty("nice.siteCode");
    // NICE 로부터 부여받은 본인인증 서비스 사이트 패스워드
    private static final String CHECK_PLUS_SITE_PASSWORD = EgovProperties.getProperty("nice.sitePassword");

    /**
     * CheckPlus(본인인증) 서비스 회원사 정보 전달
     */
    public static void getCheckPlusForm(NiceClient niceClient, HttpServletRequest request) throws Exception {

        NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

        // 요청 번호, 이는 성공/실패 후에 같은 값으로 되돌려주게 되므로
        // 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
//        String sRequestNumber = "REQ0000000001";
        String sRequestNumber = niceCheck.getRequestNO(CHECK_PLUS_SITE_CODE);

        // 해킹 등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
        request.getSession().setAttribute("REQ_SEQ", sRequestNumber);

        // 없으면 기본 선택화면, M(휴대폰), X(인증서공통), U(공동인증서), F(금융인증서), S(PASS인증서), C(신용카드)
        String sAuthType = "U";
        //Y : 취소버튼 있음 / N : 취소버튼 없음
        String popgubun = "Y";
        //없으면 기본 웹페이지 / Mobile : 모바일페이지
        String customize = "";

        // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해
        // 다음예제와 같이 http 부터 입력합니다.
        // 리턴 url 은 인증 전 인증페이지를 호출하기 전 url 과 동일해야 합니다.
        // ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
//        String sReturnUrl = "http://www.test.co.kr/checkplus_success.jsp";      // 성공시 이동될 URL
//        String sErrorUrl = "http://www.test.co.kr/checkplus_fail.jsp";          // 실패시 이동될 URL
        String sReturnUrl = niceClient.getSReturnUrl();   // 성공시 이동될 URL
        String sErrorUrl = niceClient.getSErrorUrl();     // 실패시 이동될 URL

        // 입력될 plain 데이타를 만든다.
        String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                "8:SITECODE" + CHECK_PLUS_SITE_CODE.getBytes().length + ":" + CHECK_PLUS_SITE_CODE +
                "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
                "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun;

        String sMessage = "";
        String sEncData = "";

        int iReturn = niceCheck.fnEncode(CHECK_PLUS_SITE_CODE, CHECK_PLUS_SITE_PASSWORD, sPlainData);
        if (iReturn == 0) {
            sEncData = niceCheck.getCipherData();
        } else if (iReturn == -1) {
            sMessage = "암호화 시스템 오류입니다.";
        } else if (iReturn == -2) {
            sMessage = "암호화 처리 오류입니다.";
        } else if (iReturn == -3) {
            sMessage = "암호화 데이터 오류입니다.";
        } else if (iReturn == -9) {
            sMessage = "입력 데이터 오류입니다.";
        } else {
            sMessage = "시스템 오류입니다. iReturn : " + iReturn;
        }

        logger.debug("iReturn  [" + iReturn + "]");
        logger.debug("sEncData [" + sEncData + "]");
        logger.debug("sMessage [" + sMessage + "]");

        niceClient.setIReturn(iReturn);
        niceClient.setSEncData(sEncData);
        niceClient.setSMessage(sMessage);
    }

    /**
     * CheckPlus(본인인증) 서비스 요청 결과
     */
    public static void getCheckPlusResult(CheckPlusClient checkPlusClient) throws Exception {

        String sEncodeData = requestReplace(checkPlusClient.getSEncodeData(), "encodeData");
        String sMessage = "";

        /* 암호화 텍스트 분석 */
        NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

        int iReturn = niceCheck.fnDecode(CHECK_PLUS_SITE_CODE, CHECK_PLUS_SITE_PASSWORD, sEncodeData);

        if (iReturn == 0) {
            checkPlusClient.setSPlainData(niceCheck.getPlainData());
            checkPlusClient.setSCipherTime(niceCheck.getCipherDateTime());          // 복호화한 시간

            // 데이타를 추출합니다.
            HashMap mapResult = niceCheck.fnParse(checkPlusClient.getSPlainData());

            checkPlusClient.setReqSeq((String) mapResult.get("REQ_SEQ"));            // 요청 번호
            checkPlusClient.setResSeq((String) mapResult.get("RES_SEQ"));            // 인증 고유번호
            checkPlusClient.setAuthType((String) mapResult.get("AUTH_TYPE"));        // 인증 수단
            checkPlusClient.setName((String) mapResult.get("NAME"));                 // 성명
            // charset utf8 사용시 주석 해제 후 사용
            // checkPlusClient.setName((String)mapResult.get("UTF8_NAME"));         // 성명(UTF8)
            checkPlusClient.setBirthdate((String) mapResult.get("BIRTHDATE"));       // 생년월일(YYYYMMDD)
            checkPlusClient.setGender((String) mapResult.get("GENDER"));             // 성별
            checkPlusClient.setNationainfo((String) mapResult.get("NATIONALINFO"));  // 내/외국인정보 (개발가이드 참조)
            checkPlusClient.setDi((String) mapResult.get("DI"));                     // 중복가입 확인값 (DI_64 byte)
            checkPlusClient.setCi((String) mapResult.get("CI"));                     // 연계정보 확인값 (CI_88 byte)
            checkPlusClient.setMobileCo((String) mapResult.get("MOBILE_CO"));        // 통신사
            checkPlusClient.setMobileNo((String) mapResult.get("MOBILE_NO"));        // 휴대폰 번호
            checkPlusClient.setErrCode((String) mapResult.get("ERR_CODE"));          // 응답코드

            // checkplus_success 페이지에서 결과값 null 일 경우, 관련 문의는 관리담당자에게 하시기 바랍니다.

//            if(!checkPlusClient.getReqSeq().equals(request.getSession().getAttribute("REQ_SEQ"))) {
//                sMessage = "세션값 불일치 오류입니다.";
//                checkPlusClient.setResSeq("");
//                checkPlusClient.setAuthType("");
//            }

        } else if (iReturn == -1) {
            sMessage = "복호화 시스템 오류입니다.";
        } else if (iReturn == -4) {
            sMessage = "복호화 처리 오류입니다.";
        } else if (iReturn == -5) {
            sMessage = "복호화 해시 오류입니다.";
        } else if (iReturn == -6) {
            sMessage = "복호화 데이터 오류입니다.";
        } else if (iReturn == -9) {
            sMessage = "입력 정보 오류입니다.";
        } else if (iReturn == -12) {
            sMessage = "사이트 패스워드 오류입니다.";
        } else {
            sMessage = "시스템 오류입니다. iReturn : " + iReturn;
        }

        logger.debug("iReturn  [" + iReturn + "]");
        logger.debug("sMessage [" + sMessage + "]");

        checkPlusClient.setIReturn(iReturn);
        checkPlusClient.setSMessage(sMessage);
    }

    /**
     * 실명인증 결과 데이터 처리
     */
    private static String requestReplace(String paramValue, String gubun) {

        String result = "";

        if (paramValue != null) {

            paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

            paramValue = paramValue.replaceAll("\\*", "");
            paramValue = paramValue.replaceAll("\\?", "");
            paramValue = paramValue.replaceAll("\\[", "");
            paramValue = paramValue.replaceAll("\\{", "");
            paramValue = paramValue.replaceAll("\\(", "");
            paramValue = paramValue.replaceAll("\\)", "");
            paramValue = paramValue.replaceAll("\\^", "");
            paramValue = paramValue.replaceAll("\\$", "");
            paramValue = paramValue.replaceAll("'", "");
            paramValue = paramValue.replaceAll("@", "");
            paramValue = paramValue.replaceAll("%", "");
            paramValue = paramValue.replaceAll(";", "");
            paramValue = paramValue.replaceAll(":", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll("#", "");
            paramValue = paramValue.replaceAll("--", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll(",", "");

            if (gubun != "encodeData") {
                paramValue = paramValue.replaceAll("\\+", "");
                paramValue = paramValue.replaceAll("/", "");
                paramValue = paramValue.replaceAll("=", "");
            }

            result = paramValue;

        }
        return result;
    }
}
