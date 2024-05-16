/*
 * @(#)PortalOpenInfSrvServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.code.service.impl.CodeDAO;
import egovframework.common.helper.Csvdownheler;
import egovframework.common.helper.Exceldownheler;
import egovframework.common.helper.Jsondownheler;
import egovframework.common.helper.Rdfdownheler;
import egovframework.common.helper.Txtdownheler;
import egovframework.common.helper.Xmldownheler;
import egovframework.common.util.UtilString;
import egovframework.ggportal.code.service.impl.PortalCommCodeServiceImpl;
import egovframework.ggportal.code.service.impl.PortalDataCodeDao;
import egovframework.ggportal.data.service.PortalOpenInfSrvService;

/**
 * 공공데이터 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfSrvService")
public class PortalOpenInfSrvServiceImpl extends PortalCommCodeServiceImpl implements PortalOpenInfSrvService {
	
    @Resource(name = "CodeDAO")
    private CodeDAO codeDAO;
    
    /**
     * 체크 필터 유형
     */
    private static final String FILTER_TYPE_CHECK = "CHECK";
    
    /**
     * 라디오 필터 유형
     */
    private static final String FILTER_TYPE_RADIO = "RADIO";
    
    /**
     * 콤보 필터 유형
     */
    private static final String FILTER_TYPE_COMBO = "COMBO";
    
    /**
     * 텍스트 필터 유형
     */
    private static final String FILTER_TYPE_WORDS = "WORDS";
    
    /**
     * 날짜 필터 유형
     */
    private static final String FILTER_TYPE_FDATE = "FDATE";
    
    /**
     * 날짜 필터 유형
     */
    private static final String FILTER_TYPE_LDATE = "LDATE";
    
    /**
     * 날짜 필터 유형
     */
    private static final String FILTER_TYPE_PDATE = "PDATE";
    
    /**
     * 날짜 필터 유형
     */
    private static final String FILTER_TYPE_SDATE = "SDATE";
    
    /**
     * 날짜 필터 유형
     */
    private static final String FILTER_TYPE_CDATE = "CDATE";
    
    /**
     * 팝업 필터 유형
     */
    private static final String FILTER_TYPE_POPUP = "POPUP";
    
    /**
     * 링크 필터 유형
     */
    private static final String FILTER_TYPE_PLINK = "PLINK";
    
    /**
     * 필터 템플릿
     */
    private static final Map<String, MessageFormat[]> filterTemplates = new HashMap<String, MessageFormat[]>();
    
    /**
     * XML 다운로드 유형
     */
    private static final String DOWNLOAD_TYPE_XML = "X";
    
    /**
     * JSON 다운로드 유형
     */
    private static final String DOWNLOAD_TYPE_JSON = "J";
    
    /**
     * XLS 다운로드 유형
     */
    private static final String DOWNLOAD_TYPE_XLS = "E";
    
    /**
     * CSV 다운로드 유형
     */
    private static final String DOWNLOAD_TYPE_CSV = "C";
    
    /**
     * TXT 다운로드 유형
     */
    private static final String DOWNLOAD_TYPE_TXT = "T";
    
    /**
     * RDF 다운로드 유형
     */
    private static final String DOWNLOAD_TYPE_RDF = "R";
    
    /**
     * 디폴트 페이지 크기
     */
    private static final int DEFAULT_ROWS = 1000;
    
    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 필터 템플릿
        filterTemplates.put(FILTER_TYPE_CHECK, new MessageFormat[] {
            new MessageFormat("{0} IN ({1})")
        });
        filterTemplates.put(FILTER_TYPE_RADIO, new MessageFormat[] {
            new MessageFormat("{0} = ''{1}''")
        });
        filterTemplates.put(FILTER_TYPE_COMBO, new MessageFormat[] {
            new MessageFormat("{0} = ''{1}''")
        });
        filterTemplates.put(FILTER_TYPE_WORDS, new MessageFormat[] {
            new MessageFormat("{0} LIKE ''%''||''{1}''||''%''")
        });
        // [날짜] 문자형 타입
        filterTemplates.put(FILTER_TYPE_FDATE, new MessageFormat[] {
            new MessageFormat("{0} >= TO_CHAR(TO_DATE(''{1}'', ''YYYY-MM-DD'') + 0, ''YYYY-MM-DD'')"),
            new MessageFormat("{0} <  TO_CHAR(TO_DATE(''{1}'', ''YYYY-MM-DD'') + 1, ''YYYY-MM-DD'')")
        });
        filterTemplates.put(FILTER_TYPE_LDATE, new MessageFormat[] {
            new MessageFormat("{0} >= TO_CHAR(TO_DATE(''{1}'', ''YYYY/MM/DD'') + 0, ''YYYY/MM/DD'')"),
            new MessageFormat("{0} <  TO_CHAR(TO_DATE(''{1}'', ''YYYY/MM/DD'') + 1, ''YYYY/MM/DD'')")
        });
        filterTemplates.put(FILTER_TYPE_PDATE, new MessageFormat[] {
            new MessageFormat("{0} >= TO_CHAR(TO_DATE(''{1}'', ''YYYY.MM.DD'') + 0, ''YYYY.MM.DD'')"),
            new MessageFormat("{0} <  TO_CHAR(TO_DATE(''{1}'', ''YYYY.MM.DD'') + 1, ''YYYY.MM.DD'')")
        });
        filterTemplates.put(FILTER_TYPE_CDATE, new MessageFormat[] {
        		new MessageFormat("{0} >= ''{1}''"),
        		new MessageFormat("{0} <= ''{1}''")
        });
        // [날짜] 날짜형 타입
        filterTemplates.put(FILTER_TYPE_SDATE, new MessageFormat[] {
            new MessageFormat("{0} >= TO_DATE(''{1}'', ''YYYYMMDD'') + 0"),
            new MessageFormat("{0} <  TO_DATE(''{1}'', ''YYYYMMDD'') + 1")
        });
        filterTemplates.put(FILTER_TYPE_POPUP, new MessageFormat[] {
            new MessageFormat("{0} = ''{1}''")
        });
        filterTemplates.put(FILTER_TYPE_PLINK, new MessageFormat[] {
            // Nothing to do.
        });
    }
    
    /**
     * XML 다운로더
     */
    @Autowired
    private Xmldownheler xmlDownhelper;
    
    /**
     * JSON 다운로더
     */
    @Autowired
    private Jsondownheler jsonDownhelper;
    
    /**
     * XLS 다운로더
     */
    @Autowired
    private Exceldownheler excelDownhelper;
    
    /**
     * CSV 다운로더
     */
    @Autowired
    private Csvdownheler csvDownhelper;
    
    /**
     * TXT 다운로더
     */
    @Autowired
    private Txtdownheler txtDownhelper;
    /**
     * RDF 다운로더
     */
    @Autowired
    private Rdfdownheler rdfDownhelper;
    
    /**
     * 데이터 코드를 관리하는 DAO
     */
    @Resource(name="ggportalDataCodeDao")
    private PortalDataCodeDao portalDataCodeDao;
    
    /**
     * 공공데이터 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfSrvDao")
    private PortalOpenInfSrvDao portalOpenInfSrvDao;
    
    /**
     * 데이터를 XML 파일로 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    @SuppressWarnings("unchecked")
    private void downloadDataXml(HttpServletRequest request, HttpServletResponse response, Params params)  {
        try {
			
        	String name = params.getString("infNm");
        	
        	LinkedHashMap<String, ?> headers = (LinkedHashMap<String, ?>) params.get("columnHeaders");
        	
        	int  index = 0;
        	int  count = 0;
        	long bytes = 0;
        	
        	// 도큐면트를 생성한다.
        	Document document = DocumentHelper.createDocument();
        	
        	// 루트 엘레먼트를 추가한다.
        	Element element = document.addElement(UtilString.replace(name, " ", ""));
        	
        	while (true) {
        		params.put(Params.PAGE, index + 1);
        		params.put(Params.ROWS, DEFAULT_ROWS);
        		
        		// 다운로드 데이터를 검색한다.
        		Paging paging = searchDownloadData(params);
        		
    			for (int i = 0; i < paging.size(); i++) {
    				Record data = (Record) paging.get(i);
    			}
    			
        		List<LinkedHashMap<String, ?>> data = (List<LinkedHashMap<String, ?>>) paging.getData();
        		if(data != null) {
        			data = changeDataHanja(data, params.getString("infId"));
        		}
        		
        		xmlDownhelper.download(data, headers, name, index, element);
        		
        		bytes += UtilString.getDataSize(data);
        		
        		if(params !=null && paging != null) {
	        		if (params.getPage() < paging.getPages()) {
	        			index++;
	        			continue;
	        		}
	        		else {
	        			count = paging != null ? paging.getCount() : 0;
	        			break;
	        		}
        		}
        	}
        	
        	xmlDownhelper.dataPrintln(name, response, request, document);
        	
        	params.put("rowCnt", count);
        	params.put("dbSize", bytes);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 데이터를 JSON 파일로 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    @SuppressWarnings("unchecked")
    private void downloadDataJson(HttpServletRequest request, HttpServletResponse response, Params params)  {
    	try {
			
    		String name = params.getString("infNm");
    		
    		LinkedHashMap<String, ?> headers = (LinkedHashMap<String, ?>) params.get("columnHeaders");
    		
    		int  index = 0;
    		int  count = 0;
    		long bytes = 0;
    		
    		// 리스트를 생성한다.
    		List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
    		
    		while (true) {
    			params.put(Params.PAGE, index + 1);
    			params.put(Params.ROWS, DEFAULT_ROWS);
    			
    			// 다운로드 데이터를 검색한다.
    			Paging paging = params != null ? searchDownloadData(params) : null;
    			
    			List<LinkedHashMap<String, ?>> data = (List<LinkedHashMap<String, ?>>) paging.getData();
        		if(data != null) {
        			data = changeDataHanja(data, params.getString("infId"));
        		}
        		
    			list.addAll(jsonDownhelper.download(data, headers, index));
    			
    			bytes += UtilString.getDataSize(data);
    			
    			if(params != null && paging != null) {
	    			if (params.getPage() < paging.getPages()) {
	    				index++;
	    				continue;
	    			}
	    			else {
	    				count = paging != null ? paging.getCount() : 0;
	    				break;
	    			}
    			}
    		}
    		
    		jsonDownhelper.dataPrintln(name, response, request, list);
    		
    		params.put("rowCnt", count);
    		params.put("dbSize", bytes);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 데이터를 XLS 파일로 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    @SuppressWarnings("unchecked")
    private void downloadDataXls(HttpServletRequest request, HttpServletResponse response, Params params)  {
        try {
			
        	String name = params.getString("infNm");
        	String type = params.getString("srvCd");
        	
        	LinkedHashMap<String, ?> headers = (LinkedHashMap<String, ?>) params.get("columnHeaders");
        	
        	List<OpenInfScol> styles = null;
        	
        	// 서비스 유형이 차트가 아닌 경우
        	if (!SERVICE_TYPE_CHART.equals(type)) {
        		styles = (List<OpenInfScol>) params.get("columnStyles");
        	}
        	
        	int  index = 0;
        	int  count = 0;
        	long bytes = 0;
        	
        	// 워크북을 생성한다.
        	HSSFWorkbook workbook = new HSSFWorkbook();
        	
        	// 옵션을 생성한다.
        	Map<String, Object> options = new HashMap<String, Object>();
        	
        	options.put("workbook", workbook);
        	options.put("rowCnt",   1);
        	options.put("sheetCnt", 0);
        	
        	while (true) {
        		params.put(Params.PAGE, index + 1);
        		params.put(Params.ROWS, DEFAULT_ROWS);
        		
        		// 다운로드 데이터를 검색한다.
        		Paging paging = searchDownloadData(params);

        		List<LinkedHashMap<String, ?>> data = paging != null ? (List<LinkedHashMap<String, ?>>) paging.getData() : null;
        		if(data != null) {
        			data = changeDataHanja(data, params.getString("infId"));
        		}
        		
        		// 서비스 유형이 차트가 아닌 경우
        		if (!SERVICE_TYPE_CHART.equals(type)) {
        			options = excelDownhelper.download(data, headers, name, index, options, styles);
        		}
        		else {
        			options = excelDownhelper.cDownload(data, headers, name, index, options, null);
        		}
        		
        		bytes += UtilString.getDataSize(data);
        		
        		if (params.getPage() < paging.getPages()) {
        			index++;
        			continue;
        		}
        		else {
        			count = paging.getCount();
        			break;
        		}
        	}
        	
        	excelDownhelper.dataPrintln(name, response, request, workbook);
        	
        	params.put("rowCnt", count);
        	params.put("dbSize", bytes);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 데이터를 CSV 파일로 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    @SuppressWarnings("unchecked")
    private void downloadDataCsv(HttpServletRequest request, HttpServletResponse response, Params params)  {
        try {
			
        	String name = params.getString("infNm");
        	
        	LinkedHashMap<String, ?> headers = (LinkedHashMap<String, ?>) params.get("columnHeaders");
        	
        	int  index = 0;
        	int  count = 0;
        	long bytes = 0;
        	
        	// 버퍼를 생성한다.
        	StringBuffer buffer = new StringBuffer();
        	
        	while (true) {
        		params.put(Params.PAGE, index + 1);
        		params.put(Params.ROWS, DEFAULT_ROWS);
        		
        		// 다운로드 데이터를 검색한다.
        		Paging paging = searchDownloadData(params);
        		
        		List<LinkedHashMap<String, ?>> data = (List<LinkedHashMap<String, ?>>) paging.getData();
        		if(data != null) {
        			data = changeDataHanja(data, params.getString("infId"));
        		}
        		
        		buffer.append(csvDownhelper.download(data, headers, index));
        		
        		bytes += UtilString.getDataSize(data);
        		
        		if (paging != null && (params.getPage() < paging.getPages())) {
        			index++;
        			continue;
        		}
        		else {
        			count = paging != null ? paging.getCount() : 0;
        			break;
        		}
        	}
        	
        	csvDownhelper.dataPrintln(name, response, request, buffer.toString());
        	
        	params.put("rowCnt", count);
        	params.put("dbSize", bytes);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 데이터를 TXT 파일로 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    @SuppressWarnings("unchecked")
    private void downloadDataTxt(HttpServletRequest request, HttpServletResponse response, Params params)  {
    	try {
			
    		String name = params.getString("infNm");
    		
    		LinkedHashMap<String, ?> headers = (LinkedHashMap<String, ?>) params.get("columnHeaders");
    		
    		int  index = 0;
    		int  count = 0;
    		long bytes = 0;
    		
    		// 버퍼를 생성한다.
    		StringBuffer buffer = new StringBuffer();
    		
    		while (true) {
    			params.put(Params.PAGE, index + 1);
    			params.put(Params.ROWS, DEFAULT_ROWS);
    			
    			// 다운로드 데이터를 검색한다.
    			Paging paging = searchDownloadData(params);
    			
    			List<LinkedHashMap<String, ?>> data = paging != null ? (List<LinkedHashMap<String, ?>>) paging.getData() : null;
        		if(data != null) {
        			data = changeDataHanja(data, params.getString("infId"));
        		}
        		
    			buffer.append(txtDownhelper.download(data, headers, index));
    			
    			bytes += UtilString.getDataSize(data);
    			
    			if(params != null && paging != null) {
	    			if (params.getPage() < paging.getPages()) {
	    				index++;
	    				continue;
	    			}
	    			else {
	    				count = paging != null ? paging.getCount() : 0;
	    				break;
	    			}
    			}
    		}
    		
    		txtDownhelper.dataPrintln(name, response, request, buffer.toString());
    		
    		params.put("rowCnt", count);
    		params.put("dbSize", bytes);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 데이터를 RDF 파일로 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    @SuppressWarnings("unchecked")
    private void downloadDataRdf(HttpServletRequest request, HttpServletResponse response, Params params)  {
        try {
			
        	String name = params.getString("infNm");
        	
        	LinkedHashMap<String, ?> headers = (LinkedHashMap<String, ?>) params.get("columnHeaders");
        	
        	int  index = 0;
        	int  count = 0;
        	long bytes = 0;
        	
        	// 버퍼를 생성한다.
        	StringBuffer buffer = new StringBuffer();
        	
        	buffer.append("<rdf:RDF xmlns:RDF=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n");
        	
        	while (true) {
        		params.put(Params.PAGE, index + 1);
        		params.put(Params.ROWS, DEFAULT_ROWS);
        		
        		// 다운로드 데이터를 검색한다.
        		Paging paging = searchDownloadData(params);
        		
        		if ( paging != null ) {
        			List<LinkedHashMap<String, ?>> data = (List<LinkedHashMap<String, ?>>) paging.getData();
            		if(data != null) {
            			data = changeDataHanja(data, params.getString("infId"));
            		}
            		
        			buffer.append(rdfDownhelper.download(data, headers, index));
        			
        			bytes += UtilString.getDataSize(data);
        			
        			if (params.getPage() < paging.getPages()) {
        				index++;
        				continue;
        			}
        			else {
        				count = paging.getCount();
        				break;
        			}
        		}
        	}
        	
        	buffer.append("</rdf:RDF>");
        	
        	rdfDownhelper.dataPrintln(name, response, request, buffer.toString());
        	
        	params.put("rowCnt", count);
        	params.put("dbSize", bytes);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 필터 옵션을 설정한다.
     * 
     * @param filters 필터
     */
    protected List<?> setFilterOptions(List<?> filters) {
        for (int i = 0; i < filters.size(); i++) {
            Record filter = (Record) filters.get(i);
            
            String type = filter.getString("filtCd");
            
            // 필터 유형이 CHECK, RADIO, COMBO인 경우
            if (FILTER_TYPE_CHECK.equals(type) || FILTER_TYPE_RADIO.equals(type) || FILTER_TYPE_COMBO.equals(type)) {
                String code = filter.getString("filtCode");
                
                // 필터 코드가 있는 경우
                if (!"".equals(code)) {
                    Params params = new Params();
                    
                    params.put("grpCd", code);
                    
                    // 데이터 코드를 검색한다.
                    filter.put("options", portalDataCodeDao.searchDataCode(params));
                }
            }
        }
        
        return filters;
    }
    
    /**
     * 검색 필터를 반환한다.
     * 
     * @param filters 필터
     * @param params 파라메터
     * @return 검색 필터
     */
    protected Object[] getSearchFilters(List<?> filters, Params params) {
        List<String> conditions = new ArrayList<String>();
        try{ 
	        for (int i = 0; i < filters.size(); i++) {
	            Record filter = (Record) filters.get(i);
	            
	            String type = filter.getString("filtCd");
	            String need = filter.getString("filtNeed");
	            String name = filter.getString("srcColId");
	            
	            // 필터 템플릿이 있는 경우
	            if (filterTemplates.containsKey(type)) {
	            	
	                MessageFormat[] format = filterTemplates.get(type);
	                
	                String[] values = params.getStringArray(name);
	                
	                // 필터 유형이 CHECK인 경우
	                if (FILTER_TYPE_CHECK.equals(type)) {
	                	
	                    StringBuffer buffer = new StringBuffer();
	                    
	                    int count = 0;
	                    
	                    for (int n = 0; n < values.length; n++) {
	                        if (!"".equals(values[n])) {
	                            if (count > 0) {
	                                buffer.append(",");
	                            }
	                            
	                            buffer.append("'");
	                            buffer.append(values[n].replaceAll("\\'", "''"));
	                            buffer.append("'");
	                            
	                            count++;
	                        }
	                    }
	                    
	                    // 필수 필터 값이 없는 경우
	                    if ("Y".equals(need) && buffer.length() == 0) {
	                        throw new ServiceException("portal.error.000022", getMessage("portal.error.000022", new String[] {
	                            filter.getString("colNm")
	                        }));
	                    }
	                    
	                    // 필터 값이 있는 경우
	                    if (buffer.length() > 0) {
                        	String setVal = URLDecoder.decode(buffer.toString(), "UTF-8"); //운영에서 한글깨지는 현상이 있어 UTF-8로 확인 추가
                            conditions.add(format[0].format(new String[] { name, setVal.replaceAll("\\'", "''") }));
	                        //conditions.add(format[0].format(new String[] { name, buffer.toString() }));
	                    }
	                }
	                // 필터 유형이 CHECK가 아닌 경우
	                else {
	                	
	                	// 잘못된 요청인 경우
	                    if (format.length != values.length) {
	                        throw new ServiceException("portal.error.000023", getMessage("portal.error.000023"));
	                    }
	                    
	                    for (int n = 0; n < format.length; n++) {
	                    	
	                        // 필수 필터 값이 없는 경우
	                        if ("Y".equals(need) && "".equals(values[n])) {
	                            throw new ServiceException("portal.error.000022", getMessage("portal.error.000022", new String[] {
	                                filter.getString("colNm")
	                            }));
	                        }
	                        
	                        // 필터 값이 있는 경우
	                        if (!"".equals(values[n])) {
	                        	String setVal = URLDecoder.decode(values[n], "UTF-8"); //운영에서 한글깨지는 현상이 있어 UTF-8로 확인 추가
	                        	
	                            conditions.add(format[n].format(new String[] { name, setVal.replaceAll("\\'", "''") }));
	                        }
	                    }
	                }
	            }
	        }
	        
        } catch (DataAccessException dae) {
        	EgovWebUtil.exLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
			EgovWebUtil.exLogging(e);
        }
        return conditions.toArray();
    }
    
    /**
     * 데이터 파일을 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    protected void downloadDataFile(HttpServletRequest request, HttpServletResponse response, Params params) {
        long start = System.currentTimeMillis();
        try{
        	// 다운로드 갯수를 조회한다.
        	List<CommCode> cCode = selectDownloadCnt(params);
        	int selVal = 0;
        	int downCnt = 10000;
        	String cCodeValueCd = String.valueOf(cCode.get(0).getValueCd());
        	if(params.get("selCnt") != null ) {
        		selVal = Integer.valueOf((String) params.get("selCnt"));
        	}
        	if(cCodeValueCd != null ) downCnt =  Integer.valueOf(cCodeValueCd);
        	
        	if(selVal < downCnt) {
		        // 다운로드 메타정보를 조회한다.
		        Record meta = selectDownloadMeta(params);
		        
		        if ( meta != null ) {
		        	params.put("infNm",            meta.get("infNm"));
		        	params.put("srvCd",            meta.get("srvCd"));
		        	params.put("ownerName",        meta.get("ownerName"));
		        	params.put("tableName",        StringUtils.defaultString((String)meta.get("tableName")));
		        	params.put("columnNames",      meta.get("columnNames"));
		        	params.put("searchConditions", meta.get("searchConditions"));
		        	params.put("searchFilters",    meta.get("searchFilters"));
		        	params.put("sortOrders",       meta.get("sortOrders"));
		        	params.put("columnHeaders",    meta.get("columnHeaders"));
		        	params.put("columnStyles",     meta.get("columnStyles"));
		        	
		        	String type = params.getString("downloadType");
		        	
		        	// 다운로드 유형이 XML인 경우
		        	if (DOWNLOAD_TYPE_XML.equals(type)) {
		        		// 데이터를 XML 파일로 다운로드한다.
		        		downloadDataXml(request, response, params);
		        	}
		        	// 다운로드 유형이 JSON인 경우
		        	else if (DOWNLOAD_TYPE_JSON.equals(type)) {
		        		// 데이터를 JSON 파일로 다운로드한다.
		        		downloadDataJson(request, response, params);
		        	}
		        	// 다운로드 유형이 XLS인 경우
		        	else if (DOWNLOAD_TYPE_XLS.equals(type)) {
		        		// 데이터를 XLS 파일로 다운로드한다.
		        		downloadDataXls(request, response, params);
		        	}
		        	// 다운로드 유형이 CSV인 경우
		        	else if (DOWNLOAD_TYPE_CSV.equals(type)) {
		        		// 데이터를 CSV 파일로 다운로드한다.
		        		downloadDataCsv(request, response, params);
		        	}
		        	// 다운로드 유형이 TXT인 경우
		        	else if (DOWNLOAD_TYPE_TXT.equals(type)) {
		        		// 데이터를 TXT 파일로 다운로드한다.
		        		downloadDataTxt(request, response, params);
		        	}
		        	// 다운로드 유형이 RDF인 경우
		        	else if (DOWNLOAD_TYPE_RDF.equals(type)) {
		        		// 데이터를 RDF 파일로 다운로드한다.
		        		downloadDataRdf(request, response, params);
		        	}
		        	// 잘못된 요청인 경우
		        	else {
		        		throw new ServiceException("portal.error.000023", getMessage("portal.error.000023"));
		        	}
		        	
		        	response.setHeader("set-cookie", "fileDownload=true; path=/");
		        	
		        	long finish = System.currentTimeMillis();
		        	
		        	params.put("saveExt",  UtilString.getSaveExt(type));
		        	params.put("leadtime", Float.toString((finish - start) / 1000.0F));
		        	
		        	// 공공데이터 서비스 저장이력을 등록한다.
		        	portalOpenInfSrvDao.insertOpenInfSavHist(params);
		        	
		        	
		        }
		        else {
		        	throw new ServiceException("메타정보가 없습니다.");
		        }
	        }
	        else {
	        	DecimalFormat formatter = new DecimalFormat("###,###");
	        	throw new ServiceException("시스템 성능으로 인해 "+formatter.format(downCnt)+"건 이상 데이터는 다운로드되지 않습니다.");
	        }
        } catch (ServiceException e) {
        	EgovWebUtil.exLogging(e);
        	response.setHeader("Set-Cookie", "fileDownload=false; path=/");
        	throw new ServiceException(e.getMessage());
        } catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
    		response.setHeader("Set-Cookie", "fileDownload=false; path=/");
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
		}    
    }
    
    
    /**
     * 다운로드 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    protected Record selectDownloadMeta(Params params) {
    	try {
    		log.debug("오버라이드 메소드");
    	} catch(UnsupportedOperationException ex) {
    		EgovWebUtil.exLogging(ex);
    		throw new UnsupportedOperationException(getMessage("portal.error.000031"));
    	} catch(Exception e) {
    		EgovWebUtil.exLogging(e);
    	}
    	return null;
    }
    
    /**
     * 다운로드 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    
    protected Paging searchDownloadData(Params params) {
    	try {
    		log.debug("오버라이드 메소드");
    	} catch(UnsupportedOperationException ex) {
    		EgovWebUtil.exLogging(ex);
    		throw new UnsupportedOperationException(getMessage("portal.error.000031"));
    	} catch(Exception e) {
    		EgovWebUtil.exLogging(e);
    	}
    	return null;
    }
    
    /**
     * 컬럼 헤더를 반환한다.
     * 
     * @param columns 컬럼
     * @return 컬럼 헤더
     */
    protected LinkedHashMap<String, ?> getColumnHeaders(List<?> columns) {
        LinkedHashMap<String,String>  headers = new LinkedHashMap<String,String> ();
        
        for (int i = 0; i < columns.size(); i++) {
            Record column = (Record) columns.get(i);
            
            headers.put(column.getString("srcColId"), column.getString("colNm"));
        }
        
        return headers;
    }
    
    /**
     * 컬럼 스타일을 반환한다.
     * 
     * @param columns 컬럼
     * @return 컬럼 스타일
     */
    protected List<OpenInfScol> getColumnStyles(List<?> columns) {
        List<OpenInfScol> styles = new ArrayList<OpenInfScol>();
        
        for (int i = 0; i < columns.size(); i++) {
            Record column = (Record) columns.get(i);
            
            OpenInfScol style = new OpenInfScol();
            
            style.setViewCd(column.getString("viewCd"));
            style.setViewSize(column.getString("viewSize", "100"));
            style.setAlignTag(column.getString("alignTag"));
            
            styles.add(style);
        }
        
        return styles;
    }
    
    /**
     * 공공데이터 서비스 조회이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    protected Object insertOpenInfSrvHist(Params params) {
        // 공공데이터 서비스 조회이력을 등록한다.
        return portalOpenInfSrvDao.insertOpenInfSrvHist(params);
    }
    
    /**
     * 공공데이터 서비스 조회수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    protected int updateOpenInfSrvHits(Params params) {
        // 공공데이터 서비스 조회수를 수정한다.
        return portalOpenInfSrvDao.updateOpenInfSrvHits(params);
    }
    
    /**
     * 공공데이터 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfSrvMetaCUD(Params params) {
    	//공공데이터 ID만 파라미터로 넘어왔을때 infSeq의 최소값을 구하여 넘겨준다.
        if ( StringUtils.isEmpty(params.getString("infSeq")) ) {
        	params.set("infSeq", portalOpenInfSrvDao.selectOpenInfSrvMinInfSeq(params));
        }
        
        // 공공데이터 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfSrvDao.selectOpenInfSrvMeta(params);
        try{
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000026", getMessage("portal.error.000026"));
	        }
	        
	        // 공공데이터 서비스 조회이력을 등록한다.
	        insertOpenInfSrvHist(params);
	        
	        // 공공데이터 서비스 조회수를 수정한다.
	        // updateOpenInfSrvHits(params);
        } catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
        
        return meta;
    }
    
    /**
     * 공공데이터 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfApiSrvMetaCUD(Params params) {
    	//공공데이터 ID만 파라미터로 넘어왔을때 infSeq의 최소값을 구하여 넘겨준다.
        if ( StringUtils.isEmpty(params.getString("infSeq")) ) {
        	params.set("infSeq", portalOpenInfSrvDao.selectOpenInfSrvMinInfSeq(params));
        }
        //API 화면에서 호출할 시
        if(StringUtils.isNotEmpty(params.getString("isApiPage")) ) {
        	params.set("infSeq", portalOpenInfSrvDao.selectOpenInfSrvApiInfSeq(params));
        }
        
        // 공공데이터 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfSrvDao.selectOpenInfSrvMeta(params);
        
        if(meta != null) {
        	meta.put("infSeq",params.getInt("infSeq"));
        }
        
        try{
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000026", getMessage("portal.error.000026"));
	        }
	        
	        // 공공데이터 서비스 조회이력을 등록한다.
	        insertOpenInfSrvHist(params);
	        
	        // 공공데이터 서비스 조회수를 수정한다.
	        // updateOpenInfSrvHits(params);
        } catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
        
        return meta;
    }
    
    /**
     * 공공데이터 서비스 평가점수를 등록한다
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Record insertOpenInfSrvApprCUD(Params params) {
        // 공공데이터 서비스 평가점수를 등록한다.
        portalOpenInfSrvDao.insertOpenInfSrvAppr(params);
        
        // 공공데이터 서비스 평가점수를 조회한다.
        return portalOpenInfSrvDao.selectOpenInfSrvAppr(params);
    }
    
    /**
     * 공공데이터 서비스 다운로드 갯수를 확인한다
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public List<CommCode> selectDownloadCnt(Params params) {
		List<CommCode> commDcdList = new ArrayList<CommCode>();
		try {
			commDcdList = codeDAO.selectDownCntList();
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return commDcdList;
    }
    
    /**
     * 특정의원 확장한자 하드코딩 한다.
     * @param list	DB 실 데이터
     * @param params
     */
    public List<LinkedHashMap<String, ?>> changeDataHanja(List<LinkedHashMap<String, ?>> chkdata, String infId) {

		List<LinkedHashMap<String,?>> makedata = new ArrayList<LinkedHashMap<String,?>>();

			
		for(LinkedHashMap<String,?> map : chkdata){
			LinkedHashMap<String,String> map2 = new LinkedHashMap<String,String>();
			
			String hgNm = "";
			for(Entry<String,?> entry: map.entrySet()){
				
				if(((String)entry.getKey()).equals("HG_NM")) {
					hgNm = (String)entry.getValue();
				}
				
				if(((String)entry.getKey()).equals("HJ_NM")) {
					
					if(hgNm.equals("심상정")) {
						map2.put((String)entry.getKey(), "沈相奵");
					} else if(hgNm.equals("고용진")) {
						map2.put((String)entry.getKey(), "高榕禛");
					} else if(hgNm.equals("민병두")) {
						map2.put((String)entry.getKey(), "閔丙䄈");
					}else {
						map2.put((String)entry.getKey(), (entry.getValue()+""));
					}
				} else {
					map2.put((String)entry.getKey(), (entry.getValue()+""));
				}
						
			}
			
			try{
				makedata.add(map2);
			}catch(ServiceException sve){
				EgovWebUtil.exLogging(sve);
			}catch(Exception e){
				EgovWebUtil.exLogging(e);
			}
			
		}
		
		return makedata;

    }    
}