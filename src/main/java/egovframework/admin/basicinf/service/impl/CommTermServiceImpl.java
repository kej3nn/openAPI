package egovframework.admin.basicinf.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommTermService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import lombok.NonNull;

/**
 * 관리자 - 동의어 관리 서비스 구현 클래스
 *
 * @author JHKIM
 * @version 1.0
 * @since 2019/11/12
 */
@Service(value = "commTermService")
public class CommTermServiceImpl extends BaseService implements CommTermService {

    @Resource(name = "commTermDao")
    private CommTermDao commTermDao;

    /**
     * 데이터를 조회한다. - 페이징
     */
    @Override
    public Paging searchCommTerm(@NonNull Params params) {
        return commTermDao.searchCommTerm(params, params.getPage(), params.getRows());
    }

    /**
     * 데이터를 조회한다.
     */
    @Override
    public List<Record> selectCommTerm(Params params) {
        return commTermDao.selectCommTerm(params);
    }

    /**
     * 데이터를 저장한다. (CUD)
     */
    @Override
    public Result saveCommTerm(@NonNull Params params) {
        try {

            Params[] data = params.getJsonArray(Params.SHEET_DATA);

            for (int i = 0; i < data.length; i++) {

                if (StringUtils.equals("I", data[i].getString("status"))) {
                    if (commTermDao.selectCommTermDup(data[i]) > 0) {
                        throw new ServiceException("저장에 실패하였습니다.\n중복되는 용어가 있습니다.\n[용어 : " + data[i].getString("termNm") + " / 연결용어명 : " + data[i].getString("relTermNm") + "]");
                    }
                    commTermDao.insertCommTerm(data[i]);
                } else if (StringUtils.equals("U", data[i].getString("status"))) {
                    if (commTermDao.selectCommTermDup(data[i]) > 0) {
                        throw new ServiceException("저장에 실패하였습니다.\n중복되는 용어가 있습니다.\n[용어 : " + data[i].getString("termNm") + " / 연결용어명 : " + data[i].getString("relTermNm") + "]");
                    }
                    commTermDao.updateCommTerm(data[i]);
                } else if (StringUtils.equals("D", data[i].getString("status"))) {
                    commTermDao.deleteCommTerm(data[i]);
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            return failure("시스템 오류가 발생하였습니다.");
        }
        return success(getMessage("admin.message.000004"));
    }

}
