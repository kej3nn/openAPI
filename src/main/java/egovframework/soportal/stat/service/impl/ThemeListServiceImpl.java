package egovframework.soportal.stat.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.service.ThemeListService;
import egovframework.soportal.stat.web.StatListController;
import egovframework.admin.stat.service.impl.StatPreviewDao;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.model.Messages;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilString;

/**
 * 통계표를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Service(value="themeListService")
public class ThemeListServiceImpl extends BaseService implements ThemeListService {
	
	@Resource(name="statListDao")
	protected StatListDao statListDao;

	@Resource(name="chartListDao")
	protected ChartListDao chartListDao;
	
	@Resource(name="themeListDao")
	protected ThemeListDao themeListDao;
	
	/**
	 * 테마통계 한눈에 보는 주택금융 리스트 조회
	 */
	public List<Object> statThemeLookList(Params params) {

		List<Map<String, Object>> jlist = themeListDao.statThemeLookList(params);
		List<Object> dataList = new ArrayList<Object>();

		int jlistCnt = jlist.size();
		for ( int i=0; i < jlistCnt; i++ ) {
			
			String statblId 	= (String) jlist.get(i).get("statblId");
			String statblNm 	= (String) jlist.get(i).get("statblNm");
			String majorNm 		= (String) jlist.get(i).get("majorNm");
			String dtaVal 		= (String) jlist.get(i).get("dtaVal");			
			String rpstuiNm 	= (String) jlist.get(i).get("rpstuiNm");
			String ditcNm 		= (String) jlist.get(i).get("ditcNm");
			String dtacycleCd 	= (String) jlist.get(i).get("dtacycleCd");
			String dtadvsCd 	= (String) jlist.get(i).get("dtadvsCd");
			BigDecimal itmDataNo = (BigDecimal) jlist.get(i).get("itmDataNo");
			BigDecimal clsDataNo = (BigDecimal) jlist.get(i).get("clsDataNo");

			//* 상세 데이터를 가져오기 위해 params에 필요한 변수를 담는다.
			params.put("statblId", statblId);
		    params.put("dtacycleCd", dtacycleCd);
		    params.put("dtadvsCd", dtadvsCd);
		    params.put("itmDataNo", itmDataNo);
		    params.put("clsDataNo", clsDataNo);
		    
		    HashMap<String, Object> jMap = new HashMap<String, Object>();
		    jMap.put("statblId", statblId);
		    jMap.put("statblNm", statblNm);
		    jMap.put("majorNm", majorNm);		    
		    jMap.put("ditcNm", ditcNm);
		    jMap.put("dtacycleCd", dtacycleCd);
	    	jMap.put("LDataDtaVal", dtaVal);		    
		    jMap.put("UiNm", "");
		    
		    //* 상세 데이터 호출
		    Map<String, Object> detailData = (Map<String, Object>) themeListDao.statThemeLookListAddData(params);
		    if(detailData != null){
			    if(detailData.get("LDataWrttimeIdtfrId") != null) jMap.put("LDataWrttimeIdtfrId", (String) detailData.get("LDataWrttimeIdtfrId")); 
			    if(dtaVal == null){
			    	if(detailData.get("LDataDtaVal") != null) jMap.put("LDataDtaVal", (BigDecimal) detailData.get("LDataDtaVal")); 
			    	if(detailData.get("UiNm") != null) jMap.put("UiNm", (String) detailData.get("UiNm")); 
			    }
		    }
		    
		    dataList.add(jMap);
		}

		return dataList;
	}
    
	/**
	 * 지도통계 조회
	 */
	public Map<String, Object> mapStatDataList(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();

		//통계자료 string[] => ibatis에서 사용하기 위해 array로 변경
		ArrayList<String> iterDtadvsVal = new ArrayList<String>(Arrays.asList(params.getStringArray("dtadvsVal")));
		params.set("iterDtadvsVal", iterDtadvsVal);
		//항목선택 string[] => ibatis에서 사용하기 위해 array로 변경
		ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
		params.set("iterChkItms", iterChkItms);
		//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
		ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
		params.set("iterChkClss", iterChkClss);
		
		rMap.put("MAP_DATA", chartListDao.statMapJson(params));
		return rMap;
	}
}
