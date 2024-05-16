package egovframework.admin.service.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfAcol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfAcolDAO")
public class OpenInfAcolDAO extends EgovComAbstractDAO {

    /**
     * Open API 리스트
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectOpenInfColList", openInfSrv);
    }

    /**
     * Open API CUD
     *
     * @param openInfAcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoCol(OpenInfAcol openInfAcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfAcolDAO.mergeIntoCol", openInfAcol);
    }

    /**
     * Open API 리스스명 중복체크
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int openInfAcolApiDup(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfAcolDAO.apiDup", openInfSrv);
    }

    /**
     * Open API URI 리스트
     *
     * @param openInfSrvl
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectApiUriList(OpenInfSrv openInfSrvl) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectApiUri", openInfSrvl);
    }

    /**
     * Open API 팝업
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfAcol selectOpenInfColInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfAcol) selectByPk("OpenInfAcolDAO.selectOpenInfColInfo", openInfSrv);
    }

    /**
     * Open API URI CUD
     *
     * @param openInfAcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoApi(OpenInfAcol openInfAcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfAcolDAO.mergeIntoApi", openInfAcol);
    }

    /**
     * Open API 팝업 수정
     *
     * @param openInfAcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpt(OpenInfAcol openInfAcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfAcolDAO.updateOpt", openInfAcol);
    }

    /**
     * OPEN API 미리보기 출력값
     *
     * @param openInfSrvl
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectPreviewPrintVal(OpenInfSrv openInfSrvl) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectPreviewPrintVal", openInfSrvl);
    }

    /**
     * OPEN API 미리보기 에러메시지
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectPreviewResultMsg(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectPreviewResultMsg", openInfSrv);
    }

    /**
     * OPEN API 미리보기 요청변수
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectPreviewReqVar(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectPreviewReqVar", openInfSrv);
    }

    /**
     * OPEN API 미리보기 테스트
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectPreviewApiTest(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectPreviewApiTest", openInfSrv);
    }

    /**
     * Open API 미리보기 URL 테스트시 컬럼 조건이 기준정보에 있으면 selectBox 설정
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfAcol> selectPreviewApiTestSelectVal(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfAcol>) list("OpenInfAcolDAO.selectPreviewApiTestSelectVal", openInfSrv);
    }


}
