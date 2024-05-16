package egovframework.admin.openinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.admin.openinf.service.OpenMetaOrderService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 분류정보 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

@Service("OpenMetaOrderService")
public class OpenMetaOrderServiceImpl extends AbstractServiceImpl implements OpenMetaOrderService {

    @Resource(name = "OpenMetaOrderDAO")
    protected OpenMetaOrderDAO openMetaOrderDAO;

    private static final Logger logger = Logger.getLogger(OpenMetaOrderServiceImpl.class);


    public Map<String, Object> selectOpenMetaOrderPageListAllMainTreeIbPaging(OpenMetaOrder openMetaOrder) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<OpenMetaOrder> result = openMetaOrderDAO.selectOpenMetaOrderListAllMainTree(openMetaOrder);
            int cnt = result.size();
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public int openMetaOrderBySave(ArrayList<OpenMetaOrder> list) {
        int result = 0;
        try {
            for (OpenMetaOrder openMetaOrder : list) {
                result += openMetaOrderDAO.updateOrderby(openMetaOrder);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }


}