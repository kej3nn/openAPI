package egovframework.admin.expose.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

@Repository(value = "adminOpenObjectionDao")
public class AdminOpenObjectionDao extends BaseDao {

    /**
     * 오프라인 이의신청 가능내역 리스트 조회
     */
    public Paging searchOpnObjtnPaging(Params params, int page, int rows) {
        return search("AdminOpenObjectionDao.searchOpnObjtnPaging", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 이의신청 오프라인등록 기본정보
     *
     * @param paramMap
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> writeOpnObjtn(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenObjectionDao.getWriteBaseInfo", paramMap);
    }

    /**
     * 이의신청 오프라인등록
     *
     * @param params
     * @return
     */
    public void writeObjtn(Params params) {

        insert("AdminOpenObjectionDao.writeObjtn", params);
        insert("AdminOpenObjectionDao.writeObjtnHist", params);

        //오프라인 이의신청 첨부파일 유무
        if ("Y".equals(params.getString("apl_attch_delete"))) {
            update("AdminOpenObjectionDao.deleteFile", params);
        } else {
            update("AdminOpenObjectionDao.UpdateObjtn", params);
        }

    }

    /**
     * 이의신청내역 리스트 조회
     */
    public Paging searchOpnObjtnProcPaging(Params params, int page, int rows) {
        return search("AdminOpenObjectionDao.searchOpnObjtnProcPaging", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 이의신청내역 > 이의신청 접수번호
     *
     * @param paramMap
     * @return
     */
    public String getObjtnRcpNo() {
        return (String) select("AdminOpenObjectionDao.getObjtnRcpNo");
    }

    /**
     * 이의신청내역 > 이의신청 실제 접수번호
     *
     * @param paramMap
     * @return
     */
    public String getNextRcpNo() {
        return (String) select("AdminOpenObjectionDao.getNextRcpNo");
    }

    /**
     * 이의신청내역 > 조회
     *
     * @param paramMap
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> detailOpnObjtnProc(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenObjectionDao.getObjtnInfo", paramMap);
    }

    /**
     * 이의신청내역 > 접수처리 > 접수번호 중복확인
     *
     * @param paramMap
     * @return
     */
    public String getRcpDtsNocheck(Params params) {
        return (String) select("AdminOpenObjectionDao.getRcpDtsNo", params);
    }

    /**
     * 이의신청내역 > 접수처리
     *
     * @param params
     * @return
     */
    public void receiptObjtnProc(Params params) {
        update("AdminOpenObjectionDao.writeObjtnDcs", params);
        update("AdminOpenObjectionDao.writeObjtnHist", params);
    }

    /**
     * 이의신청내역 > 취하처리
     *
     * @param params
     * @return
     */
    public void cancelObjtnProc(Params params) {
        update("AdminOpenObjectionDao.cancleOpnObjtn", params);
        update("AdminOpenObjectionDao.writeObjtnHist", params);
    }

    /**
     * 이의신청내역 > 저장(결과등록)
     *
     * @param params
     * @return
     */
    public void writeObjtnProc(Params params) {
        update("AdminOpenObjectionDao.writeObjtnProc", params);
        update("AdminOpenObjectionDao.writeObjtnHist", params);
    }

    /**
     * 이의신청 결정기한연장을 위한 정보조회
     *
     * @param params
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> searchObjtnDcsProd(Params params) {
        return (Map<String, Object>) select("AdminOpenObjectionDao.getObjtnInfo", params);
    }

    /**
     * 이의신청 결정기한연장
     *
     * @param params
     * @return
     */
    public void insertOpnObjtnProd(Params params) {
        update("AdminOpenObjectionDao.writeOpnObjtnPerExtProc", params);
        update("AdminOpenObjectionDao.writeObjtnHist", params);
    }

    /**
     * 이의신청 결과 공개실시
     *
     * @param params
     * @return
     */
    public void openStartOpnObjtn(Params params) {
        update("AdminOpenDecisionDao.openStartOpnObjtn", params);
        insert("AdminOpenObjectionDao.writeObjtnHist", params);
    }

    /**
     * 이의상태이력조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectOpnzHist(Map<String, String> paramMap) {
        return (List<Map<String, Object>>) list("AdminOpenObjectionDao.selectOpnzHist", paramMap);
    }

    /**
     * 이의신청 다음순번 확인
     *
     * @param params
     * @return
     */
    public String getInfoOpenObjtnSnoNext(Params params) {
        return (String) getSqlMapClientTemplate().queryForObject("AdminOpenObjectionDao.getInfoOpenObjtnSnoNext", params);
    }

    /**
     * 비공개 대상 목록 중 이의신청 된 목록 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectOpnDcsObjtn(Map<String, String> paramMap) {
        return (List<Map<String, Object>>) list("AdminOpenObjectionDao.selectOpnDcsObjtn", paramMap);
    }

}
