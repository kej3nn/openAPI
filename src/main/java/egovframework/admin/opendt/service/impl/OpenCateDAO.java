package egovframework.admin.opendt.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.opendt.service.OpenCate;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 분류정보 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */
@Repository("OpenCateDAO")
public class OpenCateDAO extends EgovComAbstractDAO {

    /**
     * 분류항목을 전체 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenCate> selectOpenCateListAllMainTree(OpenCate openCate)
            throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.selectOpenCateListAllMainTree", openCate);
    }

    /**
     * 분류항목의 전체 건수를 조회 한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenCateListAllCnt(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject(
                "OpenCateDAO.selectOpenCateListAllCnt", openCate);
    }

    /**
     * 상세분류의 하위 트리를 전체 조회한다.
     *
     * @param OpenCate
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenCate> selectOpenCateListSubTree(OpenCate openCate)
            throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.selectOpenCateListSubTree", openCate);
    }

    /**
     * 상세분류의 하위 트리의 건수를 조회한다
     *
     * @param OpenCate
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenCateListSubTreeAllCnt(OpenCate openCate)
            throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject(
                "OpenCateDAO.selectOpenCateListSubTreeAllCnt", openCate);
    }

    /**
     * 분류항목을 단건 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
	/*public OpenCate selectOpenCateOne(OpenCate openCate) throws DataAccessException, Exception {
		return (OpenCate) selectByPk("OpenCateDAO.selectOpenCateOne", openCate);
	}*/
    @SuppressWarnings("unchecked")
    public List<OpenCate> selectOpenCateOne(OpenCate openCate) throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.selectOpenCateOne", openCate);
    }

    /**
     * 분류항목을 순서를 변경 한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOrderby(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) update("OpenCateDAO.updateOrderby", openCate);
    }

    /**
     * 분류항목 중복을 체크한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenCateCheckDup(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject(
                "OpenCateDAO.selectOpenCateCheckDup", openCate);
    }

    /**
     * 분류항목을 삭제 한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int delete(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) delete("OpenCateDAO.delete", openCate);
    }

    /**
     * 분류관리를 변경, 저장한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeInto(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) update("OpenCateDAO.mergeInto", openCate);
    }

    /**
     * 분류관리를 변경, 저장한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int updOpenCateLvl(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) update("OpenCateDAO.updOpenCateLvl", openCate);
    }

    /**
     * 분류관리 하위 사용여부를 업데이트 한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateUseYn(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) update("OpenCateDAO.updateUseYn", openCate);
    }

    /**
     * 상위분류를 전체 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenCate> selectOpenCateParListTree(OpenCate openCate)
            throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.selectOpenCateParListTree", openCate);
    }

    /**
     * 상위분류의 정보를 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public OpenCate selectOpenCateParNm(OpenCate openCate)
            throws DataAccessException, Exception {
        return (OpenCate) getSqlMapClientTemplate().queryForObject("OpenCateDAO.selectOpenCateParNm", openCate);
    }

    /**
     * 해당 분류의 하위분류를 전체 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenCate> checkUnderLvlCate(OpenCate openCate)
            throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.checkUnderLvlCate", openCate);
    }

    /**
     * 해당 분류의 cateFullNm,cateFullnmEng가 변경될시
     * 하위분류의 해당 컬럼도 변경하기 위해 변경해야할 컬럼과 param을 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenCate> getCateFullNmQuery(OpenCate openCate)
            throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.getCateFullNmQuery", openCate);
    }

    /**
     * 해당 분류의 cateFullNm,cateFullnmEng가 변경될시
     * 하위분류의 해당 컬럼도 변경하기 위해 조회된 data로 해당 컬럼의 값을 변경한다.
     *
     * @param OpenCate
     * @return int
     * @throws DataAccessException, Exception
     */
    public int actCateFullNmUpd(OpenCate openCate) throws DataAccessException, Exception {
        return (Integer) update("OpenCateDAO.actCateFullNmUpd", openCate);
    }

    /**
     * 해당 분류의 CateIdTop을 구한다.
     *
     * @param OpenCate
     * @return int
     * @throws DataAccessException, Exception
     */
    public String selectOpenCateIdTop(OpenCate openCate) throws DataAccessException, Exception {
        return (String) selectByPk("OpenCateDAO.selectOpenCateIdTop", openCate);
    }


    /**
     * 분류항목을 전체 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenCate> selectOpenCateTop()
            throws DataAccessException, Exception {
        return (List<OpenCate>) list("OpenCateDAO.selectOpenCateTop", "");
    }

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


}
