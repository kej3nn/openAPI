package egovframework.admin.infset.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 정보셋 순서를 관리하는 DB접근 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/18
 */
@Repository(value="infSetOrderDao")
public class InfSetOrderDao extends BaseDao {

	/**
	 * 정보셋 순서 목록 조회
	 */
	public List<?> selectInfSetOrderList(Params params) {
		return list("InfSetOrderDao.selectInfSetOrderList", params);
	}
	
	/**
	 * 정보셋 순서 저장
	 */
	public Object saveInfSetOrder(Record record) {
		return update("InfSetOrderDao.saveInfSetOrder", record);
	}
}
