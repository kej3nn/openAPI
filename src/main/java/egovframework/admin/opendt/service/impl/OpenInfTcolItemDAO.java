package egovframework.admin.opendt.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.opendt.service.OpenInfTcolItem;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 통계항목 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfTcolItemDAO")
public class OpenInfTcolItemDAO extends EgovComAbstractDAO {

    /**
     * 통계항목 상위를 전체 조회 한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */

    @SuppressWarnings("unchecked")
    public List<OpenInfTcolItem> selectTcolItemParListAll(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (List<OpenInfTcolItem>) list("OpenInfTcolItemDAO.selectTcolItemParListAll", openInfTcolItem);
    }

    /**
     * 통계항목 상위에 전체 건수를 조회  한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */

    public int selectTcolItemParListAllCnt(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfTcolItemDAO.selectTcolItemParListAllCnt", openInfTcolItem);
    }

    /**
     * 통계항목을 상위 순서 max값을 구한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenInfTcolParOrderBy(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfTcolItemDAO.selectOpenInfTcolParOrderBy", openInfTcolItem);
    }

    /**
     * 통계항목을 변경, 저장한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int mergeInto(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) update("OpenInfTcolItemDAO.mergeInto", openInfTcolItem);
    }

    /**
     * 통계항목을 삭제 한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int delete(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) delete("OpenInfTcolItemDAO.delete", openInfTcolItem);
    }

    /**
     * 통계항목 중복을 체크한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectCheckDup(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfTcolItemDAO.selectCheckDup", openInfTcolItem);
    }


    /**
     * 통계항목 트리를 조회 한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */

    @SuppressWarnings("unchecked")
    public List<OpenInfTcolItem> selectTcolItemListTree(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (List<OpenInfTcolItem>) list("OpenInfTcolItemDAO.selectTcolItemListTree", openInfTcolItem);
    }


    /**
     * 통계항목 순서를 조회한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */

    public int selectOpenInfTcolOrderBy(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfTcolItemDAO.selectOpenInfTcolOrderBy", openInfTcolItem);
    }

    /**
     * 통계항목을 순서를 변경 한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOrderby(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) update("OpenInfTcolItemDAO.updateOrderby", openInfTcolItem);
    }

    /**
     * 통계항목 하위 사용여부를 업데이트 한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateUseYn(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) update("OpenInfTcolItemDAO.updateUseYn", openInfTcolItem);
    }

    /**
     * 통계 항목를 단건 조회 한다.
     *
     * @param CommUsr
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfTcolItem selectOpenInfTcolItemList(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (OpenInfTcolItem) selectByPk("OpenInfTcolItemDAO.selectOpenInfTcolItemList", openInfTcolItem);
    }

    /**
     * 통계 항목를 상위 항목명 조회 한다.
     *
     * @param CommUsr
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenInfTcolItem selectOpenInfTcolItemPrnItemNm(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (OpenInfTcolItem) selectByPk("OpenInfTcolItemDAO.selectOpenInfTcolItemPrnItemNm", openInfTcolItem);
    }

    /**
     * 통계항목 상위레벨을 업데이트 한다.
     *
     * @param openInfTcolItem
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateParItemNm(OpenInfTcolItem openInfTcolItem) throws DataAccessException, Exception {
        return (Integer) update("OpenInfTcolItemDAO.updateParItemNm", openInfTcolItem);
    }
}
