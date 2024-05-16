package egovframework.ggportal.data.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 우리 지역 데이터 찾기 DAO
 * @author 장홍식
 *
 */
@Repository("ggportalOpenInfVillageDao")
public class PortalOpenInfVillageDao extends BaseDao {

	/**
	 * 시 목록 데이터 조회
	 */
	public List<?> selectListCityData() throws DataAccessException, Exception{
		return search("PortalOpenInfVillageDao.selectListCityData");
	}
	
	/**
	 * SIGUN_CD 컬럼 유무 확인
	 */
	public Record selectSigunCdYn(Params params) throws DataAccessException, Exception {
		return (Record)select("PortalOpenInfVillageDao.selectSigunCdYn", params);
	}
}
