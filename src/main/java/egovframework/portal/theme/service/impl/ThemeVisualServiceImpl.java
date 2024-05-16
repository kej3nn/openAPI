package egovframework.portal.theme.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.theme.service.ThemeVisualService;

@Service(value="ThemeVisualService")
public class ThemeVisualServiceImpl extends BaseService implements ThemeVisualService {
	@Resource(name="ThemeVisualDao")
	private ThemeVisualDao themeVisualDao;
	
	/**
	 * TreeMap Chart 데이터 조회
	 */
	@Override
	public Object selectTreeMapData(Params params) {
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)themeVisualDao.selectTreeMapData(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		
		for(Map<String, Object> data : dataList) {				
			
			Map<String, Object> value = new HashMap<String, Object>();
			
			//정당별 차트 색상 설정 
			if ( "더불어민주당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#357fc4");
			}else if ( "자유한국당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#dc5356");
			}else if ( "바른미래당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#36b8cf");
			}else if ( "정의당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#e8d825");
			}else if ( "민주평화당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#41af39");
			}else if ( "우리공화당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#384ce8");
			}else if ( "민중당".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#fd4e37");
			}else{
				value.put("color", "#999999");
			}
				
			
			value.put("name", data.get("name"));
			value.put("value", data.get("value"));
			
			resultList.add(value);
		}
		
		return resultList;
	}
	
	/**
	 * Column Chart 데이터 조회
	 */
	@Override
	public Object selectColumnReeleData(Params params) {
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)themeVisualDao.selectColumnReeleData(params);
		List<Object> resultList = new ArrayList<Object>();
		
		for(Map<String, Object> data : dataList) {
			List<Object> value = new ArrayList<Object>();
			
			value.add(data.get("name"));
			value.add(data.get("value"));
			
			resultList.add(value);
		}
		
		return resultList;
	}
	
	/**
	 * Pie Chart 데이터 조회
	 */
	@Override
	public Object selectPieData(Params params) {
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)themeVisualDao.selectPieData(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		
		for(Map<String, Object> data : dataList) {				
			
			Map<String, Object> value = new HashMap<String, Object>();
			
			//성별 의원현황 차트 색상 설정 
			if ( "남".equals(String.valueOf(data.get("name"))) ){
				value.put("color", "#6CB0C5");
				value.put("sliced", "true");
				value.put("selected", "true");
			}else{
				value.put("color", "#F596C2");
			}
				
			
			value.put("name", data.get("name"));
			value.put("y", data.get("value"));
			
			resultList.add(value);
		}
		
		return resultList;
	}
	
	/**
	 * Column Chart 데이터 조회
	 */
	@Override
	public Object selectColumnAgeData(Params params) {
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)themeVisualDao.selectColumnAgeData(params);
		List<Object> resultList = new ArrayList<Object>();
		
		for(Map<String, Object> data : dataList) {
			List<Object> value = new ArrayList<Object>();
			
			value.add(data.get("name"));
			value.add(data.get("value"));
			
			resultList.add(value);
		}
		
		return resultList;
	}

	/**
	 * 정당 및 교섭단체 정보 데이터 조회
	 */
	@Override
	public Object selectHgNumSeat(Params params) {
		return themeVisualDao.selectHgNumSeat(params);
	}
	
	/**
	 * Parliament Chart 데이터 조회
	 */
	@Override
	public Object selectParliamentData(Params params) {
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)themeVisualDao.selectTreeMapData(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		
		for(Map<String, Object> data : dataList) {				
			
			Map<String, Object> value = new HashMap<String, Object>();
				
			// 공통코드(A8015)에 색상이 없을시 색상 랜덤 생성
			Random rand = new Random();
			int randNum = rand.nextInt(0xffffff + 1);
			String colorCode = String.format("#%06x", randNum);
			
			value.put("name", data.get("name"));
			value.put("y", data.get("value"));
			value.put("label", data.get("name"));
			
			if( "null".equals(String.valueOf(data.get("color")))){
				value.put("color", colorCode); 
			}else{
				value.put("color", data.get("color"));
			}
			
			resultList.add(value);
		}
		
		return resultList;
	}
}
