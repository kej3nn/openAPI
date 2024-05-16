package egovframework.admin.expose.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.expose.service.AdminNasSendInfoService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

/**
 * (관리자) 정보공개청구 처리에 따른 메일, SMS 등의 발송을 관리하는 서비스
 *
 * @author SoftOn
 * @version 1.0
 * @since 2019/07/29
 */

@Service(value = "adminNasSendInfoService")
public class AdminNasSendInfoServiceImpl extends BaseService implements AdminNasSendInfoService {

    @Resource(name = "adminNasSendInfoDao")
    protected AdminNasSendInfoDao adminNasSendInfoDao;

    /**
     * 정보공개청구 처리사항을 청구인에게 SMS/메일 발송
     * 접수, 이송, 취하, 연장, 종결, 이송통지
     * 결정통지, 공개실시(자료등록)
     * 오프라인 이의신청,
     *
     * @param params 파라메터
     * @return
     * @return 처리결과
     */
    @SuppressWarnings("unchecked")
    public boolean exposeProcSend(HttpServletRequest request, Params params) {
        boolean result = false;
        String aNm = params.getString("typeNm");
        int num = params.getInt("typeNum");
        String inst_cd = "";
        String inst_nm = "";
        String apl_dt = "";

        /* 청구서 번호 apl_no 값으로 청구정보를 호출하여 사용한다. usrId */
        String apl_no = params.getString("aplNo");

        //청구 정보 조회
        List<Record> opnzAplList = (List<Record>) adminNasSendInfoDao.getOpnzAplInfo(apl_no);

        if (num != 99) {
            inst_cd = opnzAplList.get(0).getString("APL_DEAL_INST_CD");
            inst_nm = opnzAplList.get(0).getString("APL_DEAL_INST_NM");
        } else {
            inst_cd = params.getString("instCd");
            inst_nm = params.getString("instNm");
        }
        if (num != 22 && num != 23) {
            apl_dt = opnzAplList.get(0).getString("APL_DT");
        } else {
            apl_dt = params.getString("objtnDt").replaceAll("-", "");
        }
        String dest_phone = opnzAplList.get(0).getString("APL_MBL_PNO");
        String dest_name = opnzAplList.get(0).getString("APL_PN");
        String mailto = opnzAplList.get(0).getString("APL_EMAIL_ADDR");
        String aplSj = opnzAplList.get(0).getString("APL_SJ");
        //청구 정보에서 SMS Email 수신여부
        //String dcs_ntc_rcvmth = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_CD");
        //청구 정보에서 SMS/메일/알림톡 수신여부 확인
        String dcs_ntc_rcvmth_sms = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_SMS");
        String dcs_ntc_rcvmth_mail = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_MAIL");
        String dcs_ntc_rcvmth_talk = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_TALK");

        //이의신청 결정기한 연장
        String dcsprodEtDt = "";

        String msg1 = "";
        String msg2 = "";
        String dcsMsg = "";

        if (num == 18) { //이의신청
            msg2 = "건으로 요청하신 이의신청서가 신청되었습니다.";
        } else if (num == 0) { //결정통지 일 경우
            String opb_yn = params.getString("opb_yn");
            String opbNm = "";

            if ("0".equals(opb_yn)) opbNm = "공개";
            else if ("1".equals(opb_yn)) opbNm = "부분공개";
            else if ("2".equals(opb_yn)) opbNm = "비공개";
            else if ("3".equals(opb_yn)) opbNm = "부존재 등";

            dcsMsg = getOpnDcsRegParam(params);
            msg2 = "건으로 신청하신 정보공개청구에 대한 " + opbNm + " 결정이 통지되었습니다." + dcsMsg;

        } else if (num == 99 || num == 17) { //이송 or 접수
            msg2 = "건으로 신청하신 정보공개청구서가 <" + inst_nm + ">에 " + aNm + " 되었습니다.";
        } else if (num == 15) { //공개실시
            msg2 = "건으로 신청하신 정보공개 청구에 대한 답변자료가 열린국회정보포털에 등록 되었습니다. 등록된 자료는 정보공개 청구 > 청구서처리현황에서 확인하실 수 있습니다.";

        } else if (num == 20) { //이의신청 취하
            msg2 = "건으로 신청하신 이의신청서가 취하 되었습니다.";
        } else if (num == 19) { //이의신청 접수
            msg2 = " 정보공개 청구 건(비공개 결정)에 대해 신청하신 이의신청서가 접수되었습니다.";
        } else if (num == 21) { //이의신청 결정기한 연장
            dcsprodEtDt = params.getString("dcsprodEtDt");

            dcsprodEtDt = dcsprodEtDt.substring(0, 4) + "년 " + dcsprodEtDt.substring(4, 6) + "월 " + dcsprodEtDt.substring(6, 8) + "일";

            msg2 = "건으로 신청하신 이의신청의 결정기한이 " + dcsprodEtDt + "로 연장되었습니다.";
        } else if (num == 22) { //이의신청 결과 등록
            String feeSum = params.getString("fee_sum");
            String objtnDealRslt = params.getString("objtn_deal_rslt");
            String objtnDealRsltNm = "";
            String feeMsg = "";
            //기관 정보 조회
            List<Record> opnzInstList = (List<Record>) adminNasSendInfoDao.getOpnzInstInfo(inst_cd);

            if (feeSum.equals("")) feeSum = "0";

            if ("02".equals(objtnDealRslt) || "03".equals(objtnDealRslt)) { //각하 or 기각
                if ("02".equals(objtnDealRslt)) objtnDealRsltNm = "각하가";
                else objtnDealRsltNm = "기각이";
                msg2 = "건으로 신청하신 이의신청에 대한 " + objtnDealRsltNm + " 결정되었습니다.";
            } else {
                if ("04".equals(objtnDealRslt)) objtnDealRsltNm = "인용";
                else objtnDealRsltNm = "부분인용";

                if ("9710000".equals(inst_cd) && !"0".equals(feeSum)) {  //사무처만  이체정보 필요 , 0원이면 수수료만
                    if ("04".equals(objtnDealRslt) || "05".equals(objtnDealRslt)) {  //인용 or 부분인용
                        feeMsg = " 수수료" + feeSum + "원을  " + opnzInstList.get(0).getString("INST_BK_NM") + " " + opnzInstList.get(0).getString("INST_ACC_NO") + " (예금주: " + opnzInstList.get(0).getString("INST_ACC_NM") + ")로 입금하여 주시기 바랍니다.";
                    } else {
                        feeMsg = " 수수료는 " + feeSum + "원입니다.";
                    }
                } else {
                    feeMsg = " 수수료는 " + feeSum + "원입니다.";
                }
                msg2 = "건으로 신청하신 이의신청에 대한 " + objtnDealRsltNm + " 결정이 통지되었습니다." + feeMsg;
            }
        } else if (num == 23) { //이의신청 공개
            String objtnDealRsltNm = params.getString("objtnDealRsltNm");
            msg2 = "건으로 신청하신 이의신청에 대한 " + objtnDealRsltNm + "이 결정되었습니다.";
        } else {
            msg2 = "건으로 신청하신 정보공개청구서가 " + aNm + " 되었습니다.";
        }
        String mailtitle = "<" + inst_nm + "> " + "정보공개 " + aNm + " 안내입니다.";


        try {

            //기관 정보 조회
            //List<Record> opnzInstList = (List<Record>) adminNasSendInfoDao.getOpnzInstInfo(inst_cd);

            //기관 담당자 정보 조회
            List<Record> opnUsrRelList = (List<Record>) adminNasSendInfoDao.getOpnUsrRelInfo(inst_cd);
            if (opnUsrRelList.size() > 0) {
                //String mailfrom = opnUsrRelList.get(0).getString("USR_EMAIL"); //발송 메일 주소
                //String sendPno = opnzInstList.get(0).getString("INST_PNO"); // SMS 발송 번호

                String mailfrom = EgovProperties.getProperty("Globals.mailFrom"); // 발송 메일주소 (open_master@assembly.go.kr)

                /* 청구인에게 메세지를 보낼 경우 START */

                // 메시지 내용 작성
                String apl_pn = dest_name + " 님이";
                apl_dt = apl_dt.substring(0, 4) + "년 " + apl_dt.substring(4, 6) + "월 " + apl_dt.substring(6, 8) + "일";
                msg1 = apl_pn + " " + apl_dt;

                //기간연장(11)이 아닐경우
//				if(num != 11 && num != 18 && num != 19 && num != 21 && num != 22 && num != 23){
//					msg2 = " '"+aplSj+"'"+msg2;
//				}else if(num ==11){	
//					//기간연장은 정보공개결정 정보를 조회한다.
//					//정보공개결정 정보 조회
//					List<Record> opnzDcsList = (List<Record>) adminNasSendInfoDao.getOpnzDcsInfo(apl_no);
//					String dcsProdEtDt = opnzDcsList.get(0).getString("DCS_PROD_ET_DT");
//					dcsProdEtDt = dcsProdEtDt.substring(0, 4)+"년"+dcsProdEtDt.substring(4, 6)+"월"+dcsProdEtDt.substring(6, 8)+"일";
//					msg2 = "건으로 신청하신 정보공개청구서의 정보공개여부 결정기한이 "+dcsProdEtDt+"까지 "+aNm+" 되었습니다.";
//				}			

                if (num == 11) {
                    //기간연장은 정보공개결정 정보를 조회한다.
                    //정보공개결정 정보 조회
                    List<Record> opnzDcsList = (List<Record>) adminNasSendInfoDao.getOpnzDcsInfo(apl_no);
                    String dcsProdEtDt = opnzDcsList.get(0).getString("DCS_PROD_ET_DT");
                    dcsProdEtDt = dcsProdEtDt.substring(0, 4) + "년 " + dcsProdEtDt.substring(4, 6) + "월 " + dcsProdEtDt.substring(6, 8) + "일";
                    msg2 = "건으로 신청하신 정보공개청구서의 정보공개여부 결정기한이 " + dcsProdEtDt + "까지 " + aNm + " 되었습니다.";
                }

                msg2 = " '" + aplSj + "'" + msg2;

                String msg_body = msg1 + msg2;

                params.put("dest_phone", dest_phone); // SMS 수신번호
                //params.put("send_phone", sendPno); // SMS 발송번호
                params.put("msg_body", msg_body);
                params.put("msgType", "5"); // 메시지 타입 (MMS)
                params.put("subject", "정보공개안내 SMS");
                params.put("subjectKakao", "정보공개안내 알림톡");
                params.put("dest_name", dest_name);
                params.put("send_name", inst_nm);

                params.put("mailto", "\"" + dest_name + "\"<" + mailto + ">");    // 메일 수신 주소
                params.put("mailfrom", "\"" + inst_nm + "\"<" + mailfrom + ">"); //메일 발송 주소
                params.put("mailtitle", mailtitle);                                    // 메일 제목
                params.put("mailqry", "SSV:" + mailto + "," + dest_name);

                //카카오 알림톡 기본변수
//				params.put("send_phone", EgovProperties.getProperty("KakaoBizTalk.sendPhone"));
                params.put("send_phone", opnUsrRelList.get(0).getString("USR_PNO"));    // 기관별 대표자번호로 변경
                params.put("senderKey", EgovProperties.getProperty("KakaoBizTalk.senderKey"));
                params.put("templateCode", EgovProperties.getProperty("KakaoBizTalk.templateCode"));

                // 로컬 테스트시 담당자에게 문자 안날라가게
                //			if(request.getRequestURL().substring(0,16).equals("http://localhost")){
                //				params.put("dest_phone", "01052671720"); // SMS ,
                //			}

                if (dcs_ntc_rcvmth_sms.equals("Y"))
                    adminNasSendInfoDao.insertSMSRow(params); //SMS는 DB내 UDS_MSG테이블에 저장되어 발송됨
                if (dcs_ntc_rcvmth_mail.equals("Y"))
                    adminNasSendInfoDao.insertIMailRow(params); //i-Mailer를 통한 메일발송 DB 테이블에 저장되어 발송 됨
                if (dcs_ntc_rcvmth_talk.equals("Y"))
                    adminNasSendInfoDao.insertTalkRow(params); //카카오알림톡은 DB내 BIZ_MSG테이블에 저장되어 발송됨

                /* 청구인에게 메세지를 보낼 경우 END */

                /* 이송은 기관담당자에게 SMS 발송 */
                if (num == 99) {
                    params.put("dest_phone", opnUsrRelList.get(0).getString("USR_MBL_PNO")); /* 이송기관담당자 */
                    //params.put("send_phone", opnzInstList.get(0).getString("INST_PNO"));
                    params.put("msg_body", msg_body);
                    params.put("dest_name", opnUsrRelList.get(0).getString("USR_NM"));
                    params.put("send_name", inst_nm);

                    // 로컬 테스트시 담당자에게 문자 안날라가게
                    //				if(request.getRequestURL().substring(0,16).equals("http://localhost")){
                    //					params.put("dest_phone", "01052671720"); // SMS ,
                    //				}

                    adminNasSendInfoDao.insertSMSRow(params); //SMS는 DB내 UDS_MSG테이블에 저장되어 발송됨
                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        }

        return result;
    }

    /**
     * 정보공개청구 결정통지 발송내용 설정
     *
     * @param params
     */
    @SuppressWarnings("unchecked")
    private String getOpnDcsRegParam(Params params) {

        /* 청구서 번호 apl_no 값으로 청구정보를 호출하여 사용한다. usrId */
        String apl_no = params.getString("apl_no");

        //청구 정보 조회
        List<Record> opnzAplList = (List<Record>) adminNasSendInfoDao.getOpnzAplInfo(apl_no);
        String inst_cd = opnzAplList.get(0).getString("APL_DEAL_INST_CD");
        String dcsMsg = "";

        try {

            //기관 정보 조회
            List<Record> opnzInstList = (List<Record>) adminNasSendInfoDao.getOpnzInstInfo(inst_cd);

            String fee_sum = params.getString("fee_sum");
            String opb_yn = params.getString("opb_yn");
            if (fee_sum.equals("")) fee_sum = "0";

            if ("9710000".equals(inst_cd) && !"0".equals(fee_sum)) {  //사무처만  이체정보 필요 , 0원이면 수수료만
                if ("0".equals(opb_yn) || "1".equals(opb_yn)) {  //공개 or 부분공개
                    dcsMsg = " 수수료" + fee_sum + "원을  " + opnzInstList.get(0).getString("INST_BK_NM") + " " + opnzInstList.get(0).getString("INST_ACC_NO") + " (예금주: " + opnzInstList.get(0).getString("INST_ACC_NM") + ")로 입금하여 주시기 바랍니다.";
                } else {  //부분공개  or 부존재 등
                    dcsMsg = "";
                }
            } else {
                if ("0".equals(opb_yn) || "1".equals(opb_yn)) {  //공개 or 부분공개
                    dcsMsg = "수수료는 " + fee_sum + "원입니다.";
                } else {  //비공개 or 부존재 등
                    dcsMsg = "";
                }
            }


            return dcsMsg;

        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        }

    }


    /**
     * 정보공개청구 처리사항을 청구인에게 SMS/메일 발송
     * 취소처리 > 결정통지취소, 통지완료취소
     *
     * @param params 파라메터
     * @return 처리결과
     */
    @SuppressWarnings("unchecked")
    public void cancelProcSend(HttpServletRequest request, Params params) {
        boolean result = false;

        /* 청구서 번호 apl_no 값으로 청구정보를 호출하여 사용한다. usrId */
        String apl_no = params.getString("aplNo");

        //청구 정보 조회
        List<Record> opnzAplList = (List<Record>) adminNasSendInfoDao.getOpnzAplInfo(apl_no);

        String inst_cd = opnzAplList.get(0).getString("APL_DEAL_INST_CD");
        String inst_nm = opnzAplList.get(0).getString("APL_DEAL_INST_NM");
        String apl_dt = opnzAplList.get(0).getString("APL_DT");
        String dest_phone = opnzAplList.get(0).getString("APL_MBL_PNO");
        String dest_name = opnzAplList.get(0).getString("APL_PN");
        String mailto = opnzAplList.get(0).getString("APL_EMAIL_ADDR");
        String aplSj = opnzAplList.get(0).getString("APL_SJ");
        //청구 정보에서 SMS Email 수신여부
        //String dcs_ntc_rcvmth = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_CD");
        //청구 정보에서 SMS/메일/알림톡 수신여부 확인
        String dcs_ntc_rcvmth_sms = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_SMS");
        String dcs_ntc_rcvmth_mail = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_MAIL");
        String dcs_ntc_rcvmth_talk = opnzAplList.get(0).getString("DCS_NTC_RCV_MTH_TALK");

        String aNm = params.getString("typeNm");
        //int num = params.getInt("typeNum");
        String msg1 = "";
        String msg2 = "건으로 신청하신 정보공개청구서가 " + aNm + " 되었습니다.";

        String mailtitle = "<" + inst_nm + "> " + "정보공개 " + aNm + " 안내입니다.";

        try {

            //기관 정보 조회
            //List<Record> opnzInstList = (List<Record>) adminNasSendInfoDao.getOpnzInstInfo(inst_cd);

            //기관 담당자 정보 조회
            List<Record> opnUsrRelList = (List<Record>) adminNasSendInfoDao.getOpnUsrRelInfo(inst_cd);
            if (opnUsrRelList.size() > 0) {
                //String mailfrom = opnUsrRelList.get(0).getString("USR_EMAIL"); //발송 메일 주소
                //String sendPno = opnzInstList.get(0).getString("INST_PNO"); // SMS 발송 번호
                String mailfrom = EgovProperties.getProperty("Globals.mailFrom"); // 발송 메일주소 (open_master@assembly.go.kr)

                /* 청구인에게 메세지를 보낼 경우 START */

                // 메시지 내용 작성
                String apl_pn = dest_name + " 님이";
                apl_dt = apl_dt.substring(0, 4) + "년 " + apl_dt.substring(4, 6) + "월 " + apl_dt.substring(6, 8) + "일";
                msg1 = apl_pn + " " + apl_dt;
                msg2 = " '" + aplSj + "' " + msg2;
                String msg_body = msg1 + msg2;

                params.put("dest_phone", dest_phone); // SMS 수신번호
                //params.put("send_phone", sendPno); // SMS 발송번호
                params.put("msg_body", msg_body);
                params.put("msgType", "5"); // 메시지 타입 (MMS)
                params.put("subject", "정보공개안내 SMS");
                params.put("subjectKakao", "정보공개안내 알림톡");
                params.put("dest_name", dest_name);
                params.put("send_name", inst_nm);

                params.put("mailto", "\"" + dest_name + "\"<" + mailto + ">");    // 메일 수신 주소
                params.put("mailfrom", "\"" + inst_nm + "\"<" + mailfrom + ">"); //메일 발송 주소
                params.put("mailtitle", mailtitle);                                    // 메일 제목
                params.put("mailqry", "SSV:" + mailto + "," + dest_name);

                //카카오 알림톡 기본변수
//				params.put("send_phone", EgovProperties.getProperty("KakaoBizTalk.sendPhone"));
                params.put("send_phone", opnUsrRelList.get(0).getString("USR_PNO"));    // 기관별 대표자번호로 변경
                params.put("senderKey", EgovProperties.getProperty("KakaoBizTalk.senderKey"));
                params.put("templateCode", EgovProperties.getProperty("KakaoBizTalk.templateCode"));

                // 로컬 테스트시 담당자에게 문자 안날라가게
                if (request.getRequestURL().substring(0, 16).equals("http://localhost")) {
                    params.put("dest_phone", "01052671720"); // SMS ,
                }

                if (dcs_ntc_rcvmth_sms.equals("Y"))
                    adminNasSendInfoDao.insertSMSRow(params); //SMS는 DB내 UDS_MSG테이블에 저장되어 발송됨
                if (dcs_ntc_rcvmth_mail.equals("Y"))
                    adminNasSendInfoDao.insertIMailRow(params); //i-Mailer를 통한 메일발송 DB 테이블에 저장되어 발송 됨
                if (dcs_ntc_rcvmth_talk.equals("Y"))
                    adminNasSendInfoDao.insertTalkRow(params); //카카오알림톡은 DB내 BIZ_MSG테이블에 저장되어 발송됨


                /* 청구인에게 메세지를 보낼 경우 END */

                /* 이송은 기관담당자에게 SMS 발송 */
                if (params.getString("B1").equals("Y")) {
                    params.put("dest_phone", opnUsrRelList.get(0).getString("USR_MBL_PNO")); /* 이송기관담당자 */
                    //params.put("send_phone", opnzInstList.get(0).getString("INST_PNO"));
                    params.put("msg_body", msg_body);
                    params.put("dest_name", opnUsrRelList.get(0).getString("USR_NM"));
                    params.put("send_name", inst_nm);

                    // 로컬 테스트시 담당자에게 문자 안날라가게
                    if (request.getRequestURL().substring(0, 16).equals("http://localhost")) {
                        params.put("dest_phone", "01052671720"); // SMS ,
                    }

                    adminNasSendInfoDao.insertSMSRow(params); //SMS는 DB내 UDS_MSG테이블에 저장되어 발송됨
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        }

    }

}
