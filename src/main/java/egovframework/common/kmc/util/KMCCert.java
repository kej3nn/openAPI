package egovframework.common.kmc.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

import org.apache.log4j.Logger;

import com.icert.comm.secu.IcertSecuManager;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.kmc.domain.KMCClient;

public class KMCCert {
    private static final Logger logger = Logger.getLogger(KMCCert.class);

    // KMC 로부터 부여받은 회원사 ID(8자리)
    private static final String CP_ID = EgovProperties.getProperty("KMC.cpId");
    // KMC 관리자 화면에서 등록하여 생성된 URL 별 코드(6자리)
    private static final String URL_CD = EgovProperties.getProperty("KMC.urlCd");
    // 데이터 복호화를 위한 확장필드(16자리)
    private static final String EXTEND_VAR = "0000000000000000";

    /**
     * CheckPlus(본인인증) 서비스 회원사 정보 전달
     */
    public static void getCheckPlusForm(KMCClient kmcClient) throws Exception {

        // 요청일시 생성
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String reqDateTime = sdf.format(today.getTime());

        Random ran = new Random();

        // 요청번호를 위한 랜덤 문자 길이
        int numLength = 6;
        StringBuilder randomStr = new StringBuilder();

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr.append(ran.nextInt(10));
        }

        // reqNum은 최대 40byte 까지 사용 가능
        String reqNum = reqDateTime + randomStr;

        ////////////////////////////////////////////////////////////////////////
        // KMC 요청 정보
        ////////////////////////////////////////////////////////////////////////
        kmcClient.setCpId(CP_ID);
        kmcClient.setUrlCode(URL_CD);
        kmcClient.setExtendVar(EXTEND_VAR);
        kmcClient.setCertNum(reqNum);
        kmcClient.setDate(reqDateTime);

        // 01. 한국모바일인증(주) 암호화 모듈 선언
        IcertSecuManager seed = new IcertSecuManager();

        // 02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
        String enc_tr_cert;
        String tr_cert = kmcClient.getCpId() + "/" + kmcClient.getUrlCode() + "/" + kmcClient.getCertNum() + "/" + kmcClient.getDate() + "/" + kmcClient.getCertMet() + "///////" + kmcClient.getPlusInfo() + "/" + kmcClient.getExtendVar();

        enc_tr_cert = seed.getEnc(tr_cert, "");

        // 03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
        String hmacMsg;

        hmacMsg = seed.getMsg(enc_tr_cert);

        // 04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
        tr_cert = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + kmcClient.getExtendVar(), "");
        kmcClient.setTr_cert(tr_cert);

        logger.debug("===============================================");
        logger.debug("Cert Request [" + kmcClient + "]");
        logger.debug("===============================================");
    }

    /**
     * CheckPlus(본인인증) 서비스 요청 결과
     */
    public static void getCheckPlusResult(KMCClient kmcClient) throws Exception {

        ////////////////////////////////////////////////////////////////////////
        // KMC 본인인증 요청 서비스 결과
        ////////////////////////////////////////////////////////////////////////
        logger.debug("===============================================");
        logger.debug("Cert Result rec_cert [" + kmcClient.getRec_cert() + "]");
        logger.debug("Cert Result certNum [" + kmcClient.getCertNum() + "]");
        logger.debug("===============================================");

        ////////////////////////////////////////////////////////////////////////
        // KMC 결과값 복호화
        ////////////////////////////////////////////////////////////////////////
        String rec_cert = kmcClient.getRec_cert();
        String k_certNum = kmcClient.getCertNum();

        String encPara;
        String encMsg1;
        String encMsg2;
        String msgChk = "N";

        // 01. 암호화 모듈 (jar) Loading
        IcertSecuManager seed = new IcertSecuManager();

        // 02. 1차 복호화
        rec_cert = seed.getDec(rec_cert, k_certNum);

        // 03. 1차 파싱
        int inf1 = rec_cert.indexOf("/", 0);
        int inf2 = rec_cert.indexOf("/", inf1 + 1);

        encPara = rec_cert.substring(0, inf1);  //암호화된 통합 파라미터
        encMsg1 = rec_cert.substring(inf1 + 1, inf2);   //암호화된 통합 파라미터의 Hash값

        // 04. 위변조 검증
        encMsg2 = seed.getMsg(encPara);

        if (encMsg2.equals(encMsg1)) {
            msgChk = "Y";
        }

        if (msgChk.equals("N")) {
            // 비정상적인 접근
        }

        // 05. 2차 복호화
        rec_cert = seed.getDec(encPara, k_certNum);

        // 06. 2차 파싱
        int info1 = rec_cert.indexOf("/", 0);
        int info2 = rec_cert.indexOf("/", info1 + 1);
        int info3 = rec_cert.indexOf("/", info2 + 1);
        int info4 = rec_cert.indexOf("/", info3 + 1);
        int info5 = rec_cert.indexOf("/", info4 + 1);
        int info6 = rec_cert.indexOf("/", info5 + 1);
        int info7 = rec_cert.indexOf("/", info6 + 1);
        int info8 = rec_cert.indexOf("/", info7 + 1);
        int info9 = rec_cert.indexOf("/", info8 + 1);
        int info10 = rec_cert.indexOf("/", info9 + 1);
        int info11 = rec_cert.indexOf("/", info10 + 1);
        int info12 = rec_cert.indexOf("/", info11 + 1);
        int info13 = rec_cert.indexOf("/", info12 + 1);
        int info14 = rec_cert.indexOf("/", info13 + 1);
        int info15 = rec_cert.indexOf("/", info14 + 1);
        int info16 = rec_cert.indexOf("/", info15 + 1);
        int info17 = rec_cert.indexOf("/", info16 + 1);
        int info18 = rec_cert.indexOf("/", info17 + 1);

        kmcClient.setCertNum(rec_cert.substring(0, info1));
        kmcClient.setDate(rec_cert.substring(info1 + 1, info2));
        kmcClient.setCI(rec_cert.substring(info2 + 1, info3));
        kmcClient.setPhoneNo(rec_cert.substring(info3 + 1, info4));
        kmcClient.setPhoneCorp(rec_cert.substring(info4 + 1, info5));
        kmcClient.setBirthDay(rec_cert.substring(info5 + 1, info6));
        kmcClient.setGender(rec_cert.substring(info6 + 1, info7));
        kmcClient.setNation(rec_cert.substring(info7 + 1, info8));
        kmcClient.setName(rec_cert.substring(info8 + 1, info9));
        kmcClient.setResult(rec_cert.substring(info9 + 1, info10));
        kmcClient.setCertMet(rec_cert.substring(info10 + 1, info11));
        kmcClient.setIp(rec_cert.substring(info11 + 1, info12));
        kmcClient.setM_name(rec_cert.substring(info12 + 1, info13));
        kmcClient.setM_birthDay(rec_cert.substring(info13 + 1, info14));
        kmcClient.setM_Gender(rec_cert.substring(info14 + 1, info15));
        kmcClient.setM_nation(rec_cert.substring(info15 + 1, info16));
        kmcClient.setPlusInfo(rec_cert.substring(info16 + 1, info17));
        kmcClient.setDI(rec_cert.substring(info17 + 1, info18));

        //07. CI, DI 복호화
        kmcClient.setCI(seed.getDec(kmcClient.getCI(), k_certNum));
        kmcClient.setDI(seed.getDec(kmcClient.getDI(), k_certNum));

        logger.debug("===============================================");
        logger.debug("Cert Result [" + kmcClient + "]");
        logger.debug("===============================================");
    }
}
