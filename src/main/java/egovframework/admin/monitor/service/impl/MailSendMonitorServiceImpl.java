package egovframework.admin.monitor.service.impl;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.MailSendMonitorService;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

@Service(value = "mailSendMonitorService")
public class MailSendMonitorServiceImpl extends BaseService implements MailSendMonitorService {

    @Resource(name = "mailSendMonitorDao")
    protected MailSendMonitorDao mailSendMonitorDao;

    /**
     * 메일전송 모니터링 페이징 리스트 조회
     */
    @Override
    public Paging selectMailMonitorListPaging(Params params) {

        Paging list = mailSendMonitorDao.selectMailMonitorList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 메세지를 재전송 한다.
     */
    @Override
    public Result insertMailReSend(Params params) {
        if (StringUtils.isNotEmpty(params.getString("seqidx"))) {
            //메일 내용은 소스에서 처리 (LONG타입)
            params.put("mailBody", mailSendMonitorDao.selectMailContent(params).getString("content"));

            mailSendMonitorDao.insertMailReSend(params);
        }
        return success(getMessage("admin.message.000006"));
    }

}
