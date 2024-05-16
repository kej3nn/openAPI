package egovframework.admin.bbs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin.bbs.service.BbsAdmin;
import egovframework.admin.bbs.service.BbsAdminService;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("BbsAdminService")
public class BbsAdminServiceImpl extends AbstractServiceImpl implements BbsAdminService {

    @Resource(name = "BbsAdminDao")
    private BbsAdminDao BbsAdminDao;

    @Override
    public List<BbsAdmin> bbsAdminListAll(BbsAdmin bbsAdmin) {
        return BbsAdminDao.bbsAdminListAll(bbsAdmin);
    }

    @Override
    public List<BbsAdmin> selectBbsAdminList(BbsAdmin bbsAdmin) {
        return BbsAdminDao.selectBbsAdminList(bbsAdmin);
    }

    @Override
    public int bbsAdminCodeCheck(BbsAdmin bbsAdmin) {
        return BbsAdminDao.bbsAdminCodeCheck(bbsAdmin);
    }

    @Override
    public int bbsAdminRegCUD(BbsAdmin bbsAdmin, String status) {
        int result = 0;
        if (WiseOpenConfig.STATUS_I.equals(status)) {
            result = BbsAdminDao.bbsAdminInsert(bbsAdmin);
        } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
            result = BbsAdminDao.bbsAdminUpdate(bbsAdmin);
        } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
            result = BbsAdminDao.deleteBbsAdmin(bbsAdmin);
            result = BbsAdminDao.deleteBbsList(bbsAdmin);
            result = BbsAdminDao.deleteBbsFile(bbsAdmin);
            result = BbsAdminDao.deleteBbsLink(bbsAdmin);
            result = BbsAdminDao.deleteBbsInf(bbsAdmin);
            result = 1; // 삭제 리턴값은 0임...
        } else {
            result = WiseOpenConfig.STATUS_ERR;
        }

        return result;
    }

}
