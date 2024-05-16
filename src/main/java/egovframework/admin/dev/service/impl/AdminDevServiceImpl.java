package egovframework.admin.dev.service.impl;

import java.util.ArrayList;
import java.util.Arrays;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.dev.service.AdminDevService;
import egovframework.admin.expose.service.impl.AdminNasSendInfoDao;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

@Service(value = "adminDevService")
public class AdminDevServiceImpl extends BaseService implements AdminDevService {

    @Resource(name = "adminDevDao")
    protected AdminDevDao adminDevDao;

    @Resource(name = "adminNasSendInfoDao")
    protected AdminNasSendInfoDao adminNasSendInfoDao;

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectDevMngListPaging(Params params) {

        Paging list = adminDevDao.selectDevMngList(params, params.getPage(), params.getRows());

        return list;

    }

    /**
     * 메일, 카카오톡,sms 전송
     */
    @Override
    public Result insertDevReceive(Params params) {
        boolean result = false;

        //사용자 정보 조회
        ArrayList<String> iterUserId = new ArrayList<String>(Arrays.asList(params.getStringArray("userId")));


        if (!iterUserId.isEmpty()) {
            params.put("iterUserId", iterUserId);
        } else {
            // 단건 등록
            iterUserId.add(params.getString("userId"));
            params.put("iterUserId", iterUserId);
        }

        Record userDevInfo = new Record();
        String dvpHpYn = "";
        String dvpEmailYn = "";
        String dvpKakaoYn = "";
        String userHp = "";
        String mailto = "";
        String dest_name = "";
        String mailfrom = EgovProperties.getProperty("Globals.galleryMailFrom"); // 발송 메일주소 (open_master@assembly.go.kr)
        String inst_nm = "열린국회정보포털";

        String aNm = params.getString("typeNm");
        String mailtitle = "<" + inst_nm + "> " + "활용사례 관련 안내입니다.";

        try {
            for (String userId : iterUserId) {
                params.set("userId", userId);
                userDevInfo = (Record) adminDevDao.selectUserDevInfo(params);
                //사용자 정보에서 SMS/메일/알림톡 수신여부 확인
                dvpHpYn = userDevInfo.getString("dvpHpYn");
                dvpEmailYn = userDevInfo.getString("dvpEmailYn");
                dvpKakaoYn = userDevInfo.getString("dvpKakaoYn");
                userHp = userDevInfo.getString("userHp");
                mailto = userDevInfo.getString("userEmail");
                dest_name = userDevInfo.getString("userNm");

                // 메시지 내용 작성
                params.put("dest_phone", userHp); // SMS 수신번호
                params.put("msgType", "5"); // 메시지 타입 (MMS)
                params.put("subject", "활용사례");
                params.put("subjectKakao", "활용사례 알림톡");
                params.put("dest_name", dest_name);
                params.put("send_name", "열린국회정보포털 관리자");

                params.put("mailto", "\"" + dest_name + "\"<" + mailto + ">");    // 메일 수신 주소
                params.put("mailfrom", "\"" + inst_nm + "\"<" + mailfrom + ">"); //메일 발송 주소
                params.put("mailtitle", mailtitle);                                    // 메일 제목
                params.put("mailqry", "SSV:" + mailto + "," + dest_name);

                //카카오 알림톡 기본변수
                params.put("senderKey", EgovProperties.getProperty("KakaoBizTalk.gallerySenderKey"));
                params.put("templateCode", EgovProperties.getProperty("KakaoBizTalk.galleryTemplateCode"));
                /* 메세지를 보낼 경우 END */
                if (params.getString("hpSendYn").equals("Y")) {
                    if (dvpHpYn.equals("Y")) {
                    	adminDevDao.insertSMSRow(params); //SMS는 DB내 UDS_MSG테이블에 저장되어 발송됨
                        result = true;
                    }

                } else if (params.getString("kakaoSendYn").equals("Y")) {
                    if (dvpKakaoYn.equals("Y")) { 
	                    adminDevDao.insertTalkRow(params); //카카오알림톡은 DB내 BIZ_MSG테이블에 저장되어 발송됨
	                    result = true;
                    }

                } else if (params.getString("emailSendYn").equals("Y")) {
                    if (dvpEmailYn.equals("Y")) {
                        adminDevDao.insertIMailRow(params); //i-Mailer를 통한 메일발송 DB 테이블에 저장되어 발송 됨
                        result = true;
                    }
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        }

        if (result) {
            return success("전송 되었습니다."); //처리가 완료되었습니다
        } else {
            return failure("전송에 실패했습니다."); //저장에 실패하였습니다.
        }

    }

}
