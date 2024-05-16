package egovframework.admin.nadata.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.nadata.service.NaAssmMemberUrlService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 관리자 - 국회의원 URL 관리 인터페이스 구현 클래스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/11/11
 */
@Service(value = "naAssmMemberUrlService")
public class NaAssmMemberUrlServiceImpl extends BaseService implements NaAssmMemberUrlService {

    @Resource(name = "naAssmMemberUrlDao")
    private NaAssmMemberUrlDao naAssmMemberUrlDao;

    /**
     * 데이터 조회 - 페이징
     */
    @Override
    public Paging searchNaAssmMemberUrl(Params params) {
        return (Paging) naAssmMemberUrlDao.searchNaAssmMemberUrl(params, params.getPage(), params.getRows());
    }

    /**
     * 데이터 수정
     */
    @Override
    public Result saveNaAssmMemberUrl(Params params) {
        try {
            Params[] data = params.getJsonArray(Params.SHEET_DATA);

            for (int i = 0; i < data.length; i++) {

                if (StringUtils.equals("U", data[i].getString("status"))) {
                    // URL 코드 중복체크
                    if (naAssmMemberUrlDao.selectDuplicateNaAssmMemberUrl(data[i]) > 0) {
                        throw new ServiceException("저장에 실패하였습니다. 중복되는 URL 코드가 있습니다.\\n[의원명 : " + data[i].getString("hgNm") + " / URL 코드 : " + data[i].getString("openNaId") + "]");
                    }
                    naAssmMemberUrlDao.saveNaAssmMemberUrl(data[i]);
                }
            }
        } catch (ServiceException e) {
            EgovWebUtil.exTransactionLogging(e);
            return failure("시스템 오류가 발생하였습니다.");
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
            return failure("시스템 오류가 발생하였습니다.");
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            return failure("시스템 오류가 발생하였습니다.");
        }
        return success(getMessage("admin.message.000004"));
    }
}
