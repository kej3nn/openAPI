package egovframework.admin.service.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfFcol;
import egovframework.admin.service.service.OpenInfLcol;
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
@Repository("OpenInfFcolDAO")
public class OpenInfFcolDAO extends EgovComAbstractDAO {


    /**
     * 리스트 출력 및 팝업정보 로드
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfLcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfLcol>) list("OpenInfFcolDAO.selectOpenInfColList", openInfSrv);
    }


    /**
     * 링크 정보 저장
     *
     * @param openInfLcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoCol(OpenInfFcol openInfFcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfFcolDAO.mergeIntoCol", openInfFcol);
    }

    /**
     * 신규등록시 INF의 Seq를 가져온다.
     *
     * @param openInfFcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectGetMstSeq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfFcolDAO.getMstSeq", openInfSrv);
    }

    /**
     * 신규등록시 SERVICE의 Seq를 가져온다.
     *
     * @param OpenInfVcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectGetInfSeq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfFcolDAO.getInfSeq", openInfSrv);
    }

    /**
     * 파일리스트 삭제
     *
     * @param openInfFcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteFcol(OpenInfFcol openInfFcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfFcolDAO.deleteFcol", openInfFcol);
    }

}
