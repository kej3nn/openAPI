package egovframework.admin.expose.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

@Repository(value = "adminOpenDecisionDao")
public class AdminOpenDecisionDao extends BaseDao {

    /**
     * 정보공개 결정내역  리스트 조회
     */
    public Paging searchOpnDcsPaging(Params params, int page, int rows) {
        return search("AdminOpenDecisionDao.searchOpnDcsPaging", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 정보공개 결정내역 > 정보공개접수 조회
     *
     * @param paramMap
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> writeOpnDcs(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenDecisionDao.getOpnDcsSearch", paramMap);
    }

    /**
     * 정보공개 결정내역 상세
     *
     * @param paramMap
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> detailOpnDcs(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenDecisionDao.detailOpnDcs", paramMap);
    }

    /**
     * 정보공개 결정내역 상세 > 비공개사유 정보
     *
     * @param paramMap
     * @return
     */
    public List<?> selectOpnDcsClsd(Params params) {
        return search("AdminOpenDecisionDao.selectOpnDcsClsd", params);
    }

    /**
     * 결정관리 Table 청구번호 조회
     *
     * @param params
     * @return
     */
    public String getInfoOpenDcsSeqCount(Params params) {
        return (String) getSqlMapClientTemplate().queryForObject("AdminOpenDecisionDao.getInfoOpenDcsSeqCount", params);
    }

    /**
     * 결정통보등록
     *
     * @param params
     * @return
     */
    public void insertInfoOpnDcsWrite(Params params) {

        //정보공개 결정 구분 > 2.부분공개, 3.비공개
        if ("2".equals(params.getString("opb_yn")) || "3".equals(params.getString("opb_yn"))) {
            params.put("prg_stat_cd", "08");
        } else {
            params.put("prg_stat_cd", "04");
        }

        insert("AdminOpenDecisionDao.insertOpnDcs", params);
        update("AdminOpenDecisionDao.updateOpnApplyPrgStat", params);
        update("AdminOpenDecisionDao.updateOpnRcpPrgStat", params);

        //즉시처리 일 경우
        if ("1".equals(params.getString("imd_deal_div"))) params.put("hist_cn", "즉시처리 되었습니다.");
        else params.put("hist_cn", "결정내용이 등록되었습니다.");
        insert("AdminOpenDecisionDao.insertOpnHist", params);

    }

    /**
     * 결정통보수정
     *
     * @param params
     * @return
     */
    public void updateInfoOpnDcsWrite(Params params) {

        update("AdminOpenDecisionDao.updateInfoOpnDcsWrite", params);

        //정보공개 결정 구분 > 2.부분공개, 3.비공개
        if ("2".equals(params.getString("opb_yn")) || "3".equals(params.getString("opb_yn"))) {
            params.put("prg_stat_cd", "08");
        } else {
            params.put("prg_stat_cd", "04");
        }

        update("AdminOpenDecisionDao.updateOpnApplyPrgStat", params);
        update("AdminOpenDecisionDao.updateOpnRcpPrgStat", params);

        //즉시처리 일 경우
        if ("1".equals(params.getString("imd_deal_div"))) params.put("hist_cn", "즉시처리 되었습니다.");
        else params.put("hist_cn", "결정내용이 수정되었습니다.");
        insert("AdminOpenDecisionDao.insertOpnHist", params);

    }

    /**
     * 결정통보 공개실시
     *
     * @param params
     * @return
     */
    public void openStartOpnDcs(Params params) {
        update("AdminOpenDecisionDao.openStartOpnDcs", params);
    }

    /**
     * 결정통보 공개실시 후 상태 및 이력정보 추가
     *
     * @param params
     * @return
     */
    public void updateOpnPrgHist(Params params) {
        params.put("prg_stat_cd", "08");
        update("AdminOpenDecisionDao.updateOpnApplyPrgStat", params);
        update("AdminOpenDecisionDao.updateOpnRcpPrgStat", params);
        params.put("hist_cn", "공개실시 처리되었습니다.");
        insert("AdminOpenDecisionDao.insertOpnHist", params);
    }

    /**
     * 이의신청내역  리스트 조회
     */
    public Paging searchOpnObjtnProcPaging(Params params, int page, int rows) {
        return search("AdminOpenDecisionDao.searchOpnObjtnProcPaging", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 오프라인 이의신청시 기본적인 청구인정보
     *
     * @param paramMap
     * @return
     */
    public Map<String, Object> getWriteBaseInfo(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenDecisionDao.getWriteBaseInfo", paramMap);
    }

    /**
     * 오프라인 이의신청시 등록
     *
     * @param params
     * @return
     */
    public Object writeObjtn(Params params) {
        return update("AdminOpenDecisionDao.writeObjtn", params);
    }

    /**
     * 이의신청 수정 (온, 오프라인 이의신청건에 대한 수정 전 신청서 정보)
     *
     * @param paramMap
     * @return
     */
    public Map<String, Object> getUpdateBaseInfo(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenDecisionDao.getUpdateBaseInfo", paramMap);
    }

    /**
     * 이의신청시 수정
     *
     * @param params
     * @return
     */
    public Object UpdateObjtn(Params params) {
        return update("AdminOpenDecisionDao.UpdateObjtn", params);
    }

    /**
     * 이의신청시 파일 삭제
     *
     * @param params
     * @return
     */
    public Object deleteFile(Params params) {
        return update("AdminOpenDecisionDao.deleteFile", params);
    }

    /**
     * 이의신청 접수번호
     *
     * @param params
     * @return
     */
    public String getObjtnRcpNo(Params params) {
        return (String) select("AdminOpenDecisionDao.getObjtnRcpNo", params);
    }

    /**
     * 이의신청 실제 접수번호
     *
     * @param params
     * @return
     */
    public String getNextRcpNo(Params params) {
        return (String) select("AdminOpenDecisionDao.getNextRcpNo", params);
    }

    /**
     * 이의신청내역 상세
     *
     * @param paramMap
     * @return
     */
    public Map<String, Object> detailOpnObjtnProc(Map<String, String> paramMap) {
        return (Map<String, Object>) select("AdminOpenDecisionDao.detailOpnObjtnProc", paramMap);
    }

    /**
     * 취소 처리
     *
     * @param params
     * @return
     */
    public void cancelOpnProd(Params params) {
        update("AdminOpenDecisionDao.updateOpnApplyPrgStat", params);
        update("AdminOpenDecisionDao.updateOpnRcpPrgStat", params);
        if (params.getString("prg_stat_cd").equals("03")) delete("AdminOpenDecisionDao.deleteOpnDcs", params);
        update("AdminOpenObjectionDao.writeObjtnHist", params);
    }

    /**
     * 결정통보 비공개내용 및 사유 삭제
     *
     * @param params
     * @return
     * @throws DataAccessException, Exception
     */
    public void deleteOpnDcsClsd(Params params) {
        delete("AdminOpenDecisionDao.deleteOpnDcsClsd", params);
    }

    /**
     * 결정통보 비공개내용 및 사유 등록
     *
     * @param params
     * @return
     */
    public void insertOpnDcsClsd(Params params) {
        insert("AdminOpenDecisionDao.insertOpnDcsClsd", params);
    }

    /**
     * 결정통보 비공개내용 및 사유 > 이의신청사유 등록
     *
     * @param params
     * @return
     */
    public void updateOpnDcsClsd(Params params) {
        insert("AdminOpenDecisionDao.updateOpnDcsClsd", params);
    }
}
