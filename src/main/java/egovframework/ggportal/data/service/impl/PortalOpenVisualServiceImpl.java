package egovframework.ggportal.data.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.data.service.PortalOpenVisualService;

/**
 * 데이터 시각화 서비스
 * @author hsJang
 *
 */
@Service("ggportalOpenVisualService")
public class PortalOpenVisualServiceImpl implements PortalOpenVisualService{

	@Resource(name = "ggportalOpenVisualDao")
	private PortalOpenVisualDao portalOpenVisualDao;

	/**
	 * 데이터 시각화 목록 조회
	 */
	@Override
	public Paging searchListVisual(Params params) {
		return portalOpenVisualDao.searchListVisual(params, params.getPage(), params.getRows());
	}
	
	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 BEGIN
	/**
	 * 데이터 시각화 메타정보를 조회한다.
	 * 
	 * @param params 파라메터
	 * @return 조회결과
	 */
	public Record selectVisualMeta(Params params) {
		// 데이터 시각화 메타정보를 조회한다.
		return portalOpenVisualDao.selectVisualMeta(params);
	}
	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 END
	
	/**
	 * 데이터 시각화 상세 정보 조회
	 */
	@Override
	public Object selectVisualData(Params params) {
		return portalOpenVisualDao.selectVisualData(params);
	}


}
