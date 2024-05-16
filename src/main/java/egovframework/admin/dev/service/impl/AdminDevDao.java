package egovframework.admin.dev.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "adminDevDao")
public class AdminDevDao extends BaseDao {

    public Paging selectDevMngList(Params params, int page, int rows) {
        return search("AdminDevMngDao.selectDevMngList", params, page, rows, PAGING_SCROLL);
    }

    public Record selectUserDevInfo(Params params) {
        return (Record) select("AdminDevMngDao.selectUserDevInfo", params);
    }

    /**
     * SMS발송정보를 등록한다.
     */
    public Object insertSMSRow(Params params) {
        return insert("AdminDevMngDao.insertSMSRow", params);
    }

    /**
     * i-Mailer발송정보를 등록한다.
     */
    public void insertIMailRow(Params params) {

        // 메일 템플릿 적용

        String mailBody = "<div style=\"background:#f3f4f7;text-align:center;padding:22px 22px 10px 22px;max-width:600px;\">" +
                "<a href=\"https://open.assembly.go.kr\" target=\"new\"><img src=\"https://open.assembly.go.kr/images/bg_logo.png\"></a>" +
                "<div style=\"padding:20px;background:#ffffff;border:1px solid #bdd0e1;border-radius:15px;-webkit-border-radius:15px;-moz-border-radius:15px;-o-border-radius:15px;text-align:left;margin:14px 0 0 0;\">" +
                "<div style=\"font-family:Malgun Gothic;font-size:14px;margin:5px 0 26px 0;letter-spacing:-1px;line-height:1.5;\">" + params.getString("msg_body") + "</div>" +
                "<div style=\"font-family:Malgun Gothic;font-size:14px;color:#666666;letter-spacing:-1px;line-height:1.3;\">※ 문의사항 : <span style=\"letter-spacing:0;\">02-788-2064</span></div>" +
                "</div>" +
                "<div>" +
                "<div style=\"text-align:center;margin:50px 0 0 0;\">" +
                "<a href=\"https://open.assembly.go.kr\" target=\"new\" style=\"display:inline-block;color:#ffffff;background:#085799;font-family:Malgun Gothic;font-size:14px;text-decoration:none;border-radius:32px;padding:6px 20px;letter-spacing:-1px;\">사이트 바로가기</a>" +
                "</div>" +
                "<div style=\"text-align:center;line-height:1.3;font-family:Malgun Gothic;font-size:13px;color:#666666;letter-spacing:-1px;margin-top:27px;\">서울시 영등포구 의사당대로1 (여의도동) 07233</div>" +
                "</div>" +
                "</div>";

        params.put("mailBody", mailBody);
        insert("AdminDevMngDao.insertIMailRow", params);
    }

    /**
     * 카카오알림톡 발송정보를 등록한다.
     */
    public void insertTalkRow(Params params) {
        insert("AdminDevMngDao.insertTalkRow", params);
    }
}
