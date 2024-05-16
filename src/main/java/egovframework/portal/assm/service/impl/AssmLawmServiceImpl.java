package egovframework.portal.assm.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.assm.service.AssmLawmService;

/**
 * 국회의원 입법활동 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Service(value="AssmLawmService")
public class AssmLawmServiceImpl extends BaseService implements AssmLawmService {

	@Resource(name="AssmLawmDao")
	private AssmLawmDao assmLawmDao;

	@Override
	public List<Record> searchAssmLawmCommCd(Params params) {
		return assmLawmDao.searchAssmLawmCommCd(params);
	}

	/**
	 * 대표발의 법률안
	 */
	@Override
	public Paging searchLawmDegtMotnLgsb(Params params) {
		params.set("represent", "대표발의");
		return assmLawmDao.searchLawmMotnLgsb(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 공동발의 법률안
	 */
	@Override
	public Paging searchLawmClboMotnLgsb(Params params) {
		params.set("represent", "공동발의");
		return assmLawmDao.searchLawmMotnLgsb(params, params.getPage(), params.getRows());
	}

	/**
	 * 표결현황 조회
	 */
	@Override
	public Paging searchLawmVoteCond(Params params) {
		return assmLawmDao.searchLawmVoteCond(params, params.getPage(), params.getRows());
	}

	@Override
	public Record selectLawmVoteCondResultCnt(Params params) {
		return assmLawmDao.selectLawmVoteCondResultCnt(params);
	}
	
	/**
	 * TreeMap Chart 데이터 조회(대표발의 법률안)
	 */
	@Override
	public Object searchDegtMotnLgsbTreeMap(Params params) {
		
		params.set("represent", "대표발의");
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)assmLawmDao.searchDegtMotnLgsbTreeMap(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		String [] colors  = {"#2F7ED8", "#0D233A", "#8BBC21", "#910000", "#1AADCE", "#492970", "#F28F43", "#77A1E5", "#C42525", "#A6C96A",
		    		               "#058DC7", "#50B432", "#ED561B", "#DDDF00", "#24CBE5", "#64E572", "#FF9655", "#FFF263", "#6AF9C4",
		    		               "#4572A7", "#AA4643", "#89A54E", "#80699B", "#3D96AE", "#DB843D", "#92A8CD", "#A47D7C", "#B5CA92"};
		int i = 0;
		for(Map<String, Object> data : dataList) {				
			
			Map<String, Object> value = new HashMap<String, Object>();
			
			value.put("color", colors[i]);
			value.put("name", data.get("name"));
			value.put("value", data.get("value"));
			
			resultList.add(value);
			i++;
		}
		
		return resultList;
	}
	
	/**
	 * Column Chart 데이터 조회(대표발의 법률안)
	 */
	@Override
	public Object searchDegtMotnLgsbColumn(Params params) {
		
		params.set("represent", "대표발의");
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)assmLawmDao.searchDegtMotnLgsbColumn(params);
		
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
	 * TreeMap Chart 데이터 조회(공동발의 법률안)
	 */
	@Override
	public Object searchLawmClboMotnLgsbTreeMap(Params params) {
		
		params.set("represent", "공동발의");
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)assmLawmDao.searchDegtMotnLgsbTreeMap(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		String [] colors  = {"#2F7ED8", "#0D233A", "#8BBC21", "#910000", "#1AADCE", "#492970", "#F28F43", "#77A1E5", "#C42525", "#A6C96A",
		    		               "#058DC7", "#50B432", "#ED561B", "#DDDF00", "#24CBE5", "#64E572", "#FF9655", "#FFF263", "#6AF9C4",
		    		               "#4572A7", "#AA4643", "#89A54E", "#80699B", "#3D96AE", "#DB843D", "#92A8CD", "#A47D7C", "#B5CA92"};
		
		
		
		int i = 0;
		for(Map<String, Object> data : dataList) {				
			
			Map<String, Object> value = new HashMap<String, Object>();
			
			value.put("color", colors[i % colors.length]);
			value.put("name", data.get("name"));
			value.put("value", data.get("value"));
			
			resultList.add(value);
			i++;
		}
		
		return resultList;
	}
	
	/**
	 * Column Chart 데이터 조회(공동발의 법률안)
	 */
	@Override
	public Object searchLawmClboMotnLgsbColumn(Params params) {
		
		params.set("represent", "공동발의");
		
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)assmLawmDao.searchDegtMotnLgsbColumn(params);
		
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
	 * 상임위 활동 조회 
	 */
	@Override
	public List<Record> selectLawmSdcmAct(Params params) {
		return assmLawmDao.searchLawmSdcmAct(params);
	}
	@Override
	public Paging searchLawmSdcmAct(Params params) {
		return assmLawmDao.searchLawmSdcmAct(params, params.getPage(), params.getRows());
	}

	/**
	 * 연구단체 조회
	 */
	@Override
	public List<Record> selectLawmRschOrg(Params params) {
		return assmLawmDao.searchLawmRschOrg(params);
	}
	@Override
	public Paging searchLawmRschOrg(Params params) {
		return assmLawmDao.searchLawmRschOrg(params, params.getPage(), params.getRows());
	}
	
	/**
	 *청원 조회 페이징
	 */
	@Override
	public Paging searchCombLawmPttnReport(Params params) {
		return assmLawmDao.searchCombLawmPttnReport(params, params.getPage(), params.getRows());
	}
	
	/**
	 *청원 조회
	 */
	@Override
	public List<Record> selectCombLawmPttnReport(Params params) {
		return assmLawmDao.searchCombLawmPttnReport(params);
	}

	/**
	 * 영상회의록 조회
	 */
	@Override
	public Paging searchCombLawmVideoMnts(Params params) {
		return assmLawmDao.searchCombLawmVideoMnts(params, params.getPage(), params.getRows());
	}
	@Override
	public List<Record> selectCombLawmVideoMnts(Params params) {
		return assmLawmDao.selectCombLawmVideoMnts(params);
	}
	
	
}
