package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 분류정보 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */
@Repository("OpenMetaOrderDAO")
public class OpenMetaOrderDAO extends EgovComAbstractDAO {

    /**
     * 메타순서를 전체 조회한다.
     *
     * @param OpenMetaOrder
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenMetaOrder> selectOpenMetaOrderListAllMainTree(OpenMetaOrder openMetaOrder)
            throws DataAccessException, Exception {
        return (List<OpenMetaOrder>) list("OpenMetaOrderDAO.selectOpenCateListAllMainTree", openMetaOrder);
    }


    /**
     * 메타순서를 변경 한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOrderby(OpenMetaOrder openMetaOrder) throws DataAccessException, Exception {
        return (Integer) update("OpenMetaOrderDAO.updateOrderby", openMetaOrder);
    }


}
