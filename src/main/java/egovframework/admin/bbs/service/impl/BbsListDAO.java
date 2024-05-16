package egovframework.admin.bbs.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.bbs.service.BbsAdmin;
import egovframework.admin.bbs.service.BbsList;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("BbsListDAO")
public class BbsListDAO extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsList", bbsList);
    }

    public int selectBbsListCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.selectBbsListCnt", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsAdminInfo(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsAdminInfo", bbsList);
    }

    public String selectBbsTypeCd(BbsList bbsList) throws DataAccessException, Exception {
        return (String) selectByPk("BbsListDAO.selectBbsTypeCd", bbsList);
    }

    public BbsAdmin selectBbsDitcCd(BbsList bbsList) throws DataAccessException, Exception {
        return (BbsAdmin) selectByPk("BbsListDAO.selectBbsDitcCd", bbsList);
    }

    public String selectDelYn(BbsList bbsList) throws DataAccessException, Exception {
        return (String) selectByPk("BbsListDAO.selectDelYn", bbsList);
    }

    public BbsList selectBbsDtlList(BbsList bbsList) throws DataAccessException, Exception {
        return (BbsList) selectByPk("BbsListDAO.selectBbsDtlList", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsLinkList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsLinkList", bbsList);
    }

    public int selectBbsLinkListCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.selectBbsLinkListCnt", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsInfList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsInfList", bbsList);
    }

    public int selectBbsInfListCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.selectBbsInfListCnt", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsFileList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsFileList", bbsList);
    }

    public int selectBbsFileListCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.selectBbsFileListCnt", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsInfPopList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsInfPopList", bbsList);
    }

    public int selectBbsInfPopListCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.selectBbsInfPopListCnt", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> bbsImgDetailView(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.bbsImgDetailView", bbsList);
    }

    @SuppressWarnings("unchecked")
    public List<BbsList> getTopImg(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.getTopImg", bbsList);
    }

    public int getSeq(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getSeq", bbsList);
    }

    public int getLinkSeq(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getLinkSeq", bbsList);
    }

    public int getFileSeq(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getFileSeq", bbsList);
    }

    public int getLinkCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getLinkCnt", bbsList);
    }

    public int getInfCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getInfCnt", bbsList);
    }

    public int getFileCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getFileCnt", bbsList);
    }

    public int insertBbsList(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.insertBbsList", bbsList);
    }

    public int deleteImg(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteImg", bbsList);
    }

    public int updateTopYn(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateTopYn", bbsList);
    }

    public int updateTopYn2(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateTopYn2", bbsList);
    }

    public int getTopYnCnt(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("BbsListDAO.getTopYnCnt", bbsList);
    }

    public int updateBbsList(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateBbsList", bbsList);
    }

    public int deleteBbsList(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteBbsList", bbsList);
    }

    public int updateAnsState(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateAnsState", bbsList);
    }

    public int deleteCPBbsLink(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteCPBbsLink", bbsList);
    }

    public int deleteCPBbsInf(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteCPBbsInf", bbsList);
    }

    public int insertBbsLink(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.insertBbsLink", saveVO);
    }

    public int deleteCPBbsFile(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteCPBbsFile", saveVO);
    }

    public int updateLinkCnt(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateLinkCnt", saveVO);
    }

    public int updateInfCnt(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateInfCnt", saveVO);
    }

    public int updateFileCnt(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateFileCnt", saveVO);
    }

    public int updateBbsLink(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateBbsLink", saveVO);
    }

    public int deleteUpdateBbsLink(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteUpdateBbsLink", saveVO);
    }

    public int deleteBbsLink(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteBbsLink", saveVO);
    }

    public int insertBbsInf(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.insertBbsInf", saveVO);
    }

    public int updateBbsInf(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateBbsInf", saveVO);
    }

    public int updateDeleteBbsInf(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateDeleteBbsInf", saveVO);
    }

    public int deleteBbsInf(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteBbsInf", saveVO);
    }


    public int insertBbsFile(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.insertBbsFile", saveVO);
    }

    public int updateBbsFile(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateBbsFile", saveVO);
    }

    public int deleteUpdateBbsFile(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteUpdateBbsFile", saveVO);
    }

    public int deleteBbsFile(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteBbsFile", saveVO);
    }

    public int updateDeleteImg(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateDeleteImg", saveVO);
    }

    public int deleteImgDtl(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.deleteImgDtl", saveVO);
    }

    public int updateTopImg(BbsList saveVO) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateTopImg", saveVO);
    }

    public int mergeIntoFile(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.mergeIntoFile", bbsList);
    }

    public String getBbsCd(int seq) throws DataAccessException, Exception {
        return (String) getSqlMapClientTemplate().queryForObject("BbsListDAO.getBbsCd", seq);
    }

    /**
     * 통계표 연결 리스트 조회
     */
    @SuppressWarnings("unchecked")
    public List<BbsList> selectBbsTblList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectBbsTblList", bbsList);
    }

    /**
     * 통계표 연결 추가 팝업 리스트 조회
     */
    public List<BbsList> selectSttsTblPopList(BbsList bbsList) throws DataAccessException, Exception {
        return (List<BbsList>) list("BbsListDAO.selectSttsTblPopList", bbsList);
    }

    /**
     * 통계표 연결 등록
     */
    public int insertBbsTbl(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.insertBbsTbl", bbsList);
    }

    /**
     * 통계표 연결 삭제
     */
    public int deleteBbsTbl(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) delete("BbsListDAO.deleteBbsTbl", bbsList);
    }

    /**
     * 통계표 연결 수정(삭제여부 변경)
     */
    public int updateBbsTbl(BbsList bbsList) throws DataAccessException, Exception {
        return (Integer) update("BbsListDAO.updateBbsTbl", bbsList);
    }
}
