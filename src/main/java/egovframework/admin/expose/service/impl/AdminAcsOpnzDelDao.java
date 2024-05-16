package egovframework.admin.expose.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "adminAcsOpnzDelDao")
public class AdminAcsOpnzDelDao extends BaseDao {

    /**
     * 청구인정보 기록삭제 리스트 조회
     */
    public Paging selectAcsOpnzDelList(Params params, int page, int rows) throws DataAccessException, Exception {
        return search("AdminAcsOpnzDelDao.selectAcsOpnzDelList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 청구인정보 기록삭제 데이터 수정(신청)
     *
     * @param params
     */
    public void deleteAcsOpnzAplDel(List<Record> list) {
        update("AdminAcsOpnzDelDao.deleteAcsOpnzAplDel", list);
    }

    /**
     * 청구인정보 기록삭제 데이터 수정(접수)
     *
     * @param params
     */
    public void deleteAcsOpnzRcpDel(List<Record> list) {
        update("AdminAcsOpnzDelDao.deleteAcsOpnzRcpDel", list);
    }

}
