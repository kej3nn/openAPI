package egovframework.admin.expose.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "adminExposeInfoDao")
public class AdminExposeInfoDao extends BaseDao {

    //청구대상기관을 조회한다.
    public List<?> selectNaboOrg(Params params) {
        return search("AdminExposeInfoDao.selectNaboOrg", params);
    }

    //청구서작성 공통코드를 조회한다.
    public List<?> selectComCode(Params params) throws DataAccessException, Exception {
        return search("AdminExposeInfoDao.selectComCode", params);
    }

    /**
     * 청구조회  리스트 조회
     */
    public Paging selectOpnApplyList(Params params, int page, int rows) throws DataAccessException, Exception {
        return search("AdminExposeInfoDao.selectOpnApplyList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 정보공개 청구서 > 신청번호 조회한다.(입력시 사용)
     */
    public String selectNextAplNo() throws DataAccessException, Exception {
        return (String) select("PortalExposeInfoDao.selectNextAplNo");
    }

    /**
     * 정보공개 청구서 등록/수정
     */
    public void saveOpnApply(Params params) throws DataAccessException, Exception {
        merge("AdminExposeInfoDao.saveOpnApply", params);
    }

    /**
     * 정보행정이력관리 정보 등록
     */
    public void insertOpnHist(Params params) throws DataAccessException, Exception {
        insert("AdminExposeInfoDao.insertOpnHist", params);
    }

    /**
     * 접수번호 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectRcpNo(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectRcpNo", paramMap);
    }

    /**
     * 다음 접수번호 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectNextRcpNo(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectNextRcpNo", paramMap);
    }

    /**
     * 접수 상세번호 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectRcpDtsNo(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectRcpDtsNo", paramMap);
    }

    /**
     * 청구상태이력조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectOpnzHist(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectOpnzHist", paramMap);
    }

    /**
     * 청구서조회 상세
     *
     * @param paramMap
     * @return
     */
    public Map<String, Object> selectOpnApplyDtl(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.selectOpnApplyDtl", paramMap);
    }

    /**
     * 청구서 수정
     *
     * @param params
     * @return
     */
    public Object updateOpnApply(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnApply", params);
    }

    /**
     * 접수번호 중복확인
     *
     * @param params
     * @return
     */
    public int getInfoOpnRcpnoCheck(Params params) throws DataAccessException, Exception {

        return (Integer) select("AdminExposeInfoDao.getInfoOpnRcpnoCheck", params);
    }

    public Map<String, Object> opnApplyDtl(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.opnApplyDtl", paramMap);
    }

    /**
     * 정보공개청구 접수
     *
     * @param dtlMap
     * @return
     */
    public Object insertOpnRcp(Map<String, Object> paramMap) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.insertOpnRcp", paramMap);
    }

    /**
     * 정보공개청구 처리구분변경
     *
     * @param params
     * @return
     */
    public Object updateOpnApplyPrgStat(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnApplyPrgStat", params);
    }

    /**
     * 이송기관 청구서 중복체크
     *
     * @param record
     * @return
     */
    public int selectTrsOpnAplDup(Record record) throws DataAccessException, Exception {
        return (Integer) select("AdminExposeInfoDao.selectTrsOpnAplDup", record);
    }

    /**
     * 정보공개청구 데이터 조회(상세)
     *
     * @param params
     * @return
     */
    public Record selectOpnAplDtl(Params params) throws DataAccessException, Exception {
        return (Record) select("AdminExposeInfoDao.selectOpnAplDtl", params);
    }

    /**
     * 정보공개 이관등록
     *
     * @param dtlMap
     * @return
     */
    public Object insertTrsOpnApl(Record record) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.insertTrsOpnApl", record);
    }

    /**
     * 정보공개 이송 업데이트
     *
     * @param record
     * @return
     */
    public Object updateTrsOpnApl(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateTrsOpnApl", params);
    }

    /**
     * 정보공개접수 처리구분변경
     *
     * @param params
     * @return
     */
    public Object updateOpnRcpPrgStat(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnRcpPrgStat", params);
    }

    /**
     * 정보공개접수조회
     *
     * @param params
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getInfoOpnDcsSearch(Params params) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.getInfoOpnDcsSearch", params);
    }

    /**
     * 결정기한연장
     *
     * @param params
     * @return
     */
    public Object insertOpnDcsProd(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.insertOpnDcsProd", params);
    }

    /**
     * 정보공개접수  진행상황코드, 종결내용 수정
     *
     * @param params
     * @return
     */
    public Object updateOpnEndCn(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnEndCn", params);
    }

    /**
     * 정보공개 청구 타기관 이송 등록
     */
    public Object updateTrsf(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateTrsf", params);
    }

    /**
     * 정보공개접수 수정
     *
     * @param params
     * @return
     */
    public Object updateOpnzRcp(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnzRcp", params);
    }

    /**
     * 정보공개청구 수정
     *
     * @param params
     * @return
     */
    public Object updateOpnzApl(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnzApl", params);
    }

    /**
     * 결정통보 상세
     *
     * @param params
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getInfoOpnDcsDetail(Params params) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.getInfoOpnDcsDetail", params);
    }

    /**
     * 청구서 상세(팝업)
     *
     * @param params
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getInfoOpenApplyDetail(Params params) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.getInfoOpenApplyDetail", params);
    }


    /**
     * 이의신청 내역 상세(팝업)
     *
     * @param params
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getOpnObjtnInfoDetail(Params params) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.getOpnObjtnInfoDetail", params);
    }

    /**
     * 부서정보 팝업 리스트 조회
     *
     * @param params
     * @return
     */
    public List<?> infoOrgPopList(Params params) {
        return list("AdminExposeInfoDao.infoOrgPopList", params);
    }

    /**
     * 정보공개 담당자 정보를 수정한다.
     *
     * @param params
     * @return
     */
    public Object updateOpnAplDept(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.updateOpnAplDept", params);
    }

    /**
     * 담당부서 정보 삭제
     *
     * @param params
     * @return
     */
    public Object deleteOpnAplDept(Params params) {
        return delete("AdminExposeInfoDao.deleteOpnAplDept", params);
    }

    /**
     * 담당부서 정보 입력
     *
     * @param params
     * @return
     * @throws DataAccessException
     * @throws Exception
     */
    public Object insertOpnAplDept(Params params) throws DataAccessException, Exception {
        return update("AdminExposeInfoDao.insertOpnAplDept", params);
    }

    /**
     * 담당부서 정보 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectOpnzDept(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectOpnzDept", paramMap);
    }

    /**
     * 담당부서 정보조회
     *
     * @param params
     * @return
     */
    public List<Record> selectOpnzDeptList(Params params) {
        return (List<Record>) list("AdminExposeInfoDao.selectOpnzDeptList", params);
    }

    /**
     * 정보공개 청구서 접근기록
     *
     * @param paramMap
     * @return
     * @throws DataAccessException
     * @throws Exception
     */
    public Object insertLogAcsOpnzApl(Params params) throws DataAccessException, Exception {
        return insert("AdminExposeInfoDao.insertLogAcsOpnzApl", params);
    }

    /**
     * 이송을 위해 정보공개접수 정보 조회
     *
     * @param params
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getInfoOpnAplSearch(Params params) throws DataAccessException, Exception {
        return (Map<String, Object>) select("AdminExposeInfoDao.getInfoOpnAplSearch", params);
    }

    /**
     * 이송받은정보 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectFromTrst(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectFromTrst", paramMap);
    }

    /**
     * 이송보낸정보 조회
     *
     * @param paramMap
     * @return
     */
    public List<Map<String, Object>> selectToTrst(Map<String, String> paramMap) throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("AdminExposeInfoDao.selectToTrst", paramMap);
    }

    //이송한 적이 없는 청구대상기관을 조회한다.
    public List<?> selectNotTrstNaboOrg(Params params) {
        return search("AdminExposeInfoDao.selectNotTrstNaboOrg", params);
    }

    /**
     * 신청연계 코드 저장
     *
     * @param params
     * @return
     */
    public int updateAplConnCd(Params params) {
        return update("AdminExposeInfoDao.updateAplConnCd", params);
    }
}	
