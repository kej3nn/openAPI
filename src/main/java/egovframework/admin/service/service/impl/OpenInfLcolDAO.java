package egovframework.admin.service.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

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
@Repository("OpenInfLcolDAO")
public class OpenInfLcolDAO extends EgovComAbstractDAO {


    /**
     * 리스트 출력
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfLcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfLcol>) list("OpenInfLcolDAO.selectOpenInfColList", openInfSrv);
    }


    /**
     * 링크 정보 저장
     *
     * @param openInfLcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoCol(OpenInfLcol openInfLcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfLcolDAO.mergeIntoCol", openInfLcol);
    }

    /**
     * 신규등록시 INF의 Seq를 가져온다.
     *
     * @param openInfFcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectGetMstSeq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfLcolDAO.getMstSeq", openInfSrv);
    }

    /**
     * 신규등록시 SERVICE의 Seq를 가져온다.
     *
     * @param OpenInfVcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectGetInfSeq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfLcolDAO.getInfSeq", openInfSrv);
    }

    /**
     * 팝업정보 로드
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfLcol> selectOpenInfColPopList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfLcol>) list("OpenInfLcolDAO.selectOpenInfColPopList", openInfSrv);
    }

    /**
     * 썸네일 이미지를 수정한다.
     *
     * @param openInfLcol
     * @return
     */
    public int updateTmnlImgFile(OpenInfLcol openInfLcol) {
        return (Integer) update("OpenInfLcolDAO.updateTmnlImgFile", openInfLcol);
    }

    /**
     * 썸네일 이미지와 링크내용을 같이 등록한다.
     *
     * @param openInfLcol
     * @return
     */
    public int insertTmnlImgFile(OpenInfLcol openInfLcol) {
        return (Integer) update("OpenInfLcolDAO.insertTmnlImgFile", openInfLcol);
    }

    /**
     * 썸네일 파일명을 조회한다.
     *
     * @param openInfSrv
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfLcol> selectOpenInfColInfo(OpenInfLcol openInfLcol) {
        return (List<OpenInfLcol>) list("OpenInfLcolDAO.selectOpenInfColInfo", openInfLcol);
    }


}
