/*
 * @(#)PortalOpenInfMcolServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenInfMcolService;

/**
 * 공공데이터 지도 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfMcolService")
public class PortalOpenInfMcolServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenInfMcolService {
    /**
     * 공공데이터 지도 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfMcolDao")
    private PortalOpenInfMcolDao portalOpenInfMcolDao;
    
    /**
     * 우리지역찾기 관련 DAO
     */
    @Resource(name="ggportalOpenInfVillageDao")
    private PortalOpenInfVillageDao portalOpenInfVillageDao;
    
    /**
     * 공공데이터 지도 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfMcolMeta(Params params) {
        // 공공데이터 지도 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfMcolDao.selectOpenInfMcolMeta(params);
        try{
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000020", getMessage("portal.error.000020"));
	        }
	        
	        List<?> list = portalOpenInfMcolDao.searchOpenInfMcolInfo(params);
	        
	        // 공공데이터 지도 서비스 항목정보를 검색한다.
	        meta.put("items", list);
	        
	        params.put("first", 1);
	        
	        boolean result = markerColExistChk(list);
	        
	        // 공공데이터 지도 서비스 데이터를 검색한다.
	        Record first = searchOpenInfMcolData(params, result);
	        meta.put("first", first.get("result"));
	        meta.put("marker", first.get("marker"));
	        
	        // 공공데이터 지도 서비스 조회필터를 검색한다.
	        meta.put("filters", setFilterOptions(portalOpenInfMcolDao.searchOpenInfMcolFilt(params)));
        
        } catch (DataAccessException dae) {
        	EgovWebUtil.exLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
			EgovWebUtil.exLogging(e);
        }
        
        return meta;
    }
    
    /**
     * 공공데이터 지도 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Record searchOpenInfMcolData(Params params, boolean res) {
    	Record result = new Record();
    	try {
    		// 공공데이터 지도 서비스 메타정보를 조회한다.
    		Record meta = portalOpenInfMcolDao.selectOpenInfMcolMeta(params);
    		
    		params.put("aprvProcYn", meta.getString("aprvProcYn"));
    		
    		// 공공데이터 지도 서비스 테이블명을 조회한다.
    		Record table = portalOpenInfMcolDao.selectOpenInfMcolTbNm(params);
    		
    		// 소유자명을 설정한다.
    		params.put("ownerName", table.getString("ownerCd"));
    		
    		// 테이블명을 설정한다.
    		params.put("tableName", table.getString("dsId"));
    		
    		// 공공데이터 지도 서비스 조회컬럼을 검색한다.
    		params.put("columnNames", portalOpenInfMcolDao.searchOpenInfMcolCols(params).toArray());
    		
    		// 공공데이터 지도 서비스 조회조건을 검색한다.
    		params.put("searchConditions", portalOpenInfMcolDao.searchOpenInfMcolCond(params).toArray());
    		
    		Object[] filtObj = {};
    		
    		// 공공데이터 시트 서비스 조회필터를 검색한다.
    		if("".equals( UtilString.null2Blank( params.get("first") ) ) ){
    			filtObj = getSearchFilters(portalOpenInfMcolDao.searchOpenInfMcolFilt(params), params);
    			params.put("searchFilters", filtObj);
    		}
    		
    		//필터 조건이 들어오면 지도 좌표 범위 조건을 제거함
    		/*if(filtObj.length > 0){
        	params.put("Y_WGS84_FROM", "");params.put("Y_WGS84_TO", "");params.put("X_WGS84_FROM", "");params.put("X_WGS84_TO", "");
        }*/
    		
    		
    		//마커구분이 선택될 경우 마커 고정을 위해서 조회
    		if(res){
    			List<String> mkList = portalOpenInfMcolDao.searchOpenInfMcolMarkerCd(params);
    			result.put("marker", mkList);
    		}
    		
    		// 우리지역데이터 찾기에서 검색 시 데이터셋 테이블에 SIGUN_CD 컬럼이 있는지 확인한다.
    		if(params.containsKey("sigunFlag")) {
    			
    			params.put("dsId", table.getString("dsId"));
    			Record record = portalOpenInfVillageDao.selectSigunCdYn(params);
    			int cnt = record.getInt("cnt");
    			if(cnt == 1) {
    				params.put("sigunCdYn", "Y");
    			} else {
    				params.put("sigunCdYn", "N");
    			}
    		}
    		
    		
    		//위경도 조건 추가
    		if(!"".equals(UtilString.null2Blank(params.get("loc")))){
    			String locArr[] = params.get("loc").toString().split("@");
    			String wgs = null;
    			if(locArr.length>3){
    				wgs = " AND REFINE_WGS84_LAT BETWEEN " + locArr[0] + " AND " + locArr[1] + " ";
    				wgs += " AND REFINE_WGS84_LOGT BETWEEN " + locArr[2] + " AND " + locArr[3] + " ";
    			}else{
    				wgs = " AND REFINE_WGS84_LAT = NULL AND REFINE_WGS84_LOGT = NULL ";
    			}
    			params.put("wgsCoordinate", wgs);
    		}
    		
    		// 공공데이터 지도 서비스 데이터를 검색한다.
    		result.put("result", portalOpenInfMcolDao.searchOpenInfMcolData(params));
			
		}catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        return result;
    }
    
    //마커 컬럼 존재 여부 확인
    public boolean markerColExistChk(List<?> list){
    	boolean result = false;
    	for(int i=0; i<list.size(); i++){
    		Map<?, ?> map = (Map<?, ?>) list.get(i);
    		if("MARKER".equals(map.get("colCd"))){
    			result = true;
    			break;
    		}
    	}
    	return result;
    }
    
    /**
     * MAP에서 shape 파일이 있는지 확인하고 리스트 조회한다.
     * @param params
     * @return
     */
    public Record selectOpenInfIsShape(Params params) {
    	return portalOpenInfMcolDao.selectOpenInfIsShape(params);
    }
}