package egovframework.admin.service.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfVcolDAO")
public class OpenInfVcolDAO extends EgovComAbstractDAO {


    /**
     * 리스트 출력
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfVcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfVcol>) list("OpenInfVcolDAO.selectOpenInfColList", openInfSrv);
    }


    /**
     * 링크 정보 저장
     *
     * @param openInfVcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoCol(OpenInfVcol openInfVcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfVcolDAO.mergeIntoCol", openInfVcol);
    }

    /**
     * 신규등록시 INF의 Seq를 가져온다.
     *
     * @param openInfFcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectGetMstSeq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfVcolDAO.getMstSeq", openInfSrv);
    }

    /**
     * 신규등록시 SERVICE의 Seq를 가져온다.
     *
     * @param OpenInfVcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectGetInfSeq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfVcolDAO.getInfSeq", openInfSrv);
    }

    /**
     * 팝업정보 로드
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfVcol> selectOpenInfColPopList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfVcol>) list("OpenInfVcolDAO.selectOpenInfColPopList", openInfSrv);
    }

    /**
     * 썸네일 이미지를 수정한다.
     *
     * @param openInfVcol
     * @return
     */
    public int updateTmnlImgFile(OpenInfVcol openInfVcol) {
        return (Integer) update("OpenInfVcolDAO.updateTmnlImgFile", openInfVcol);
    }

    /**
     * 썸네일 파일명을 조회한다.
     *
     * @param openInfSrv
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfVcol> selectOpenInfColInfo(OpenInfVcol openInfVcol) {
        return (List<OpenInfVcol>) list("OpenInfVcolDAO.selectOpenInfColInfo", openInfVcol);
    }
}
