package egovframework.admin.service.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfCcol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.common.util.UtilDate;
import egovframework.common.util.UtilString;

@Repository("OpenInfCcolDAO")
public class OpenInfCcolDAO extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfColList", openInfSrv);
    }

    public int mergeIntoCol(OpenInfCcol openInfCcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfCcolDAO.mergeIntoCol", openInfCcol);
    }

    public OpenInfCcol selectOpenInfColInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfCcol) selectByPk("OpenInfCcolDAO.selectOpenInfColInfo", openInfSrv);
    }

    public int updateOpt(OpenInfCcol openInfCcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfCcolDAO.updateOpt", openInfCcol);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfColViewPopInfo", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfColViewPopInfoFilt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfColViewPopInfoFilt", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfColViewPopInfoFiltDtl(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfColViewPopInfoFiltDtl", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfSrvChart(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfSrvChart", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfCcolChart(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfCcolChart", openInfSrv);
    }
//	 @SuppressWarnings("unchecked")
//	 public String getYcol(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
//		 return (String)getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.getYcol", openInfSrv);
//	 }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> getYcol(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.getYcol", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> getYcol2(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.getYcol2", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> getXcol(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.getXcol", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfColViewPopInfoCond(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfColViewPopInfoCond", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> selectOpenInfColViewPopInfoOrderBy(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.selectOpenInfColViewPopInfoOrderBy", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> getTotSeries(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.getTotSeries", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> getSeriesResult(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.getSeriesResult", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfCcol> getSeriesResult2(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfCcol>) list("OpenInfCcolDAO.getSeriesResult2", openInfSrv);
    }

    public String selectInitX(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (String) selectByPk("OpenInfCcolDAO.selectInitX", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectChartDataX(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectChartDataX", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectChartDataY(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectChartDataY", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectChartDataRY(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectChartDataRY", openInfSrv);
    }

    /**
     * 연결검색을 조회한다.
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
            openInfSrv.setQueryString((String) selectByPk("OpenInfCcolDAO.selectTvPopupCode", openInfSrv));
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeDate", openInfSrv);
        }
        if (colId.equals("OFFC_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeOffcCd", openInfSrv);
        } else if (colId.equals("FGO_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeFgoCd", openInfSrv);
        } else if (colId.equals("FSCL_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeFsclCd", openInfSrv);
        } else if (colId.equals("ACCT_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeAcctCd", openInfSrv);
        } else if (colId.equals("FLD_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeFldCd", openInfSrv);
        } else if (colId.equals("SECT_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeSectCd", openInfSrv);
        } else if (colId.equals("PGM_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodePgmCd", openInfSrv);
        } else if (colId.equals("ACTV_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeActvCd", openInfSrv);
        } else if (colId.equals("IKWAN_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeIkwanCd", openInfSrv);
        } else if (colId.equals("IHANG_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeIhangCd", openInfSrv);
        } else if (colId.equals("IMOK_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeImokCd", openInfSrv);
        } else if (colId.equals("CITM_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeCitmCd", openInfSrv);
        } else if (colId.equals("EITM_CD")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeEitmCd", openInfSrv);
        } else if (colId.equals("FSCL_YM")) {
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeFsclYm", openInfSrv);
        } else {
            openInfSrv.setQueryString((String) selectByPk("OpenInfCcolDAO.selectTvPopupCode", openInfSrv));
            return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectTvPopupCodeDate", openInfSrv);
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
            openInfSrv.setQueryString((String) selectByPk("OpenInfCcolDAO.selectTvPopupCode", openInfSrv));
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeDateCnt", openInfSrv);
        }
        if (colId.equals("OFFC_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeOffcCdCnt", openInfSrv);
        } else if (colId.equals("FGO_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeFgoCdCnt", openInfSrv);
        } else if (colId.equals("FSCL_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeFsclCdCnt", openInfSrv);
        } else if (colId.equals("ACCT_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeAcctCdCnt", openInfSrv);
        } else if (colId.equals("FLD_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeFldCdCnt", openInfSrv);
        } else if (colId.equals("SECT_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeSectCdCnt", openInfSrv);
        } else if (colId.equals("PGM_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodePgmCdCnt", openInfSrv);
        } else if (colId.equals("ACTV_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeActvCdCnt", openInfSrv);
        } else if (colId.equals("IKWAN_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeIkwanCdCnt", openInfSrv);
        } else if (colId.equals("IHANG_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeIhangCdCnt", openInfSrv);
        } else if (colId.equals("IMOK_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeImokCdCnt", openInfSrv);
        } else if (colId.equals("CITM_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeCitmCdCnt", openInfSrv);
        } else if (colId.equals("EITM_CD")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeEitmCdCnt", openInfSrv);
        } else if (colId.equals("FSCL_YM")) {
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeFsclYmCnt", openInfSrv);
        } else {
            openInfSrv.setQueryString((String) selectByPk("OpenInfCcolDAO.selectTvPopupCode", openInfSrv));
            return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectTvPopupCodeDateCnt", openInfSrv);
        }
    }

    /**
     * 재정정보 여부를 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfCcol selectOpenInfFsYn(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfCcol) getSqlMapClientTemplate().queryForObject("OpenInfCcolDAO.selectOpenInfFsYn", openInfSrv);
    }

    public String selectOptFiltNm(OpenInfCcol OpenInfCcol) throws DataAccessException, Exception {
        return (String) selectByPk("OpenInfCcolDAO.selectOptFiltNm", OpenInfCcol);
    }

    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectMetaListAll(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfCcolDAO.selectMetaListAll", openInfSrv);
    }
}
