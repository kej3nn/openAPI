package egovframework.admin.service.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfSrv;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.common.util.UtilObject;
import egovframework.common.util.UtilString;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfSrvDAO")
public class OpenInfSrvDAO extends EgovComAbstractDAO {

    /**
     * 공공데이터 목록을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfSrv> selectOpenInfListAll(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfSrv>) list("OpenInfSrvDAO.selectOpenInfListAll", openInfSrv);
    }

    /**
     * 공공데이터 목록 갯수를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenInfListAllCnt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfSrvDAO.selectOpenInfListAllCnt", openInfSrv);
    }

    /**
     * 서비스 정보를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfSrv> selectOpenInfSrvInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfSrv>) list("OpenInfSrvDAO.selectOpenInfSrvInfo", openInfSrv);
    }

    /**
     * 서비스정보를 신규, 변경한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeInto(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        if (openInfSrv.getInfSeq() == 0 || UtilObject.isNull(openInfSrv.getInfSeq())) {
            int infSeq = (Integer) getSqlMapClientTemplate().queryForObject("OpenInfSrvDAO.selectInfSeq", openInfSrv);
            openInfSrv.setInfSeq(infSeq);
        }
        return (Integer) update("OpenInfSrvDAO.mergeInto", openInfSrv);
    }

    /**
     * 현재 INF ID별로 서비스되고있는 항목들 찾아서 TB_OPEN_INF 테이블의 OPEN_SRV, CANCEL_SRV에 업데이트..
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertSrvConn(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        List tmp = list("OpenInfSrvDAO.selectSrvConn", openInfSrv);
        OpenInfSrv open = (OpenInfSrv) tmp.get(0);
        openInfSrv.setOpenSrv(open.getOpenSrv());
        openInfSrv.setCancelSrv(open.getCancelSrv());
        return (Integer) update("OpenInfSrvDAO.insertSrvConn", openInfSrv);
    }

    /**
     * 컬럼정보를 INSERT 한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertCol(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        openInfSrv.setSrvCd(UtilString.SQLInjectionFilter2(openInfSrv.getSrvCd()));
        return (Integer) update("OpenInfSrvDAO.insertCol", openInfSrv);
    }

    /**
     * 공공데이터 주석 정보를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public String selectOpenInfDsExp(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (String) selectByPk("OpenInfSrvDAO.selectOpenInfDsExp", openInfSrv);
    }

    /**
     * 공표일정을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public String selectPubDttm(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
//		   return  (String)selectByPk("OpenInfSrvDAO.selectPubDttm", openInfSrv);
        return "";
    }
}
