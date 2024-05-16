package egovframework.admin.nadata.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "naSetCateDao")
public class NaSetCateDao extends BaseDao {

    /**
     * 정보카달로그 분류 메인 리스트 조회
     *
     * @param params
     * @return
     */
    public List<?> selectNaSetCateList(Params params) {
        return list("NaSetCateDao.selectNaSetCateList", params);
    }

    /**
     * 정보카달로그 분류 팝업 리스트 조회
     *
     * @param params
     * @return
     */
    public List<?> selectNaSetCatePopList(Params params) {
        return list("NaSetCateDao.selectNaSetCatePopList", params);
    }

    /**
     * 정보카달로그 분류 상세 조회
     *
     * @param params
     * @return
     */
    public Object selectNaSetCateDtl(Params params) {
        return select("NaSetCateDao.selectNaSetCateDtl", params);
    }

    /**
     * 정보카달로그 분류 ID 중복체크
     *
     * @param params
     * @return
     */
    public Object selectNaSetCateDupChk(Params params) {
        return select("NaSetCateDao.selectNaSetCateDupChk", params);
    }

    /**
     * 정보카달로그 분류 등록/수정
     *
     * @param params
     * @return
     */
    public Object saveNaSetCate(Params params) {
        return merge("NaSetCateDao.mergeNaSetCate", params);
    }

    /**
     * 관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
     *
     * @param params
     * @return
     */
    public Object updateNaSetCateFullnm(Params params) {
        return update("NaSetCateDao.updateNaSetCateFullnm", params);
    }

    /**
     * 정보카달로그 분류 자식 존재 여부 조회
     *
     * @param params
     * @return
     */
    public Record selectNaSetCateHaveChild(Params params) {
        return (Record) select("NaSetCateDao.selectNaSetCateHaveChild", params);
    }

    /**
     * 정보카달로그 분류 삭제
     *
     * @param params
     * @return
     */
    public Object deleteNaSetCate(Params params) {
        return delete("NaSetCateDao.deleteNaSetCate", params);
    }

    /**
     * 정보카달로그 분류 순서 저장
     *
     * @param record
     * @return
     */
    public Object saveNaSetCateOrder(Record record) {
        return update("NaSetCateDao.saveNaSetCateOrder", record);
    }

    /**
     * 데이터 수정시 사용여부 N처리 될 경우 N처리된 하위 항목들은 모두 동일하게 사용여부 N처리 한다.
     *
     * @param params
     * @return
     */
    public Object updateNaoCateChildUseN(Params params) {
        return update("NaSetCateDao.updateNaoCateChildUseN", params);
    }

}
