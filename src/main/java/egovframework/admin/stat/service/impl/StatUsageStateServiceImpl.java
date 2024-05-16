package egovframework.admin.stat.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatUsageStateService;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

/**
 * 관리자 통계활용 현황 서비스 구현체
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2018/01/26
 */

@Service(value="statUsageStateService")
public class StatUsageStateServiceImpl extends BaseService implements StatUsageStateService {

	@Resource(name="statUsageStateDao")
	protected StatUsageStateDao statUsageStateDao;
	
    private static final Map<String, String> CHART_SERIES_NMS;
    static {
        Map<String, String> record = new LinkedHashMap<String, String>();
        record.put("useCnt", "통계메타");
        record.put("statblCnt", "통계표");
        record.put("excelCnt", "Excel다운");
        record.put("csvCnt", "CSV다운타");
        record.put("jsonCnt", "JSON다운");
        record.put("xmlCnt", "XML다운");
        record.put("txtCnt", "TXT다운");
        CHART_SERIES_NMS = Collections.unmodifiableMap(record);
    }

	/**
	 * 통계 활용현황 리스트 조회
	 */
	public List<Record> statUsageStateList(Params params) {
		return (List<Record>) statUsageStateDao.selectStatUsageState(params);
	}
	
	/**
	 * 메뉴별 활용현황 리스트 조회
	 */
	public List<Record> menuUsageStateList(Params params) {
		return (List<Record>) statUsageStateDao.selectMenuUsageState(params);
	}
	
	/**
	 * 분류별 활용현황 리스트 조회
	 */
	public List<Record> cateUsageStateList(Params params) {
		return (List<Record>) statUsageStateDao.selectCateUsageState(params);
	}
	
	/**
	 * 통계표별 활용현황 리스트 조회
	 */
	public List<Record> statblUsageStateList(Params params) {
		return (List<Record>) statUsageStateDao.selectStatblUsageState(params);
	}
	
	/**
	 * 출처별 활용현황 리스트 조회
	 */
	public List<Record> orgUsageStateList(Params params) {
		return (List<Record>) statUsageStateDao.selectOrgUsageState(params);
	}

	@Override
	public Record statUsageStateChart(Params params) {
		/*int idx = 0;
		Record rtn = new Record();
		
		LinkedList<Record> list = new LinkedList<Record>();
		Record row = null;
		
		List<Record> usageList = (List<Record>) statUsageStateDao.selectStatUsageState(params);
		
		for ( Record usage : usageList ) {
			row = new Record();
			row.put("AxisLabel", usage.getString("yyyymmdd"));
			
			List<Record> series = new ArrayList<Record>();
			for ( Object key : usage.keySet() ) {
				if ( !String.valueOf(key).equals("yyyymmdd") ) {
					Record seriesRow = new Record();
					seriesRow.put("seriesName", CHART_SERIES_NMS.get(String.valueOf(key)));
					seriesRow.put("value", usage.getInt(String.valueOf(key)));
					series.add(seriesRow);
				}
			}
			row.put("series", series);
			
			idx = 0;
			list.add(row);
		}
		
		rtn.put("Data", list);
		
		return rtn;*/
		
		Record record = new Record();
		List<Record> chartXList = new ArrayList<Record>();
		List<Record> chartYList = new ArrayList<Record>();
		List<Record> usageList = (List<Record>) statUsageStateDao.selectStatUsageState(params);
		
		for ( Record usage : usageList ) {
			Record chartX = new Record();
			Record chartY = new Record();
			chartX.put("YYYYMMDD", usage.getString("yyyymmdd"));
			chartXList.add(chartX);
			
			for ( Object key : usage.keySet() ) {
				if ( !String.valueOf(key).equals("yyyymmdd") ) {
					chartY.put(String.valueOf(key), usage.getInt(String.valueOf(key)));
				}
			}
			chartYList.add(chartY);
		}
		
		record.put("chartDataX", chartXList);
		record.put("chartDataY", chartYList);
		
		return record;
		
	}
	
	/**
	 * 사용자별 로그 분석 리스트 조회
	 */
	@Override
	public Paging selectUserUsageStateListPaging(Params params) {
		
		Paging list = statUsageStateDao.selectUserUsageStateList(params, params.getPage(), params.getRows());
		
		return list;
	}
	
	/**
	 * API 호출 현황 리스트 조회
	 */
	@Override
	public Paging selectApiUsageStateListPaging(Params params) {
		
		Paging list = statUsageStateDao.selectApiUsageStateList(params, params.getPage(), params.getRows());
		
		return list;
	}
	
	public List<LinkedHashMap<String,?>> userUsageStatePie(Params params) throws DataAccessException, Exception {
        return statUsageStateDao.userUsageStatePie(params);       
}
	
	public List<LinkedHashMap<String,?>> apiUsageStateGraph(Params params) throws DataAccessException, Exception {
        return statUsageStateDao.apiUsageStateGraph(params);       
	}
	
}
