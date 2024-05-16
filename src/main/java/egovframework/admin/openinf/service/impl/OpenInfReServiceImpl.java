package egovframework.admin.openinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;


import egovframework.admin.openinf.service.OpenInfRe;
import egovframework.admin.openinf.service.OpenInfReService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("OpenInfReService")
public class OpenInfReServiceImpl extends AbstractServiceImpl implements OpenInfReService {

    @Resource(name = "OpenInfReDAO")
    protected OpenInfReDAO openInfReDao;

    private static final Logger logger = Logger.getLogger(OpenInfReServiceImpl.class);

    @Override
    public List<OpenInfRe> openInfReListAll(OpenInfRe openInfRe) {
        List<OpenInfRe> result = new ArrayList<OpenInfRe>();
        try {
            result = openInfReDao.openInfReListAll(openInfRe);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }

    @Override
    public int updateOpenInfReCUD(ArrayList<OpenInfRe> list) {
        int result = 0;
        for (OpenInfRe openInfRe : list) {
            result = saveOpenInfReCUD(openInfRe);
        }
        return result;
    }

    //데이터 수정
    private int saveOpenInfReCUD(OpenInfRe openInfRe) {
        int result = 0;
        try {
            if (openInfRe.getStatus().equals("U")) {
                result += openInfReDao.updateOpenInfRe(openInfRe);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }
}