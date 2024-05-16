package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statSttsDscnDao")
public class StatSttsDscnDao extends BaseDao {

	/**
	 * 연계설정정보 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectSttsDscnList(Params params) {
		return list("StatSttsDscnDao.selectSttsDscnList", params);
	}
	
	/**
	 * 연계설정정보 데이터 저장(CUD)
	 * @param params
	 * @return
	 */
	public Object saveSttsDscn(List<Record> list) {
		return update("StatSttsDscnDao.saveSttsDscn", list);
	}

	/**
	 * 연계설정정보 데이터 삭제
	 * @param list
	 * @return
	 */
	public Object deleteSttsDscn(List<Record> list) {
		return delete("StatSttsDscnDao.deleteSttsDscn", list);
	}
	
}
