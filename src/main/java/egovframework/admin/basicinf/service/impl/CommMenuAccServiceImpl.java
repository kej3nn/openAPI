package egovframework.admin.basicinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommMenuAcc;
import egovframework.admin.basicinf.service.CommMenuAccService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("CommMenuAccService")
public class CommMenuAccServiceImpl extends AbstractServiceImpl implements CommMenuAccService {

    @Resource(name = "CommMenuAccDAO")
    private CommMenuAccDAO commMenuAccDAO;

    private static final Logger logger = Logger.getLogger(CommMenuAccServiceImpl.class);

    /**
     * 리스트 조회
     */
    @Override
    public Map<String, Object> selectMenuListIbPaging(CommMenuAcc commMenuAcc) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommMenuAcc> result = commMenuAccDAO.selectMenuList(commMenuAcc);
            int cnt = commMenuAccDAO.selectMenuListCnt(commMenuAcc);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 데이터 수정
     */
    @Override
    public int updateCommMenuAccCUD(ArrayList<CommMenuAcc> list) {
        int result = 0;

        for (CommMenuAcc saveVO : list) {
            try {
                result = saveCommMenuAccCUD(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }

        return result;
    }

    // 데이터 수정
    public int saveCommMenuAccCUD(@NonNull CommMenuAcc saveVO) {
        int result = 0;
        String status = StringUtils.defaultString(saveVO.getStatus());
        if (status.equals("I")) {
            //result += commMenuAccDAO.insertDsCol(saveVO);
        } else if (status.equals("U")) {
            try {
                result += commMenuAccDAO.updateCommMenuAcc(saveVO);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if (status.equals("D")) {
            //result += commMenuAccDAO.deleteCommMenuAcc(saveVO);
        } else {
        }

        return result;
    }
}
