package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenPublish;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 분류정보 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */
@Repository("OpenPublishDAO")
public class OpenPublishDAO extends EgovComAbstractDAO {

    /**
     * 공표기준 목록을 전체 조회한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenPublish> selectOpenPublishListAll(OpenPublish openPublish) throws DataAccessException, Exception {
        return (List<OpenPublish>) list("OpenPublishDAO.selectOpenPublishListAll", openPublish);
    }

    /**
     * 공표기준 목록의 전체 건수를 조회 한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenPublishListAllCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject(
                "OpenPublishDAO.selectOpenPublishListAllCnt", openPublish);
    }

    /**
     * 공표자료를 단건 조회한다.
     *
     * @param OpenPublish
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenPublish selectOpenPublishOne(OpenPublish openPublish) throws DataAccessException, Exception {
        return (OpenPublish) selectByPk("OpenPublishDAO.selectOpenPublishOne", openPublish);
    }

    /**
     * 공표자료에서 담당자 확인을 실행한다.
     *
     * @param OpenPublish
     * @return
     * @throws DataAccessException, Exception
     */
    public int openPublishPubOk(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.openPublishPubOk", openPublish);
    }

    /**
     * 공표자료를 변경한다.
     *
     * @param OpenPublish
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenPublish(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.updateOpenPublish", openPublish);
    }


    /**
     * 공표자료의 파일리스트를 출력한다.
     *
     * @param openPublish
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenPublish> openPublishFileList(OpenPublish openPublish) throws DataAccessException, Exception {
        return (List<OpenPublish>) list("OpenPublishDAO.openPublishFileList", openPublish);
    }

    /**
     * 공표자료의 파일리스트의 건수를 출력한다
     *
     * @param openPublish
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */

    public int openPublishFileListCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenPublishDAO.openPublishFileListCnt", openPublish);
    }


    /**
     * 파일 정보 저장
     *
     * @param openPublish
     * @return
     * @throws DataAccessException, Exception
     */
    public int saveOpenPublishFileCUD(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.saveOpenPublishFileCUD", openPublish);
    }

    /**
     * 공표자료 목록을 전체 조회한다.(포털에서 사용)
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenPublish> selectOpenPublishList(OpenPublish openPublish) throws DataAccessException, Exception {
        return (List<OpenPublish>) list("OpenPublishDAO.selectOpenPublishList", openPublish);
    }


    /**
     * 공표자료가 존재하는 연도리스트를 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<String> selectOpenPublishYearsList(OpenPublish openPublish) throws DataAccessException, Exception {
        return (List<String>) list("OpenPublishDAO.selectOpenPublishYearsList", openPublish);
    }

    /**
     * 공표자료를 상세 조회한다
     *
     * @param OpenPubCfg
     * @param model
     * @return OpenPublish
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public OpenPublish selectOpenPublishDetail(OpenPublish openPublish) throws DataAccessException, Exception {
        return (OpenPublish) getSqlMapClientTemplate().queryForObject("OpenPublishDAO.selectOpenPublishDetail", openPublish);
    }

    /**
     * 해당 공표자료의 관련 파일리스트를 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<String> selectOpenPublishFileList(OpenPublish openPublish) throws DataAccessException, Exception {
        return (List<String>) list("OpenPublishDAO.openPublishFileList", openPublish);
    }


    /**
     * 관련 데이터셋과 동일한 ID를 가진 재정정보 목록을 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenPublish> selectRefDsList(OpenPublish openPublish) throws DataAccessException, Exception {
        return (List<OpenPublish>) list("OpenPublishDAO.selectRefDsList", openPublish);
    }

    /**
     * 공표자료 조회수를 1 증가한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return Integer
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public void updateViewCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        update("OpenPublishDAO.updateViewCnt", openPublish);
    }


    public int getFileSeq(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenPublishDAO.getFileSeq", openPublish);
    }

    public int insertOpenpublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.insertOpenpublishFile", openPublish);
    }

    public int updateOpenpublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.updateOpenpublishFile", openPublish);
    }

    public int deleteUpdateOpenPublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.deleteUpdateOpenPublishFile", openPublish);
    }

    public int getFileCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenPublishDAO.getFileCnt", openPublish);
    }

    public int updateFileCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.updateFileCnt", openPublish);
    }


    public int getPublishFileSeq(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenPublishDAO.getPublishFileSeq", openPublish);
    }

    public int insertPublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.insertPublishFile", openPublish);
    }

    public int updatePublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.updatePublishFile", openPublish);
    }

    public int deleteUpdatePublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.deleteUpdatePublishFile", openPublish);
    }

    public int deletePublishFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.deletePublishFile", openPublish);
    }

    public int mergeIntoFile(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.mergeIntoFile", openPublish);
    }

    public int getPublishFileCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenPublishDAO.getPublishFileCnt", openPublish);
    }

    public int updatePublishFileCnt(OpenPublish openPublish) throws DataAccessException, Exception {
        return (Integer) update("OpenPublishDAO.updatePublishFileCnt", openPublish);
    }


}
