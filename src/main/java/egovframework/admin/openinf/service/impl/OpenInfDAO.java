package egovframework.admin.openinf.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.opendt.service.OpenCate;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenOrgUsrRel;
import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfDAO")
public class OpenInfDAO extends BaseDao {

    /**
     * 메타정보를 단건 조회 한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfList(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenInfList", openInf);
    }

    /**
     * 메타정보를 전체 조회 한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfListAll(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenInfListAll", openInf);
    }

    /**
     * 메타정보를 전체 건수를 조회  한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */

    public int selectOpenInfListAllCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectOpenInfListAllCnt", openInf);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfDsList(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenInfDsList", openInf);
    }

    public int selectOpenInfDsListCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectOpenInfDsListCnt", openInf);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfViewPopUp(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenInfViewPopUp", openInf);
    }

    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectMetaDownList(OpenInf openInf) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfDAO.selectMetaDownList", openInf);
    }

    public int getSeq(OpenInf saveVO) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.getSeq", saveVO);
    }

    public int insert(OpenInf saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.insert", saveVO);
    }

    public int update(OpenInf saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.update", saveVO);
    }

    public Object delete(OpenInf saveVO) throws DataAccessException, Exception {
        //return (Integer)update("OpenInfDAO.delete", saveVO);
        return getSqlMapClientTemplate().queryForObject("OpenInfDAO.execSpDelOpenInf", saveVO);
    }

    public int getPrssState(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.getPrssState", openInf);
    }

    public int getSrvCd(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.getSrvCd", openInf);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectExistOpenInf(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectExistOpenInf", openInf);
    }

    public int selectExistOpenInfCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectExistOpenInfCnt", openInf);
    }

    public OpenInf selectExistOpenInfDtl(OpenInf openInf) throws DataAccessException, Exception {
        return (OpenInf) selectByPk("OpenInfDAO.selectExistOpenInfDtl", openInf);
    }


    public int openInfModifyAll(OpenInf saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.openInfModifyAll", saveVO);
    }


    /**
     * 메타정보를 전체 조회 한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenHisInfListAll(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenHisInfListAll", openInf);
    }

    /**
     * 메타정보를 전체 건수를 조회  한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */

    public int selectOpenHisInfListAllCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectOpenHisInfListAllCnt", openInf);
    }

    /**
     * 메타정보를 단건 조회 한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenHisInfOne(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenHisInfOne", openInf);
    }


    /**
     * 메타정보의 변경이력을 조회한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenHisInfOneList(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenHisInfOneList", openInf);
    }

    /**
     * 메타정보의 변경이력 건수를 조회  한다.
     *
     * @param OpenInfCol
     * @return
     * @throws DataAccessException, Exception
     */

    public int selectOpenHisInfOneListCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectOpenHisInfOneListCnt", openInf);
    }


    @SuppressWarnings("unchecked")
    public OpenInf openHisInfOneDetailPopUp(OpenInf openInf) throws DataAccessException, Exception {
        return (OpenInf) selectByPk("OpenInfDAO.openHisInfOneDetailPopUp", openInf);
    }


    /**
     * 메타정보의 개방이력을 조회한다.
     *
     * @param OpenInf
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInf> openLogInfOneList(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.openLogInfOneList", openInf);
    }

    /**
     * 메타정보의 개방이력 건수를 조회  한다.
     *
     * @param OpenInf
     * @return
     * @throws DataAccessException, Exception
     */

    public int openLogInfOneListCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.openLogInfOneListCnt", openInf);
    }

    /**
     * 공공데이터 ID를 조회한다.
     *
     * @param seq
     * @return
     * @throws DataAccessException, Exception
     */
    public String getInfId(OpenInf openInf) throws DataAccessException, Exception {
        return (String) getSqlMapClientTemplate().queryForObject("OpenInfDAO.getInfId", openInf);
    }

    /**
     * 중복건수를 조회한다.
     *
     * @param saveIbs
     * @return
     * @throws DataAccessException, Exception
     */
			/*
			public int selectOrgUsrRelCnt(OpenOrgUsrRel saveIbs) throws DataAccessException, Exception {
				return (Integer)getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectOrgUsrRelCnt", saveIbs);
			}*/

    /**
     * 메타조직직원관계를 등록한다.
     *
     * @param saveIbs
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertOrgUsrRel(OpenOrgUsrRel saveIbs) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.insertOrgUsrRel", saveIbs);
    }

    /**
     * 메타조직직원관계를 업데이트한다.
     *
     * @param saveIbs
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOrgUsrRel(OpenOrgUsrRel saveIbs) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.updateOrgUsrRel", saveIbs);
    }

    /**
     * 메타조직직원관계를 삭제한다.
     *
     * @param saveIbs
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteOrgUsrRel(OpenOrgUsrRel saveIbs) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.deleteOrgUsrRel", saveIbs);
    }

    /**
     * 메타정보의 메타조직직원관계를 조회한다.
     *
     * @param openOrgUsrRel
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenOrgUsrRelList(OpenOrgUsrRel openOrgUsrRel) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfDAO.selectOpenOrgUsrRelList", openOrgUsrRel);
    }

    /**
     * 메타정보의 메타조직직원관계의 건수를 조회한다.
     *
     * @param openOrgUsrRel
     * @return
     * @throws DataAccessException, Exception
     */
			/*
			public int selectOpenOrgUsrRelListCnt(OpenOrgUsrRel openOrgUsrRel) throws DataAccessException, Exception{
				return (Integer)getSqlMapClientTemplate().queryForObject("OpenInfDAO.selectOpenOrgUsrRelListCnt", openOrgUsrRel);
			}*/

    /**
     * 메타정보의 메타조직과 직원수를 추가한다
     *
     * @param openOrgUsrRel
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInf selectOpenOrgUsrCnt(String infId) throws DataAccessException, Exception {
        return (OpenInf) selectByPk("OpenInfDAO.selectOpenOrgUsrCnt", infId);
    }

    /**
     * 메타정보의 메타조직과 직원수를 업데이트한다.
     *
     * @param openOrgUsrRel
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenOrgUsrCnt(OpenInf resultVO) throws DataAccessException, Exception {
        return update("openInfDAO.updateOpenOrgUsrCnt", resultVO);
    }

    /**
     * 태그삭제
     *
     * @param infId
     * @return
     */
    public int deleteTag(String infId) throws DataAccessException, Exception {

        return (Integer) update("OpenInfDAO.deleteTag", infId);
    }

    /**
     * 태그추가
     *
     * @param tagVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int insertTag(OpenInf tagVO) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.insertTag", tagVO);
    }

    /**
     * 태그 중복 검사
     *
     * @param tagVO
     * @return
     */
    public int tagDup(OpenInf tagVO) throws DataAccessException, Exception {

        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfDAO.tagDup", tagVO);
    }


    //////////////// img처리 DAO /////////////////////////

    /**
     * 이미지 파일 삽입
     *
     * @param openCate
     * @return
     */
    public int updateImgFile(OpenCate openCate) throws DataAccessException, Exception {

        return (Integer) update("OpenCateDAO.updateImgFile", openCate);
    }

    /**
     * 이미지 파일 삭제
     *
     * @param openCate
     * @return
     */
    public int deleteUpdateImgFile(OpenCate openCate) throws DataAccessException, Exception {

        return (Integer) update("OpenCateDAO.deleteUpdateImgFile", openCate);
    }


    @SuppressWarnings("unchecked")
    public List<OpenCate> cateImgDetailView(OpenCate opencate) throws DataAccessException, Exception {

        return (List<OpenCate>) list("OpenCateDAO.cateImgDetailView", opencate);
    }

    public int deleteImg(OpenCate opencate) throws DataAccessException, Exception {

        return (Integer) update("OpenCateDAO.deleteImg", opencate);
    }


    ///////카테고리 삽입 ////////
    public int insertCateT(OpenInf saveVO, String themeCd) throws DataAccessException, Exception {
        saveVO.settCd(themeCd);
        return (Integer) update("OpenInfDAO.insertCateT", saveVO);
    }

    public int insertCateL(OpenInf saveVO, String saCd) throws DataAccessException, Exception {
        saveVO.setlCd(saCd);
        return (Integer) update("OpenInfDAO.insertCateL", saveVO);
    }

    ///////카테고리 삭제 ////////
    public int deleteCateT(OpenInf saveVO) throws DataAccessException, Exception {

        return (Integer) update("OpenInfDAO.deleteCateT", saveVO);
    }

    public int deleteCateL(OpenInf saveVO) throws DataAccessException, Exception {

        return (Integer) update("OpenInfDAO.deleteCateL", saveVO);
    }

    public int deleteCate(OpenInf saveVO) throws DataAccessException, Exception {

        return (Integer) update("OpenInfDAO.deleteCate", saveVO);
    }
    ///

    /**
     * 메타조직직원관계를 업데이트한다.
     *
     * @param saveIbs
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeOrg(OpenOrgUsrRel saveIbs) throws DataAccessException, Exception {
        return (Integer) update("OpenInfDAO.mergeOrg", saveIbs);
    }


    //개방 버튼 공개/취소
    public Object updateInfState(Params params) throws DataAccessException, Exception {
        return update("OpenInfDAO.updateInfState", params);
    }


    public Paging selectSftOpenInfList(Params params, int page, int rows) {
        return search("OpenInfDAO.selectSftOpenInfList", params, page, rows, PAGING_SCROLL);
    }

    public Object selectSftOpenInfDtl(Params params) {
        return select("OpenInfDAO.selectSftOpenInfDtl", params);
    }

    public Object saveStfopeninf(Params params) {
        return update("OpenInfDAO.updateSftOpenInf", params);

    }

    public Object execSpBcupOpenInf(Params params) {
        return execPrc("OpenInfDAO.execSpBcupOpenInf", params);

    }

}
