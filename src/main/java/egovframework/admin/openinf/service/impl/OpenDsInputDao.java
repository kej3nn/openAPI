package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

@Repository(value = "openDsInputDao")
public class OpenDsInputDao extends BaseDao {

    //공통코드 값을 조회한다.
    public List<?> selectOption(Params params) {
        return search("OpenDsInput.selectOption", params);
    }

    /**
     * 공공데이터 메인 입력 스케쥴 리스트 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenDsInputList(Params params) {
        return list("OpenDsInput.selectOpenDsInputList", params);
    }

    public Object selectOpenDsInputDtl(Params params) {
        return select("OpenDsInput.selectOpenDsInputDtl", params);
    }

    public List<?> selectOpenDsInputCol(Params params) {
        return list("OpenDsInput.selectOpenDsInputCol", params);
    }

    public List<?> selectOpenDsInputData(Params params) {
        return list("OpenDsInput.selectOpenDsInputData", params);
    }

    /**
     * 공공데이터 실 데이터 중복제거 한 rowSeq 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenDsInputDataRowSeq(Params params) {
        return list("OpenDsInput.selectOpenDsInputDataRowSeq", params);
    }

    /**
     * 검증 데이터 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenDsVerifyData(Params params) {
        return list("OpenDsInput.selectOpenDsVerifyData", params);
    }

    public Object deleteOpenDsInputData(Params params) {
        return delete("OpenDsInput.deleteOpenDsInputData", params);
    }

    public Object insertOpenDsInputData(Record record) {
        return insert("OpenDsInput.insertOpenDsInputData", record);
    }

    public Object insertLogOpenLdlist(Params params) {
        return insert("OpenDsInput.insertLogOpenLdlist", params);
    }

    public Object insertHisOpenLddata(Params params) {
        return insert("OpenDsInput.insertHisOpenLddata", params);
    }

    /**
     * 공공데이터 입력 검증 실패 데이터 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenDsInputVerifyData(Params params) {
        return list("OpenDsInput.selectOpenDsInputVerifyData", params);
    }

    /**
     * 공공데이터 입력 상세 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenDsUsrList(Params params) {
        return list("OpenDsInput.selectOpenDsUsrList", params);
    }

    /**
     * 검증 데이터 update
     *
     * @param record
     * @return
     */
    public Object updateOpenLddataVerify(Record record) {
        return insert("OpenDsInput.updateOpenLddataVerify", record);
    }

    /**
     * 승인전 테이블 생성
     *
     * @param params
     * @return
     */
    public Object execSpCreateOpenDs(Params params) {
        return getSqlMapClientTemplate().queryForObject("OpenDsInput.execSpCreateOpenDs", params);
    }

    /**
     * 데이터입력 스케쥴 생성
     *
     * @param params
     * @return
     */
    public Object execSpCreateOpenLdlist(Params params) {
        return getSqlMapClientTemplate().queryForObject("OpenDsInput.execSpCreateOpenLdlist", params);
    }

}
