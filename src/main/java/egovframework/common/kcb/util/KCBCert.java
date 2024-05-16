package egovframework.common.kcb.util;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.kcb.domain.KCBClient;
import kcb.org.json.JSONObject;

/**
 * KCB 본인인증
 *
 * @author csb
 * @version 1.0 2021/06/13
 */
public class KCBCert {
    // KCB 로부터 부여받은 회원사 코드(12자리)
    private static final String CP_CD = EgovProperties.getProperty("Globals.KcbCpCode");
    // 회원사 사이트 명
    private static final String SITE_NAME = "열린국회정보";
    // 회원사 사이트 URL
    private static final String SITE_URL = "open.assembly.go.kr";
    // KCB Target Service
    private static final String KCB_TARGET = "PROD";

    private static final String RQST_CAUS_CD = "00";
    // license file 경로
    private static final String IDS_LICENSE = EgovProperties.getProperty("Globals.KcbFilePath") + CP_CD + "_IDS_01_" + KCB_TARGET + "_AES_license.dat";
    private static final String TIS_LICENSE = EgovProperties.getProperty("Globals.KcbFilePath") + CP_CD + "_TIS_01_" + KCB_TARGET + "_AES_license.dat";

    // Service 명 (고정값)
    private static final String IDS_SVC_START = "IDS_HS_POPUP_START";
    private static final String IDS_SVC_RESULT = "IDS_HS_POPUP_RESULT";
    private static final String TIS_SVC_START = "TIS_IPIN_POPUP_START";
    private static final String TIS_SVC_RESULT = "TIS_IPIN_POPUP_RESULT";

    /**
     * CheckPlus(본인인증) 서비스 회원사 정보 전달
     */
    public static void getCheckPlusForm(KCBClient kcbClient) throws Exception {

        /**************************************************************************
         okcert3 요청 정보
         **************************************************************************/
        JSONObject reqJson = new JSONObject();
        reqJson.put("RETURN_URL", kcbClient.getReturnUrl());
        reqJson.put("SITE_NAME", SITE_NAME);
        reqJson.put("SITE_URL", SITE_URL);
        reqJson.put("RQST_CAUS_CD", RQST_CAUS_CD);

        //reqJson.put("CHNL_CD", CHNL_CD);
        //reqJson.put("RETURN_MSG", RETURN_MSG);

        // 사전에 입력받은 정보로 팝업창 개인정보를 고정할 경우 사용 (가이드 참고)
        //reqJson.put("IN_TP_BIT", "15");
        //reqJson.put("NAME", "홍길동");
        //reqJson.put("BIRTHDAY", "19870725");
        //reqJson.put("TEL_NO", "01012345678");
        //reqJson.put("NTV_FRNR_CD", "F");	// 내국인 L 외국인 F
        //reqJson.put("SEX_CD", "F");		// 남성 M 여성 F

        //' 거래일련번호는 기본적으로 모듈 내에서 자동 채번되고 채번된 값을 리턴해줌.
        //'	회원사가 직접 채번하길 원하는 경우에만 아래 코드를 주석 해제 후 사용.
        //' 각 거래마다 중복 없는 String 을 생성하여 입력. 최대길이:20
        //reqJson.put("TX_SEQ_NO", "123456789012345");

        String reqStr = reqJson.toString();

        /**************************************************************************
         okcert3 실행
         **************************************************************************/
        kcb.module.v3.OkCert okCert = new kcb.module.v3.OkCert();

        String resultStr = okCert.callOkCert(KCB_TARGET, CP_CD, IDS_SVC_START, IDS_LICENSE, reqStr);

        JSONObject resJson = new JSONObject(resultStr);

        String RSLT_CD = resJson.getString("RSLT_CD");
        String RSLT_MSG = resJson.getString("RSLT_MSG");

        // 필요 시 거래 일련 번호에 대하여 DB 저장 등의 처리
        //if(resJson.has("TX_SEQ_NO")) String TX_SEQ_NO = resJson.getString("TX_SEQ_NO");
        String MDL_TKN = "";

//        boolean succ = false;

        if ("B000".equals(RSLT_CD) && resJson.has("MDL_TKN")) {
            MDL_TKN = resJson.getString("MDL_TKN");
//            succ = true;
        }

        kcbClient.setCpCd(CP_CD);
        kcbClient.setResultCd(RSLT_CD);
        kcbClient.setResultMsg(RSLT_MSG);
        kcbClient.setMdlToken(MDL_TKN);
    }

    /**
     * CheckPlus(본인인증) 서비스 요청 결과
     */
    public static void getCheckPlusResult(KCBClient kcbClient) throws Exception {

        /**************************************************************************
         okcert3 요청 정보
         **************************************************************************/
        JSONObject reqJson = new JSONObject();
        reqJson.put("MDL_TKN", kcbClient.getMdlToken());
        String reqStr = reqJson.toString();

        /**************************************************************************
         okcert3 실행
         **************************************************************************/
        kcb.module.v3.OkCert okcert = new kcb.module.v3.OkCert();

        // '************ IBM JDK 사용 시, 주석 해제하여 호출 ************
        // okcert.setProtocol2type("22");
        // '객체 내 license를 리로드해야 될 경우에만 주석 해제하여 호출. (v1.1.7 이후 라이센스는 파일위치를 key로 하여 static HashMap으로 사용됨)
        // okcert.delLicense(license);

        String resultStr = okcert.callOkCert(KCB_TARGET, CP_CD, IDS_SVC_RESULT, IDS_LICENSE, reqStr);

        JSONObject resJson = new JSONObject(resultStr);

        String RSLT_CD = resJson.getString("RSLT_CD");
        String RSLT_MSG = resJson.getString("RSLT_MSG");
        String TX_SEQ_NO = resJson.getString("TX_SEQ_NO");

        String RETURN_MSG = "";
        if (resJson.has("RETURN_MSG")) RETURN_MSG = resJson.getString("RETURN_MSG");

        if ("B000".equals(RSLT_CD)) {
            kcbClient.setName(resJson.getString("RSLT_NAME"));
            kcbClient.setBirthDate(resJson.getString("RSLT_BIRTHDAY"));
            kcbClient.setGenderCode(resJson.getString("RSLT_SEX_CD"));
            kcbClient.setNationalInfo(resJson.getString("RSLT_NTV_FRNR_CD"));

            kcbClient.setDupInfo(resJson.getString("DI"));
            kcbClient.setCoInfo1(resJson.getString("CI"));
            kcbClient.setCiUpdate(resJson.getString("CI_UPDATE"));
            kcbClient.setTelComCd(resJson.getString("TEL_COM_CD"));
            kcbClient.setTelNo(resJson.getString("TEL_NO"));
        }

        kcbClient.setResultCd(RSLT_CD);
        kcbClient.setResultMsg(RSLT_MSG);
        kcbClient.setReturnMsg(RETURN_MSG);
        kcbClient.setTxSeqNo(TX_SEQ_NO);
    }

    /**
     * 가상주민번호서비스(IPIN) 회원사 정보 전달
     */
    public static void getIPinForm(KCBClient kcbClient) throws Exception {

        /**************************************************************************
         okcert3 요청 정보
         **************************************************************************/
        JSONObject reqJson = new JSONObject();
        reqJson.put("RTN_URL", kcbClient.getReturnUrl());
        reqJson.put("SITE_NAME", SITE_NAME);
        reqJson.put("SITE_URL", SITE_URL);
        reqJson.put("RQST_CAUS_CD", kcbClient.getReqCauseCd());
        reqJson.put("CHNL_CD", kcbClient.getChannelCd());
        reqJson.put("RETURN_MSG", kcbClient.getReturnMsg());

        //' 거래일련번호는 기본적으로 모듈 내에서 자동 채번되고 채번된 값을 리턴해줌.
        //'	회원사가 직접 채번하길 원하는 경우에만 아래 코드를 주석 해제 후 사용.
        //' 각 거래마다 중복 없는 String 을 생성하여 입력. 최대길이:20
        //reqJson.put("TX_SEQ_NO", "123456789012345");

        String reqStr = reqJson.toString();

        /**************************************************************************
         okcert3 실행
         **************************************************************************/
        kcb.module.v3.OkCert okCert = new kcb.module.v3.OkCert();

        String resultStr = okCert.callOkCert(KCB_TARGET, CP_CD, TIS_SVC_START, TIS_LICENSE, reqStr);

        JSONObject resJson = new JSONObject(resultStr);

        String RSLT_CD = resJson.getString("RSLT_CD");
        String RSLT_MSG = resJson.getString("RSLT_MSG");

        // 필요 시 거래 일련 번호에 대하여 DB 저장 등의 처리
        //if(resJson.has("TX_SEQ_NO")) String TX_SEQ_NO = resJson.getString("TX_SEQ_NO");
        String MDL_TKN = "";

//        boolean succ = false;

        if ("T300".equals(RSLT_CD) && resJson.has("MDL_TKN")) {
            MDL_TKN = resJson.getString("MDL_TKN");
//            succ = true;
        }

        kcbClient.setCpCd(CP_CD);
        kcbClient.setResultCd(RSLT_CD);
        kcbClient.setResultMsg(RSLT_MSG);
        kcbClient.setMdlToken(MDL_TKN);
    }

    /**
     * 가상주민번호서비스 (IPIN) 요청 결과
     */
    public static void getIPinResult(KCBClient kcbClient) throws Exception {

        /**************************************************************************
         okcert3 요청 정보
         **************************************************************************/
        JSONObject reqJson = new JSONObject();
        reqJson.put("MDL_TKN", kcbClient.getMdlToken());
        String reqStr = reqJson.toString();

        /**************************************************************************
         okcert3 실행
         **************************************************************************/
        kcb.module.v3.OkCert okcert = new kcb.module.v3.OkCert();

        // '************ IBM JDK 사용 시, 주석 해제하여 호출 ************
        // okcert.setProtocol2type("22");
        // '객체 내 license를 리로드해야 될 경우에만 주석 해제하여 호출. (v1.1.7 이후 라이센스는 파일위치를 key로 하여 static HashMap으로 사용됨)
        // okcert.delLicense(license);

        String resultStr = okcert.callOkCert(KCB_TARGET, CP_CD, TIS_SVC_RESULT, TIS_LICENSE, reqStr);

        JSONObject resJson = new JSONObject(resultStr);

        String RSLT_CD = resJson.getString("RSLT_CD");
        String RSLT_MSG = resJson.getString("RSLT_MSG");
        String TX_SEQ_NO = resJson.getString("TX_SEQ_NO");

        String RETURN_MSG = "";
        if (resJson.has("RETURN_MSG")) RETURN_MSG = resJson.getString("RETURN_MSG");

        if ("T000".equals(RSLT_CD)) {
            kcbClient.setName(resJson.getString("RSLT_NAME"));
            kcbClient.setBirthDate(resJson.getString("RSLT_BIRTHDAY"));
            kcbClient.setGenderCode(resJson.getString("RSLT_SEX_CD"));
            kcbClient.setNationalInfo(resJson.getString("RSLT_NTV_FRNR_CD"));

            kcbClient.setDupInfo(resJson.getString("DI"));
            kcbClient.setCoInfo1(resJson.getString("CI"));
            kcbClient.setCoInfo2(resJson.getString("CI2"));
            kcbClient.setCiUpdate(resJson.getString("CI_UPDATE"));
            kcbClient.setVssn(resJson.getString("VSSN"));
        }

        kcbClient.setResultCd(RSLT_CD);
        kcbClient.setResultMsg(RSLT_MSG);
        kcbClient.setReturnMsg(RETURN_MSG);
        kcbClient.setTxSeqNo(TX_SEQ_NO);
    }
}
