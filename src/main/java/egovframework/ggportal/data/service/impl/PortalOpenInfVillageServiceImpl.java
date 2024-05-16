package egovframework.ggportal.data.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.ggportal.data.service.PortalOpenInfVillageService;

/**
 * 우리지역데이터찾기 서비스
 * @author 장홍식
 *
 */
@Service("ggportalOpenInfVillageService")
public class PortalOpenInfVillageServiceImpl extends BaseService implements PortalOpenInfVillageService {

	@Resource(name = "ggportalOpenInfVillageDao")
	private PortalOpenInfVillageDao portalOpenInfVillageDao;
	
	@Override
	public List<?> selectListCityData() {
		List<?> result = new ArrayList<Record>();
		try {
			result = portalOpenInfVillageDao.selectListCityData();
		}catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
}
