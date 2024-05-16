package egovframework.admin.mainmng.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.mainmng.service.MainMngOrder;
import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.common.base.model.Params;

@Repository("mainMngDAO")
public class MainMngDAO extends EgovComAbstractDAO {
	
	public List<Map<String, Object>> selectListCate() {
		return (List<Map<String, Object>>) list("MainMngDAO.selectListCate", null);
	}
	
	public int updateCateOrder(OpenMetaOrder vo) {
		return (Integer) update("MainMngDAO.updateCateOrder", vo);
	}

	public List<Map<String, Object>> selectListMainMng(Params params) {
		return (List<Map<String, Object>>) list("MainMngDAO.selectListMainMng", params);
	}
	
	public int saveMainMngData(Map params) {
		return update("MainMngDAO.saveMainMngData", params);
	}
	
	public int updateMainMngOrder(MainMngOrder vo) {
		return (Integer) update("MainMngDAO.updateMainMngOrder", vo);
	}
	
	public void deleteMainMng(String seqceNo) {
		delete("MainMngDAO.deleteMainMng", seqceNo);
	}
	
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
		return (List<OpenMetaOrder>) list("MainMngDAO.selectOpenCateListAllMainTree", openMetaOrder);
	}
	
	/**
	 * 메타순서를 변경 한다.
	 * 
	 * @param OpenCate
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int updateOrderby(OpenMetaOrder openMetaOrder) throws DataAccessException, Exception {
		return (Integer) update("MainMngDAO.updateOrderby", openMetaOrder);
	}
}
