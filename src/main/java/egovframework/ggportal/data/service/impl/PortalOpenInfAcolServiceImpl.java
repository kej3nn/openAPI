/*
 * @(#)PortalOpenInfAcolServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.view.JxlsExcelView;
import egovframework.ggportal.data.service.PortalOpenInfAcolService;

/**
 * 공공데이터 오픈API 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfAcolService")
public class PortalOpenInfAcolServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenInfAcolService {
    /**
     * 공공데이터 오픈API 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfAcolDao")
    private PortalOpenInfAcolDao portalOpenInfAcolDao;
    
    /**
     * 공공데이터 오픈API 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfAcolMeta(Params params) {
        // 공공데이터 오픈API 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfAcolDao.selectOpenInfAcolMeta(params);
        
        try{
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000016", getMessage("portal.error.000016"));
	        }
        
	        // 공공데이터 오픈API 서비스 요청변수를 검색한다.
	        meta.put("variables", portalOpenInfAcolDao.searchOpenInfAcolVars(params));
	        
	        // 공공데이터 오픈API 서비스 응답컬럼을 검색한다.
	        meta.put("columns", portalOpenInfAcolDao.searchOpenInfAcolCols(params));
	        
	        // 공공데이터 오픈API 서비스 예제주소를 검색한다.
	        meta.put("urls", portalOpenInfAcolDao.searchOpenInfAcolUrls(params));
	        
	        // 공공데이터 오픈API 서비스 조회필터를 검색한다.
	        meta.put("filters", portalOpenInfAcolDao.searchOpenInfAcolFilt(params));
	        
	        // 공공데이터 오픈API 서비스 응답문자를 검색한다.
	        meta.put("messages", portalOpenInfAcolDao.searchOpenInfAcolMsgs(params));
        
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
     * 공공데이터 오픈API 서비스 명세서를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfAcolSpec(Params params) {
        // 공공데이터 오픈API 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfAcolDao.selectOpenInfAcolMeta(params);
       try{ 
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000016", getMessage("portal.error.000016"));
	        }
	        
	        // 공공데이터 오픈API 서비스 요청변수를 검색한다.
	        meta.put("variables", portalOpenInfAcolDao.searchOpenInfAcolVars(params));
	        
	        // 공공데이터 오픈API 서비스 응답컬럼을 검색한다.
	        meta.put("columns", portalOpenInfAcolDao.searchOpenInfAcolCols(params));
	        
	        // 공공데이터 오픈API 서비스 응답문자를 검색한다.
	        meta.put("messages", portalOpenInfAcolDao.searchOpenInfAcolMsgs(params));
	        
	        meta.put(JxlsExcelView.TEMPLATE_PATH, "/egovframework/template/jxls/ggportal/data/selectOpenApiSpec.xlsx");
	        meta.put(JxlsExcelView.FILE_NAME,     meta.getString("infNm") + "_오픈API명세서.xls");
	        
       } catch (DataAccessException dae) {
       	EgovWebUtil.exLogging(dae);
       } catch (ServiceException sve) {
       	EgovWebUtil.exLogging(sve);
       } catch (Exception e) {
			EgovWebUtil.exLogging(e);
       }
       
       return meta;
    }
}