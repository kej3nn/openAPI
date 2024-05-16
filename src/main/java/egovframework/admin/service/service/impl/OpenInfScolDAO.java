package egovframework.admin.service.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfScol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.impl.helper.OpenInfRowHandler;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.common.util.UtilDate;
import egovframework.common.util.UtilString;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfScolDAO")
public class OpenInfScolDAO extends EgovComAbstractDAO {


    /**
     * sheet 컬럼 리스트를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColList", openInfSrv);
    }

    /**
     * Sheet 컬럼 리스틀 저장, 변경한다.
     *
     * @param openInfScol
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeIntoCol(OpenInfScol openInfScol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfScolDAO.mergeIntoCol", openInfScol);
    }

    /**
     * Sheet컬럼 정보를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfScol selectOpenInfColInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfScol) selectByPk("OpenInfScolDAO.selectOpenInfColInfo", openInfSrv);
    }

    /**
     * 옵션항목을 설정한다.
     *
     * @param openInfScol
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpt(OpenInfScol openInfScol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfScolDAO.updateOpt", openInfScol);
    }

    /**
     * 미리보기 항목을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColViewPopInfo", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColViewPopInfoType(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColViewPopInfoType", openInfSrv);
    }

    /**
     * 미리보기 항목을 IbSheet형태로 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, String>> selectOpenInfColViewPopInfoIbs(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, String>>) list("OpenInfScolDAO.selectOpenInfColViewPopInfoIbs", openInfSrv);
    }

    /**
     * 조회조건을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColViewPopInfoFilt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColViewPopInfoFilt", openInfSrv);
    }

    /**
     * 조회조건 상세를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColViewPopInfoFiltDtl(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColViewPopInfoFiltDtl", openInfSrv);
    }

    /**
     * select 절을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColViewPopInfoCond(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColViewPopInfoCond", openInfSrv);
    }

    /**
     * where절을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfScol> selectOpenInfColViewPopInfoOrderBy(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfScol>) list("OpenInfScolDAO.selectOpenInfColViewPopInfoOrderBy", openInfSrv);
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
        return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectMetaListAll", openInfSrv);
    }


    /**
     * 메타데이터를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public void selectMetaListAll2(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        OpenInfRowHandler row = new OpenInfRowHandler();
        getSqlMapClientTemplate().queryWithRowHandler("OpenInfScolDAO.selectMetaListAll2", openInfSrv, row);
    }

    /**
     * sheet 연결검색을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectTvPopupCode(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        String colId = UtilString.null2Blank(openInfSrv.getPopColId());

        if (openInfSrv.getFsclYy().equals("1900")) {
            openInfSrv.setFsclYy(UtilDate.getCurrentYear() + "");
        }
        if (!UtilString.null2Blank(openInfSrv.getFsYn()).equals("Y")) {
            openInfSrv.setQueryString((String) selectByPk("OpenInfScolDAO.selectTvPopupCode", openInfSrv));
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeDate", openInfSrv);
        }
        openInfSrv.setConnWhere((String) selectByPk("OpenInfScolDAO.selectTvPopupWhere", openInfSrv));
        if (colId.equals("OFFC_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeOffcCd", openInfSrv);
        } else if (colId.equals("FGO_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeFgoCd", openInfSrv);
        } else if (colId.equals("FSCL_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeFsclCd", openInfSrv);
        } else if (colId.equals("FSCL2_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeFsclCd2", openInfSrv);
        } else if (colId.equals("ACCT_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeAcctCd", openInfSrv);
        } else if (colId.equals("FLD_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeFldCd", openInfSrv);
        } else if (colId.equals("SECT_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeSectCd", openInfSrv);
        } else if (colId.equals("PGM_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodePgmCd", openInfSrv);
        } else if (colId.equals("ACTV_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeActvCd", openInfSrv);
        } else if (colId.equals("IKWAN_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeIkwanCd", openInfSrv);
        } else if (colId.equals("IHANG_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeIhangCd", openInfSrv);
        } else if (colId.equals("IMOK_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeImokCd", openInfSrv);
        } else if (colId.equals("CITM_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeCitmCd", openInfSrv);
        } else if (colId.equals("EITM_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeEitmCd", openInfSrv);
        } else if (colId.equals("FSCL_YM")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeFsclYm", openInfSrv);
        } else if (colId.equals("ORG_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeOrgCd", openInfSrv);
        } else if (colId.equals("MPB_FSCL_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeMpbFsclCd", openInfSrv);
        } else if (colId.equals("MPB_ACCT_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeMpbAcctCd", openInfSrv);
        } else {
            openInfSrv.setQueryString((String) selectByPk("OpenInfScolDAO.selectTvPopupCode", openInfSrv));
            return (List<LinkedHashMap<String, ?>>) list("OpenInfScolDAO.selectTvPopupCodeDate", openInfSrv);
        }


    }

    /**
     * Sheet 연결검색 건수를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectTvPopupCodeCnt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {

        String colId = UtilString.null2Blank(openInfSrv.getPopColId());

        if (openInfSrv.getFsclYy().equals("1900")) {
            openInfSrv.setFsclYy(UtilDate.getCurrentYear() + "");
        }

        if (!UtilString.null2Blank(openInfSrv.getFsYn()).equals("Y")) {
            openInfSrv.setQueryString((String) selectByPk("OpenInfScolDAO.selectTvPopupCode", openInfSrv));
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeDateCnt", openInfSrv);
        }
        openInfSrv.setConnWhere((String) selectByPk("OpenInfScolDAO.selectTvPopupWhere", openInfSrv));//
        if (colId.equals("OFFC_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeOffcCdCnt", openInfSrv);
        } else if (colId.equals("FGO_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeFgoCdCnt", openInfSrv);
        } else if (colId.equals("FSCL_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeFsclCdCnt", openInfSrv);
        } else if (colId.equals("FSCL2_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeFsclCdCnt2", openInfSrv);
        } else if (colId.equals("ACCT_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeAcctCdCnt", openInfSrv);
        } else if (colId.equals("FLD_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeFldCdCnt", openInfSrv);
        } else if (colId.equals("SECT_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeSectCdCnt", openInfSrv);
        } else if (colId.equals("PGM_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodePgmCdCnt", openInfSrv);
        } else if (colId.equals("ACTV_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeActvCdCnt", openInfSrv);
        } else if (colId.equals("IKWAN_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeIkwanCdCnt", openInfSrv);
        } else if (colId.equals("IHANG_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeIhangCdCnt", openInfSrv);
        } else if (colId.equals("IMOK_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeImokCdCnt", openInfSrv);
        } else if (colId.equals("CITM_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeCitmCdCnt", openInfSrv);
        } else if (colId.equals("EITM_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeEitmCdCnt", openInfSrv);
        } else if (colId.equals("FSCL_YM")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeFsclYmCnt", openInfSrv);
        } else if (colId.equals("ORG_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeOrgCdCnt", openInfSrv);
        } else if (colId.equals("MPB_FSCL_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeMpbFsclCdCnt", openInfSrv);
        } else if (colId.equals("MPB_ACCT_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeMpbAcctCdCnt", openInfSrv);
        } else {
            openInfSrv.setQueryString((String) selectByPk("OpenInfScolDAO.selectTvPopupCode", openInfSrv));
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectTvPopupCodeDateCnt", openInfSrv);
        }
    }

    /**
     * 재정정보 여부를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfScol selectOpenInfFsYn(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfScol) getSqlMapClientTemplate().queryForObject("OpenInfScolDAO.selectOpenInfFsYn", openInfSrv);
    }

    public String selectOptFiltNm(OpenInfScol OpenInfScol) throws DataAccessException, Exception {
        return (String) selectByPk("OpenInfScolDAO.selectOptFiltNm", OpenInfScol);
    }


}
