package egovframework.admin.openinf.service.impl;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenDs;
import egovframework.admin.openinf.service.OpenDscol;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository("OpenDsDAO")
public class OpenDsDAO extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<OpenDs> selectOpenDsList(OpenDs openDs) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectOpenDsList", openDs);
    }

    public int selectOpenDsListCnt(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDsListCnt", openDs);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDscol> selectOpenDsColList(OpenDscol openDscol) throws DataAccessException, Exception {
        return (List<OpenDscol>) list("OpenDsDAO.selectOpenDsColList", openDscol);
    }


    public int selectOpenDsColListCnt(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDsColListCnt", openDscol);
    }

    //개인정보식별조회용 카운트DAO추가
    public int selectOpenDsIdeInfCnt(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDsIdeInfCnt", openDscol);
    }

    ////////////////////
    public int selectOpenDtblListCnt(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDtblListCnt", openDscol);
    }

    public int selectOpenDstblListCnt(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDstblListCnt", openDscol);
    }

    //////////////
    @SuppressWarnings("unchecked")
    public List<OpenDscol> selectOpenDsSrcColList(OpenDscol openDscol) throws DataAccessException, Exception {
        return (List<OpenDscol>) list("OpenDsDAO.selectOpenDsSrcColList", openDscol);
    }

    public int selectOpenDsSrcColListCnt(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDsSrcColListCnt", openDscol);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDs> selectOpenDsPopList(OpenDs openDs) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectOpenDsPopList", openDs);
    }

    public int selectOpenDsPopListCnt(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDsPopListCnt", openDs);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDs> selectBackDsPopList(OpenDs openDs) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectBackDsPopList", openDs);
    }

    public int selectBackDsPopListCnt(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectBackDsPopListCnt", openDs);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDscol> selectSamplePopList(OpenDscol openDscol) throws DataAccessException, Exception {
        return (List<OpenDscol>) list("OpenDsDAO.selectSamplePopList", openDscol);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDscol> selectSamplePop(OpenDscol openDscol) throws DataAccessException, Exception {
        return (List<OpenDscol>) list("OpenDsDAO.selectSamplePop", openDscol);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDs> selectOpenDtPopList(OpenDs openDs) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectOpenDtPopList", openDs);
    }

    public int selectOpenDtPopListCnt(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDtPopListCnt", openDs);
    } 
	
    /*public OpenDs selectOpenDsDtl(OpenDs openDs) throws DataAccessException, Exception {
    	return (OpenDs)selectByPk("OpenDsDAO.selectOpenDsDtl", openDs);
    }*/

    @SuppressWarnings("unchecked")
    public List<OpenDs> selectOpenDsDtl(OpenDs openDs) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectOpenDsDtl", openDs);
    }


    public int insertDs(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.insertDs", openDs);
    }

    public int updateDs(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.updateDs", openDs);
    }

    public int deleteDs(OpenDs openDs) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteDs", openDs);
    }

    /* 1122
    public int deleteDstbl(OpenDs openDs) throws DataAccessException, Exception {
    	return (Integer)update("OpenDsDAO.deleteDstbl", openDs);
    }*/
    public int insertDsCol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.insertDsCol", saveVO);
    }

    public int updateDsCol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.updateDsCol", saveVO);
    }

    public int deleteDsCol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteDsCol", saveVO);
    }

    public int selectOpenCdCheck(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenCdCheck", openDscol);
    }

    public int dupDsId(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.dupDsId", openDscol);
    }


    /**
     * 관련 데이터셋 리스트 조회(공표기준등록 및 수정에서 사용)
     *
     * @param openDs
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenDs> selectOpenPubCfgRefDsPopUpList(OpenDs openDs) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectOpenPubCfgRefDsPopUpList", openDs);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDs> selectOpenDsTermPopList(OpenDscol openDscol) throws DataAccessException, Exception {
        return (List<OpenDs>) list("OpenDsDAO.selectOpenDsTermPopList", openDscol);
    }

    public int selectOpenDsTermPopListCnt(OpenDscol openDscol) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDsTermPopListCnt", openDscol);
    }

    /**
     * col_seq가 중복되는것이 하나라도 있으면 실행불가.. 컬럼들 전부삭제후 해야함.
     *
     * @param selectVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenDscolDup(OpenDscol selectVO) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectOpenDscolDup", selectVO);
    }

    /**
     * 메타정보의 데이터를 삭제하기 위해 데이터구분 확인.
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public String selectDsCd(OpenDscol saveVO) throws DataAccessException, Exception {
        return (String) selectByPk("OpenDsDAO.selectDsCd", saveVO);
    }

    /**
     * tb_open_inf_scol 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteInfScol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteInfScol", saveVO);
    }

    /**
     * tb_open_inf_ccol 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteInfCcol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteInfCcol", saveVO);
    }

    /**
     * tb_open_inf_acol 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteInfAcol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteInfAcol", saveVO);
    }

    /**
     * tb_open_inf_mcol 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteInfMcol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteInfMcol", saveVO);
    }

    /**
     * tb_open_inf_tcol 삭제
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteInfTcol(OpenDscol saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDsDAO.deleteInfTcol", saveVO);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 2017/10/11 - 김정호
    // 	 * 데이터셋 관리 화면 변경(신규 추가된 항목들) [시작]
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * 데이터셋 컬럼유형정보 조회
     *
     * @return
     */
    public List<Map<String, Object>> selectOpenDscoltyCd() throws DataAccessException, Exception {
        return (List<Map<String, Object>>) list("OpenDsDAO.selectOpenDscoltyUseY", null);
    }

    /**
     * 공공데이터 담당직원 삭제
     *
     * @param params
     * @return
     */
    public Object delOpenDsUsr(Params params) throws DataAccessException, Exception {
        return update("OpenDsDAO.delOpenDsUsr", params);
    }

    /**
     * 공공데이터 담당직원 등록/수정
     *
     * @param pMap
     * @return
     */
    public Object mergeOpenDsUsr(Map<String, LinkedList<Record>> pMap) throws DataAccessException, Exception {
        return update("OpenDsDAO.mergeOpenDsUsr", pMap);
    }

    /**
     * 공공데이터 담당직원 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenDsUsrList(Params params) throws DataAccessException, Exception {
        return list("OpenDsDAO.selectOpenDsUsrList", params);
    }

    /**
     * 데이터셋의 적재주기(D1009)에 따라 입력대장을 생성한다
     *
     * @param params
     * @return
     */
    public Object execSpCreateOpenLdlist(Params params) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForObject("OpenDsDAO.execSpCreateOpenLdlist", params);
    }

    /**
     * 데이터셋 삭제 프로시져
     *
     * @param params
     * @return
     */
    public Object execSpDelOpenDs(Params params) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForObject("OpenDsDAO.execSpDelOpenDs", params);
    }

    /**
     * 데이터셋 테이블이 실제 존재하는지 확인
     *
     * @param params
     * @return
     */
    public Object selectExistSrcDsId(Params params) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForObject("OpenDsDAO.selectExistSrcDsId", params);
    }

}