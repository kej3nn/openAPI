package egovframework.admin.basicinf.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsrSearch;
import egovframework.admin.basicinf.service.CommUsrSearchService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 직원정보 조회 ServiceImpl
 *
 * @author KJH
 * @since 2014.07.23
 */
@Service("CommUsrSearchService")
public class CommUsrSearchServiceImpl extends AbstractServiceImpl implements CommUsrSearchService {

    @Resource(name = "CommUsrSearchDAO")
    private CommUsrSearchDAO CommUsrSearchDAO;

    private static final Logger logger = Logger.getLogger(CommUsrSearchServiceImpl.class);

    /**
     * 조직 조회
     */
    public Map<String, Object> selectCommOrgSearchAllIbPaging(CommUsrSearch commUsrSearch) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommUsrSearch> result = CommUsrSearchDAO.orgList(commUsrSearch);
            map.put("resultList", result);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 직원 조회
     */
    public Map<String, Object> selectCommUsrSearchAllIbPaging(CommUsrSearch commUsrSearch) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommUsrSearch> result = CommUsrSearchDAO.usrList(commUsrSearch);
            map.put("resultList", result);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

}
