package egovframework.admin.monitor.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface MailSendMonitorService {
    /**
     * 메일전송 모니터링 페이징 리스트 조회
     *
     * @param params
     * @return
     */
    public Paging selectMailMonitorListPaging(Params params);

    /**
     * 메세지를 재전송 한다.
     *
     * @param params
     * @return
     */
    public Result insertMailReSend(Params params);
}
