package egovframework.admin.service.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfTcol;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfTcolDAO")
public class OpenInfTcolDAO extends EgovComAbstractDAO {

    /**
     * 통계 Sheet 컬럼을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfTcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfTcol>) list("OpenInfTcolDAO.selectOpenInfColList", openInfSrv);
    }

    /**
     * 통계 Sheet 컬럼을 저장, 수정한다.
     *
     * @param openInfTcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoCol(OpenInfTcol openInfTcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfTcolDAO.mergeIntoCol", openInfTcol);
    }

    /**
     * 통계 Sheet 컬럼 리스틀 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfTcol selectOpenInfColInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfTcol) selectByPk("OpenInfTcolDAO.selectOpenInfColInfo", openInfSrv);
    }

    /**
     * 욥션 컬럼을 변경한다.
     *
     * @param openInfTcol
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpt(OpenInfTcol openInfTcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfTcolDAO.updateOpt", openInfTcol);
    }

    /**
     * 미리보기 항목을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfSrv selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfSrv) selectByPk("OpenInfTcolDAO.selectOpenInfColViewPopInfo", openInfSrv);
    }

    /**
     * 메타데이터 리스트 건수를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMetaListCnt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfTcolDAO.selectMetaListCnt", openInfSrv);
    }

    /**
     * 메타데이터를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectMetaListAll(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfTcolDAO.selectMetaListAll", openInfSrv);
    }

    /**
     * 메타데이터 총건수를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMetaListAllCnt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfTcolDAO.selectMetaListAllCnt", openInfSrv);
    }

    /**
     * 메타데이터의 시작년도와 마지막년도를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfTcol selectMetaStartEndDateYy(OpenInfSrv openInfSrv) throws DataAccessException, Exception {

        return (OpenInfTcol) selectByPk("OpenInfTcolDAO.selectMetaStartEndDateYy", openInfSrv);
    }

    /**
     * 메타데이터의 select 컬럼을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfTcol> selectSelectCol(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfTcol>) list("OpenInfTcolDAO.selectSelectCol", openInfSrv);
    }

    /**
     * 메타데이터의 조회조건 컬럼을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfTcol> selectWhereCol(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfTcol>) list("OpenInfTcolDAO.selectWhereCol", openInfSrv);
    }

    /**
     * 메타데이터의 시작월과 마지막월을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfTcol selectMetaStartEndDateMm(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfTcol) selectByPk("OpenInfTcolDAO.selectMetaStartEndDateMm", openInfSrv);
    }

    /**
     * 메타데이터의 시작분기와 마지막분기를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfTcol selectMetaStartEndDateQq(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfTcol) selectByPk("OpenInfTcolDAO.selectMetaStartEndDateQq", openInfSrv);
    }

    /**
     * 통계항목의 상세를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, String>> selectItemDtl(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, String>>) list("OpenInfTcolDAO.selectItemDtl", openInfSrv);
    }

    /**
     * 단위를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, String>> selectItemUnitCd(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, String>>) list("OpenInfTcolDAO.selectItemUnitCd", openInfSrv);
    }

    /**
     * 단위를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, String>> selectItemUnitCd2(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, String>>) list("OpenInfTcolDAO.selectItemUnitCd2", openInfSrv);
    }
}
