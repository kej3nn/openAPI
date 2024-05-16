package egovframework.admin.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.admin.bbs.service.BbsAdmin;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("BbsAdminDao")
public class BbsAdminDao extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<BbsAdmin> bbsAdminListAll(BbsAdmin bbsAdmin) {
        return (List<BbsAdmin>) list("BbsAdminDao.selectbbsAdminAll", bbsAdmin);
    }

    @SuppressWarnings("unchecked")
    public List<BbsAdmin> selectBbsAdminList(BbsAdmin bbsAdmin) {
        return (List<BbsAdmin>) list("BbsAdminDao.selectBbsAdminList", bbsAdmin);
    }

    public int bbsAdminCodeCheck(BbsAdmin bbsAdmin) {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsAdminDao.selectCodeDup", bbsAdmin);
    }

    public int bbsAdminInsert(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.insertBbsAdmin", bbsAdmin);
    }

    public int bbsAdminUpdate(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.updateBbsAdmin", bbsAdmin);
    }

    public int deleteBbsAdmin(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.deleteBbsAdmin", bbsAdmin);
    }

    public int deleteBbsList(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.deleteBbsList", bbsAdmin);
    }

    public int deleteBbsFile(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.deleteBbsFile", bbsAdmin);
    }

    public int deleteBbsLink(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.deleteBbsLink", bbsAdmin);
    }

    public int deleteBbsInf(BbsAdmin bbsAdmin) {

        return (Integer) update("BbsAdminDao.deleteBbsInf", bbsAdmin);
    }
}
