package egovframework.admin.bbs.service;

import java.util.List;


public interface BbsAdminService {
    public List<BbsAdmin> bbsAdminListAll(BbsAdmin bbsAdmin);

    public List<BbsAdmin> selectBbsAdminList(BbsAdmin bbsAdmin);

    public int bbsAdminCodeCheck(BbsAdmin bbsAdmin);

    public int bbsAdminRegCUD(BbsAdmin bbsAdmin, String state);

}
