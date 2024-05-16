/*
 * @(#)PortalOpenInfCcolServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenInfCcolService;

/**
 * 공공데이터 차트 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfCcolService")
public class PortalOpenInfCcolServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenInfCcolService {
    /**
     * 공공데이터 차트 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfCcolDao")
    private PortalOpenInfCcolDao portalOpenInfCcolDao;
    
    /**
     * 우리지역찾기 관련 DAO
     */
    @Resource(name="ggportalOpenInfVillageDao")
    private PortalOpenInfVillageDao portalOpenInfVillageDao;
    
    /* 
     * (non-Javadoc)
     * @see egovframework.ggportal.data.service.impl.PortalOpenInfSrvServiceImpl#selectDownloadMeta(egovframework.common.base.model.Params)
     */
    protected Record selectDownloadMeta(Params params) {
    	Record meta = new Record();
    	try {
    		meta = portalOpenInfCcolDao.selectOpenInfCcolMeta(params);
    		
    		params.put("aprvProcYn", meta.getString("aprvProcYn"));
    		
    		// 공공데이터 차트 서비스 테이블명을 조회한다.
    		Record table = portalOpenInfCcolDao.selectOpenInfCcolTbNm(params);
    		
    		// 소유자명을 설정한다.
    		meta.put("ownerName", table.getString("ownerCd"));
    		
    		// 테이블명을 설정한다.
    		meta.put("tableName", table.getString("dsId"));
    		
    		// 공공데이터 차트 서비스 조회컬럼을 검색한다.
    		meta.put("columnNames", portalOpenInfCcolDao.searchOpenInfCcolCols(params).toArray());
    		
    		// 공공데이터 차트 서비스 조회조건을 검색한다.
    		meta.put("searchConditions", portalOpenInfCcolDao.searchOpenInfCcolCond(params).toArray());
    		
    		// // 공공데이터 차트 서비스 조회필터를 검색한다.
    		meta.put("searchFilters", getSearchFilters(portalOpenInfCcolDao.searchOpenInfCcolFilt(params), params));
    		
    		// 공공데이터 차트 서비스 정렬조건을 검색한다.
    		meta.put("sortOrders", portalOpenInfCcolDao.searchOpenInfCcolSort(params).toArray());
    		
    		// 공공데이터 차트 서비스 다운컬럼을 검색한다.
    		List<?> columns = portalOpenInfCcolDao.searchOpenInfCcolDown(params);
    		
    		// 컬럼 헤더를 설정한다.
    		meta.put("columnHeaders", getColumnHeaders(columns));
    		
    		// 컬럼 스타일을 설정한다.
    		// meta.put("columnStyles", getColumnStyles(columns));
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        // 공공데이터 차트 서비스 메타정보를 조회한다.
        
        return meta;
    }
    
    /* 
     * (non-Javadoc)
     * @see egovframework.ggportal.data.service.impl.PortalOpenInfSrvServiceImpl#searchDownloadData(egovframework.common.base.model.Params)
     */
    protected Paging searchDownloadData(Params params) {
        // 우리지역데이터 찾기에서 검색 시 데이터셋 테이블에 SIGUN_CD 컬럼이 있는지 확인한다.
    	Paging result = new Paging();
    	try {
    		if(params.containsKey("sigunFlag")) {
    			params.put("dsId", params.getString("tableName"));
    			Record record = portalOpenInfVillageDao.selectSigunCdYn(params);
    			int cnt = record.getInt("cnt");
    			if(cnt == 1) {
    				params.put("sigunCdYn", "Y");
    			} else {
    				params.put("sigunCdYn", "N");
    			}
    		}
    		// 공공데이터 차트 서비스 데이터를 검색한다.
    		result = portalOpenInfCcolDao.searchOpenInfCcolData(params, params.getPage(), params.getRows());
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    	return result;
    }
    
    /**
     * 공공데이터 차트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfCcolMeta(Params params) {
    	Record meta = new Record();
        try{ 
        	// 공공데이터 차트 서비스 메타정보를 조회한다.
        	meta = portalOpenInfCcolDao.selectOpenInfCcolMeta(params);
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000017", getMessage("portal.error.000017"));
	        }
	        
	        // 공공데이터 차트 서비스 차트유형을 검색한다.
	        meta.put("types", portalOpenInfCcolDao.searchOpenInfCcolType(params));
	        
	        // 공공데이터 차트 서비스 X-축컬럼을 검색한다.
	        meta.put("xaxes", portalOpenInfCcolDao.searchOpenInfCcolXcol(params));
	        
	        // 공공데이터 차트 서비스 Y-축컬럼을 검색한다.
	        meta.put("yaxes", portalOpenInfCcolDao.searchOpenInfCcolYcol(params));
	        
	        // 공공데이터 차트 서비스 조회필터를 검색한다.
	        meta.put("filters", setFilterOptions(portalOpenInfCcolDao.searchOpenInfCcolFilt(params)));
        
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
     * 공공데이터 차트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolData(Params params) {
    	List<?> result = new ArrayList<Record>();
    	try {
    		// sql 삽입 보안취약점
    		// 공공데이터 차트 서비스 메타정보를 조회한다.
    		Record meta = portalOpenInfCcolDao.selectOpenInfCcolMeta(params);
    		
    		params.put("aprvProcYn", meta.getString("aprvProcYn"));
    		
    		// 공공데이터 차트 서비스 테이블명을 조회한다.
    		Record table = portalOpenInfCcolDao.selectOpenInfCcolTbNm(params);
    		
    		// 소유자명을 설정한다.
    		params.put("ownerName", UtilString.SQLInjectionFilter2(table.getString("ownerCd")));
    		
    		// 테이블명을 설정한다.
    		params.put("tableName", UtilString.SQLInjectionFilter2(table.getString("dsId")));
    		
    		// 공공데이터 차트 서비스 조회컬럼을 검색한다.
    		params.put("columnNames", portalOpenInfCcolDao.searchOpenInfCcolCols(params).toArray());
    		
    		// 공공데이터 차트 서비스 조회조건을 검색한다.
    		params.put("searchConditions", portalOpenInfCcolDao.searchOpenInfCcolCond(params).toArray());
    		
    		// 공공데이터 차트 서비스 조회필터를 검색한다.
    		params.put("searchFilters", getSearchFilters(portalOpenInfCcolDao.searchOpenInfCcolFilt(params), params));
    		
    		// 공공데이터 차트 서비스 정렬조건을 검색한다.
    		params.put("sortOrders", portalOpenInfCcolDao.searchOpenInfCcolSort(params).toArray());
    		
    		// 우리지역데이터 찾기에서 검색 시 데이터셋 테이블에 SIGUN_CD 컬럼이 있는지 확인한다.
    		if(params.containsKey("sigunFlag")) {
    			params.put("dsId", UtilString.SQLInjectionFilter2(table.getString("dsId")));
    			Record record = portalOpenInfVillageDao.selectSigunCdYn(params);
    			int cnt = record.getInt("cnt");
    			if(cnt == 1) {
    				params.put("sigunCdYn", "Y");
    			} else {
    				params.put("sigunCdYn", "N");
    			}
    		}
			
    		// 공공데이터 차트 서비스 데이터를 검색한다.
    		result =  portalOpenInfCcolDao.searchOpenInfCcolData(params);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    	
    	return result;
    	
    	
    }
    
    /**
     * 공공데이터 차트 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    public void downloadOpenInfCcolDataCUD(HttpServletRequest request, HttpServletResponse response, Params params) {
        // 데이터 파일을 다운로드한다.
        downloadDataFile(request, response, params);
    }
}