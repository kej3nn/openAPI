package egovframework.common.code.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 코드 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("CodeDAO")
public class CodeDAO extends EgovComAbstractDAO {

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectCodeList() throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectCodeList", null);
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectEntityOrgCodeList() throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectEntityOrgCodeList", null);
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectEntityFiltCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectEntityFiltCodeList", value);
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectEntityCateNmCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectEntityCateNmCodeList", value);
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectCodeDtlList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectCodeDtlList", value);
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectEntityItemCdCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectEntityItemCdCodeList", value);
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectUnitSubCdCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectUnitSubCdCodeList", value);
    }


    /**
     * 그룹코드 목록을 조회한다.(그룹코드만 조회)
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectEntityGrpCdCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectEntityGrpCdCodeList", null);
    }


    /**
     * 팝업VIEW 목록을 조회한다.(팝업VIEW 조회)
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectEntityTblCdCdCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectEntityTblCdCdCodeList", null);
    }

    /**
     * 차트 BAR
     *
     * @param value
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectSeriesCdBarList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectSeriesCdBarList", null);
    }

    /**
     * 차트 PIE
     *
     * @param value
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectSeriesCdPieList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectSeriesCdPieList", null);
    }

    @SuppressWarnings("unchecked")
    public List<CommCode> selectSTTSCodeList(String value) throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectSTTSCodeList", value);
    }

    /**
     * 공공데이터 시트 서비스 데이터 다운로드 갯수를 확인한다.
     *
     * @param CommCode
     * @return List<CommCode>
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommCode> selectDownCntList() throws DataAccessException, Exception {
        return (List<CommCode>) list("CodeDAO.selectDownCntList", null);
    }
}
