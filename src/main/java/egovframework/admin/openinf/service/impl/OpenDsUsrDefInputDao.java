package egovframework.admin.openinf.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 데이터셋 사용자정의 입력 DB접근 클래스
 *
 * @author JHKIM
 * @version 1.0
 * @since 2019/09/26
 */
@Repository(value = "openDsUsrDefInputDao")
public class OpenDsUsrDefInputDao extends BaseDao {

    /**
     * 연계유형이 사용자건별입력로 지정한 데이터셋이 맞는지 체크
     */
    public int selectOpenDsUsrDefExist(String dsId) {
        return (Integer) select("openDsUsrDefInputDao.selectOpenDsUsrDefExist", dsId);
    }

    /**
     * 컬럼 리스트 조회
     */
    public List<?> selectOpenDsUsrDefColList(Params params) {
        return list("openDsUsrDefInputDao.selectOpenDsUsrDefColList", params);
    }

    /**
     * 시트 헤더정보 조회(컬럼정보)
     */
    public List<?> selectOpenDsUsrDefHeaderData(Params params) {
        return list("openDsUsrDefInputDao.selectOpenDsUsrDefHeaderData", params);
    }

    /**
     * 스키마 정보조회
     */
    public String selectOpenDsUsrOwnerCd(Params params) {
        return (String) select("openDsUsrDefInputDao.selectOpenDsUsrOwnerCd", params);
    }

    /**
     * 테이블 정보 조회
     */
    public String selectOpenDsUsrTableName(Params params) {
        return (String) select("openDsUsrDefInputDao.selectOpenDsUsrTableName", params);
    }

    /**
     * 테이블 컬럼명 조회
     */
    public List<?> selectOpenDsUsrColumnNames(Params params) {
        return list("openDsUsrDefInputDao.selectOpenDsUsrColumnNames", params);
    }

    /**
     * 실제 RAW 데이터 조회
     *
     * @return
     */
    public Paging selectOpenDsUsrDefData(Params params, int page, int rows) {
        return search("openDsUsrDefInputDao.selectOpenDsUsrDefData", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 데이터 저장
     */
    public Object insertOpenDsUsrDef(Params params) {
        return insert("openDsUsrDefInputDao.insertOpenDsUsrDef", params);
    }

    /**
     * 데이터 수정
     */
    public Object updateOpenDsUsrDef(Params params) {
        return update("openDsUsrDefInputDao.updateOpenDsUsrDef", params);
    }

    /**
     * 데이터 삭제
     */
    public Object deleteOpenDsUsrDef(Params params) {
        return delete("openDsUsrDefInputDao.deleteOpenDsUsrDef", params);
    }

    /**
     * 데이터 첨부파일 조회
     */
    public List<?> selectOpenDsUsrDefFile(Params params) {
        return list("openDsUsrDefInputDao.selectOpenDsUsrDefFile", params);
    }

    /**
     * 데이터 첨부파일 저장
     */
    public Object insertOpenDsUsrDefFile(Record record) {
        return insert("openDsUsrDefInputDao.insertOpenDsUsrDefFile", record);
    }

    /**
     * 데이터 첨부파일 수정
     */
    public Object updateOpenDsUsrDefFile(Record record) {
        return insert("openDsUsrDefInputDao.updateOpenDsUsrDefFile", record);
    }

    /**
     * 데이터 첨부파일 삭제
     */
    public Object deleteOpenDsUsrDefFile(Record record) {
        return insert("openDsUsrDefInputDao.deleteOpenDsUsrDefFile", record);
    }

    /**
     * 데이터 첨부파일 전체삭제
     */
    public Object deleteOpenDsUsrDefFileAll(Params params) {
        return delete("openDsUsrDefInputDao.deleteOpenDsUsrDefFileAll", params);
    }

    public int selectOpenDsUsrDefFileSeq(Params params) {
        return (Integer) select("openDsUsrDefInputDao.selectOpenDsUsrDefFileSeq", params);
    }

    /**
     * 날짜 컬럼 조회
     */
    public List<?> selectOpenDsDateCol(Params params) {
        return list("openDsUsrDefInputDao.selectOpenDsDateCol", params);
    }

    /**
     * DB 사용자 분류 조회
     */
    public String selectOpenDsUsrOwnerCdByCommCd(Params params) {
        return (String) select("openDsUsrDefInputDao.selectOpenDsUsrOwnerCdByCommCd", params);
    }

    /**
     * 첨부파일 순서저장
     */
    public Object saveOpenUsrDefFileOrder(Params params) {
        return update("openDsUsrDefInputDao.saveOpenUsrDefFileOrder", params);
    }
}

