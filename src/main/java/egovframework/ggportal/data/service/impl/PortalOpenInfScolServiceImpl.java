/*
 * @(#)PortalOpenInfScolServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenInfScolService;

/**
 * 공공데이터 시트 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfScolService")
public class PortalOpenInfScolServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenInfScolService {
    /**
     * 공공데이터 시트 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfScolDao")
    private PortalOpenInfScolDao portalOpenInfScolDao;
    
    /**
     * 공공데이터 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfSrvDao")
    private PortalOpenInfSrvDao portalOpenInfSrvDao;
    
    /**
     * 우리지역찾기 관련 DAO
     */
    @Resource(name="ggportalOpenInfVillageDao")
    private PortalOpenInfVillageDao portalOpenInfVillageDao;
    
    
    /**
     * 리소스 경로를 반환한다.
     * 
     * @param file 파일
     * @return 리소스 경로
     */
    private String getResourcePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.ConvertDir"));
        buffer.append(UtilString.getFolderPath(file.getInt("seq"), ""));
        buffer.append("/");
        
        return buffer.toString().replaceAll("\\\\", "/");
    }
    
    /**
     * 리소스 이름을 반환한다.
     * 
     * @param file 파일
     * @return 리소스 이름
     */
    private String getResourceName(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(file.getString("fileSeq"));
        buffer.append(".");
        buffer.append(file.getString("fileExt"));
        
        return buffer.toString();
    }
    
    /**
     * 파일 경로를 반환한다.
     * 
     * @param file 파일
     * @return 파일 경로
     */
    private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        //buffer.append(UtilString.getDownloadFolder("UDF", file.getString("dataSeqceNo")));
        buffer.append(UtilString.getDownloadFolder("UDF", file.getString("dsId")));		// 데이터가 여러건 등록될경우 폴더별로 SEQ가 너무 나뉘어서 dsId로 변경
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        
        return buffer.toString();
    }
    
    /**
     * 파일 이름을 반환한다.
     * 
     * @param file 파일
     * @return 파일 이름
     */
    private String getFileName(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(file.getString("viewFileNm"));
      /*  buffer.append(".");
        buffer.append(file.getString("fileExt"));*/
        
        return buffer.toString();
    }
    
    /**
     * 파일 크기를 반환한다.
     * 
     * @param file 파일
     * @return 파일 크기
     */
    private String getFileSize(Record file) {
        return file.getString("fileSize");
    }
    
    /* 
     * (non-Javadoc)
     * @see egovframework.ggportal.data.service.impl.PortalOpenInfSrvServiceImpl#selectDownloadMeta(egovframework.common.base.model.Params)
     */
    protected Record selectDownloadMeta(Params params) {
    	Record meta = new Record();
    	
    	try {
    		// 공공데이터 시트 서비스 메타정보를 조회한다.
    		meta = portalOpenInfScolDao.selectOpenInfScolMeta(params);
    		
    		params.put("aprvProcYn", meta.getString("aprvProcYn"));
    		
    		// 공공데이터 시트 서비스 테이블명을 조회한다.
    		Record table = portalOpenInfScolDao.selectOpenInfScolTbNm(params);
    		
    		// 소유자명을 설정한다.
    		meta.put("ownerName", table.getString("ownerCd"));
    		
    		// 테이블명을 설정한다.
    		meta.put("tableName", table.getString("dsId"));
    		
    		// 공공데이터 시트 서비스 조회컬럼을 검색한다.
    		meta.put("columnNames", portalOpenInfScolDao.searchOpenInfScolCols(params).toArray());
    		
    		// 공공데이터 시트 서비스 조회조건을 검색한다.
    		meta.put("searchConditions", portalOpenInfScolDao.searchOpenInfScolCond(params).toArray());
    		
    		// 공공데이터 시트 서비스 조회필터를 검색한다.
    		meta.put("searchFilters", getSearchFilters(portalOpenInfScolDao.searchOpenInfScolFilt(params), params));
    		
    		// 공공데이터 시트 서비스 정렬조건을 검색한다.
    		meta.put("sortOrders", portalOpenInfScolDao.searchOpenInfScolSort(params).toArray());
    		
    		// 공공데이터 시트 서비스 다운컬럼을 검색한다.
    		List<?> columns = portalOpenInfScolDao.searchOpenInfScolDown(params);
    		
    		// 컬럼 헤더를 설정한다.
    		meta.put("columnHeaders", getColumnHeaders(columns));
    		
    		// 컬럼 스타일을 설정한다.
    		meta.put("columnStyles", getColumnStyles(columns));
			
		}catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        
        return meta;
    }
    
    /* 
     * (non-Javadoc)
     * @see egovframework.ggportal.data.service.impl.PortalOpenInfSrvServiceImpl#searchDownloadData(egovframework.common.base.model.Params)
     */
    protected Paging searchDownloadData(Params params) {
    	Paging result = new Paging();
    	try {
    		// 우리지역데이터 찾기에서 검색 시 데이터셋 테이블에 SIGUN_CD 컬럼이 있는지 확인한다.
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
    		// 공공데이터 시트 서비스 데이터를 검색한다.
    		result = portalOpenInfScolDao.searchOpenInfScolData(params, params.getPage(), params.getRows());
			
		}catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    	return result;
    }
    
    /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfScolMeta(Params params) {

    	Record meta = new Record();
        try{
        	// 공공데이터 시트 서비스 메타정보를 조회한다.
        	meta = portalOpenInfScolDao.selectOpenInfScolMeta(params);
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000021", getMessage("portal.error.000021"));
	        }
	        
	        // 공공데이터 시트 서비스 컬럼속성을 검색한다.
	        meta.put("columns", portalOpenInfScolDao.searchOpenInfScolProp(params));
	        
	        // 공공데이터 시트 서비스 조회필터를 검색한다.
	        meta.put("filters", setFilterOptions(portalOpenInfScolDao.searchOpenInfScolFilt(params)));
	        
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        
        return meta;
    }
    
    /**
     * 공공데이터 시트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchOpenInfScolData(Params params) {
    	Paging PagingData = new Paging();
    	try {
    		// 공공데이터 시트 서비스 메타정보를 조회한다.
    		Record meta = portalOpenInfScolDao.selectOpenInfScolMeta(params);
    		
    		params.put("aprvProcYn", meta.getString("aprvProcYn"));
    		
    		// 공공데이터 시트 서비스 테이블명을 조회한다.
    		Record table = portalOpenInfScolDao.selectOpenInfScolTbNm(params);
    		
    		// 소유자명을 설정한다.
    		params.put("ownerName", table.getString("ownerCd"));
    		
    		// 테이블명을 설정한다.
    		params.put("tableName", table.getString("dsId"));
    		
    		// 공공데이터 시트 서비스 조회컬럼을 검색한다.
    		params.put("columnNames", portalOpenInfScolDao.searchOpenInfScolCols(params).toArray());
    		// 공공데이터 시트 서비스 조회조건을 검색한다.
    		params.put("searchConditions", portalOpenInfScolDao.searchOpenInfScolCond(params).toArray());
    		
    		// 공공데이터 시트 서비스 조회필터를 검색한다.
    		params.put("searchFilters", getSearchFilters(portalOpenInfScolDao.searchOpenInfScolFilt(params), params));
    		
    		// 공공데이터 시트 서비스 정렬조건을 검색한다.
    		params.put("sortOrders", portalOpenInfScolDao.searchOpenInfScolSort(params).toArray());
    		
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
    		
    		// 공공데이터 시트 서비스 데이터를 검색한다.
    		PagingData = portalOpenInfScolDao.searchOpenInfScolData(params, params.getPage(), params.getRows());
    		
    		// 20200603/JHKIM - 확장한자 하드코딩(국회의원 인적사항(심상정, 고용진)) 
    		changeScolDataByHanja((List<Record>) PagingData.get(ModelAttribute.DATA), params);
    		
    		// 컬럼 태그 정보 확인하여 데이터를 재정의한다.
    		changeScolDataByColTag((List<Record>) PagingData.get(ModelAttribute.DATA), params);
			
		} catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
     
        //return portalOpenInfScolDao.searchOpenInfScolData(params, params.getPage(), params.getRows());
        return PagingData;
    }
    
    /**
     * 특정의원 확장한자 하드코딩 한다.
     * @param list	DB 실 데이터
     * @param params
     * 국회의원 의원이력			TV_THXPSN10
     * 위원회 위원 명단			TV_HG_INFO
     * 국회의원 위원회 경력		TV_THXPSN13
     * 국회의원 본회의 표결정보	    TV_BILL_VOTE_RESULT
     * 국회의원 인적사항			TV_THXPSN01
     * 역대 국회의원 인적사항             TV_THXPSN01_ALL
     * 역대 국회의원 현황                  TV_VT_MEMBER
     */
    private void changeScolDataByHanja(List<Record> list, Params params) {
    	String dsId = params.getString("tableName");
    	
    	// DATA FOR LOOP..
    	if ( StringUtils.equals(dsId, "TV_THXPSN10") || StringUtils.equals(dsId, "TV_HG_INFO")
    			|| StringUtils.equals(dsId, "TV_THXPSN13") || StringUtils.equals(dsId, "TV_BILL_VOTE_RESULT")
    			|| StringUtils.equals(dsId, "TV_THXPSN01") || StringUtils.equals(dsId, "TV_THXPSN01_ALL") ) {

    		for (int i = 0; i < list.size(); i++) {
				Record data = (Record) list.get(i);
				String hgNm = data.getString("HG_NM");
				if ( StringUtils.equals(hgNm, "심상정") ) {
					data.put("HJ_NM", "沈相奵");
				}
				else if ( StringUtils.equals(hgNm, "고용진") ) {
					data.put("HJ_NM", "高榕禛");
				}
				else if ( StringUtils.equals(hgNm, "민병두") ) {
					data.put("HJ_NM", "閔丙䄈");
				}
			}
    	} else if ( StringUtils.equals(dsId, "TV_VT_MEMBER") ) {
    		
    		for (int i = 0; i < list.size(); i++) {
				Record data = (Record) list.get(i);
				String name = data.getString("NAME");
				if ( StringUtils.equals(name, "심상정") ) {
					data.put("NAME_HAN", "沈相奵");
				}
				else if ( StringUtils.equals(name, "고용진") ) {
					data.put("NAME_HAN", "高榕禛");
				}
				else if ( StringUtils.equals(name, "민병두") ) {
					data.put("NAME_HAN", "閔丙䄈");
				}
			}
    	}
    }
    
    /**
     * 컬럼 태그 정보(구분코드 'D1103') 확인하여 데이터를 재정의한다.
     * @param list	DB 실 데이터
     * @param params
     */
    private void changeScolDataByColTag(List<Record> list, Params params) {
    	String btnImgPrefix = "/img/ggportal/desktop/common/";
    	
    	try {
    		// 컬럼 태그 정보(목록)
    		List<Record> tagList = (List<Record>) portalOpenInfScolDao.searchOpenInfScolColTag(params);
    		// 참조 코드리스트
    		List<Record> refCdList = null;
    		
    		StringBuffer sb = null;
    		
    		// TAG LIST FOR LOOP..
    		for ( Record tag : tagList ) {
    			String gubunCd = tag.getString("valueCd");			// 컬럼 구분코드
    			String colId = tag.getString("colId");				// 구분코드로 설정한 컬럼 ID
    			String colTagCont = tag.getString("colTagCont");	// 구분코드로 설정한 컬럼 ID의 값
    			String saveFileNm = tag.getString("saveFileNm");	// 버튼 이미지 파일명
    			String refCd = tag.getString("refCd");				// 참조코드(공통코드)
    			
    			if ( StringUtils.isNotEmpty(refCd) ) {
    				Params codeParam = new Params();
    				codeParam.set("grpCd", tag.getString("refCd"));
    				refCdList = (List<Record>) portalOpenInfScolDao.selectCommCodeGrpCd(codeParam);
    			}
    			else {
    				if ( refCdList != null && refCdList.size() > 0 ) {
    					refCdList.clear();
    				}
    			}

    			// DATA FOR LOOP..
    			for (int i = 0; i < list.size(); i++) {
    				
    				Record data = (Record) list.get(i);
    				
    				// 컬럼유형 - 버튼팝업(새창안뜸 _self)
    				if ( StringUtils.equals("S", gubunCd) ) {
    					sb = new StringBuffer();
    					
    					if(colId.equals("MP_BOOK_ID")){ //인사청문회 일 경우 URL 값이 있는지 여부 확인
    						if(StringUtils.isNotEmpty((String) data.get("MP_BOOK_URL"))){
    	    					sb.append("<a href=\""+ data.getString(colTagCont) +"\" target=\"_self\" class=\"sheetBtnLink\" data-col-type=\"buttonSelfPop\">");
    							sb.append("<img src=\"");
    							sb.append(btnImgPrefix + saveFileNm);
    							sb.append("\" alt=\"버튼 팝업열기\"></img>");
    							sb.append("</a>");
    						}else{
    							sb.append("");
    						}
    					}else{
        					sb.append("<a href=\""+ data.getString(colTagCont) +"\" target=\"_self\" class=\"sheetBtnLink\" data-col-type=\"buttonSelfPop\">");
    						sb.append("<img src=\"");
    						sb.append(btnImgPrefix + saveFileNm);
    						sb.append("\" alt=\"버튼 팝업열기\"></img>");
    						sb.append("</a>");
    					}
    				}
    				// 컬럼유형 - 버튼팝업(새창)
    				else if ( StringUtils.equals("B", gubunCd) ) {
    					sb = new StringBuffer();
    					//값이 없으면 버튼표출 안함
    					if(StringUtils.isNotEmpty(data.getString(colTagCont))) {
    						sb.append("<a href=\""+ data.getString(colTagCont) +"\" target=\"_blank\" class=\"sheetBtnLink\" data-col-type=\"buttonNewPop\">");
    						sb.append("<img src=\"");
    						sb.append(btnImgPrefix + saveFileNm);
    						sb.append("\" alt=\"새창으로 열기\"></img>");
    						sb.append("</a>");
    					}
    				}
    				// 컬럼유형 - 링크
    				else if ( StringUtils.equals("L", gubunCd) ) {
    					sb = new StringBuffer();
    					sb.append("<a href=\""+ data.getString(colTagCont) +"\" target=\"_blank\" class=\"sheetLink\" data-col-type=\"link\">");
						sb.append(data.getString(colId));
						sb.append("</a>");
    				}
    				// 컬럼유형 - 버튼이미지(REF_CD)
    				else if ( StringUtils.equals("R", gubunCd) ) {	
    					sb = new StringBuffer();
    					String refCdSaveFileNm = "";
    					if ( refCdList.size() > 0 ) {
    						for ( Record r : refCdList ) {
    							if ( StringUtils.equals(data.getString(colId), r.getString("ditcCd")) ) {
    								refCdSaveFileNm = r.getString("saveFileNm");
    							}
    						}
    					}
    					
    					sb.append("<img src=\"");
						sb.append(btnImgPrefix + refCdSaveFileNm);
						sb.append("\" alt=\""+data.getString(colId)+"\"></img>");
    				}
    				// 컬럼유형 - 내용(설정한 컬럼 데이터만 표시)
    				else if ( StringUtils.equals("P", gubunCd) ) {
    					sb = new StringBuffer();
    					sb.append("<a href=\"javascript:;\" class=\"sheetBtnLink\" onclick=\"openSheetClickCont(this)\" data-col-type=\"contPop\">");
						sb.append("<img src=\"");
						sb.append(btnImgPrefix + saveFileNm);
						sb.append("\" alt=\"상세내용 팝업열기\"></img>");
						sb.append("</a>");
						sb.append("<span style='display: none;'>");
    					sb.append(data.getString(colId));
    					sb.append("</span>");	
    				}
    				// 컬럼유형 - 상세내용 전체 표시(Hidden을 제외한)
    				else if ( StringUtils.equals("C", gubunCd) ) {
    					sb = new StringBuffer();
    					sb.append("<a href=\"javascript:;\" class=\"sheetLink\" onclick=\"openSheetClickDetail(this, '"+colId+"')\" data-col-type=\"dtlPop\">");
    					sb.append(data.getString(colId));
						sb.append("</a>");
    				}
    				// 컬럼유형 - 멀티 다운로드
    				else if ( StringUtils.equals("U", gubunCd) ) {
    					sb = new StringBuffer();
    					sb.append("<a href=\"javascript:;\" class=\"sheetBtnLink\" onclick=\"openSheetClickMultiDown(this)\" data-col-type=\"downPop\">");
						sb.append("<img src=\"");
						sb.append(btnImgPrefix + saveFileNm);
						sb.append("\" alt=\"다운로드 팝업열기\"></img>");
						sb.append("</a>");
    				}
    				
    				data.put(colId, sb.toString());
    			}
    		}
			
		}catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 공공데이터 시트 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    public void downloadOpenInfScolDataCUD(HttpServletRequest request, HttpServletResponse response, Params params){
        // 데이터 파일을 다운로드한다.
        downloadDataFile(request, response, params);
    }
    
     /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public List<?> selectRecommandDataSet(Params params) {
    	List<?> meta = new ArrayList<Record>();
    	
        try{
        	// 공공데이터 시트 서비스 메타정보를 조회한다.	 
        	meta = portalOpenInfScolDao.selectRecommandDataSet(params);	//(사용안함)
        	
	        // 메타정보가 없는 경우
	        if (meta == null) {
	        	throw new ServiceException("portal.error.000021", getMessage("portal.error.000021"));
	        }
	        /*
	        // 공공데이터 시트 서비스 컬럼속성을 검색한다.
	        meta.put("columns", portalOpenInfScolDao.searchOpenInfScolProp(params));
	        
	        // 공공데이터 시트 서비스 조회필터를 검색한다.
	        meta.put("filters", setFilterOptions(portalOpenInfScolDao.searchOpenInfScolFilt(params)));
	        */
	        
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        }catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        
        return meta;
    }
    
    /**
     * 대용량 첨부파일을 다운로드한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record downloadBbsFileCUD(Params params) {
        //대용량 첨부파일을 조회한다.
        Record file = selectBbsFile(params);
        
        
        
        return file;
    }
    
    /**
     * 대용량 첨부파일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsFile(Params params) {
        // 게시판 첨부파일을 조회한다.
        Record file = new Record();
        try {
        	Record meta = portalOpenInfScolDao.selectInfNm(params);      
        	String name = meta.getString("INFNM").replaceAll(" ","");
        	
        	name = StringReplace(name);
        	name = name + ".zip";
        	
        	StringBuffer buffer = new StringBuffer();
        	buffer.append(EgovProperties.getProperty("Globals.CsvCreateFilePath"));
        	//buffer.append("DATASET/");
        	buffer.append(name);
        	
        	File f = new File(buffer.toString());
        	long size = f.length();
        	
        	String file_size = Long.toString(size);
        	
        	file.put(FileDownloadView.FILE_PATH, buffer.toString());
        	file.put(FileDownloadView.FILE_NAME, name);
        	file.put(FileDownloadView.FILE_SIZE, file_size);
        	
        	// 공공데이터 서비스 저장이력을 등록한다.
        	portalOpenInfSrvDao.insertOpenInfSavHist(params);
			
		}catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}

			
        return file;
        
        
//        C:/DATA2/upload/bbs/NOTICE\300\350\258.wmv
//        	경기데이터드림 홍보동영상.wmv
//        19498484
        
        
    }
    
    public static String StringReplace(String str){       
      String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
      str =str.replaceAll(match, "_");
      return str;
   }

    /**
     * 유저 파일다운로드 데이터 조회
     */
	@Override
	public List<Record> searchUsrDefFileData(Params params) {
		
		List<Record> data = new ArrayList<Record>();
		
		try {
			// 공공데이터 시트 서비스 메타정보를 조회한다.
    		Record meta = portalOpenInfScolDao.selectOpenInfScolMeta(params);
    		
    		params.put("aprvProcYn", meta.getString("aprvProcYn"));
    		
    		// 공공데이터 시트 서비스 테이블명을 조회한다.
    		Record table = portalOpenInfScolDao.selectOpenInfScolDownTbNm(params);
    		
    		// 소유자명을 설정한다.
    		params.put("ownerName", table.getString("ownerCd"));
    		
    		// 테이블명을 설정한다.
    		params.put("tableName", table.getString("dsId"));
    		
    		// 공공데이터 시트 서비스 조회컬럼을 검색한다.
    		params.put("columnNames", portalOpenInfScolDao.searchOpenInfScolCols(params).toArray());

			data = (List<Record>) portalOpenInfScolDao.searchUsrDefFileData(params);
			
		
		}catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return data; 
		
	}
	
	/**
     * 파일 서비스 데이터를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record searchUsrDefFileOneData(Params params) {
        
    	// 공공데이터 시트 서비스 테이블명을 조회한다.
		Record table = new Record();
		Record file = new Record();
		
        try{
        	// 소유자명을 설정한다.
        	table = portalOpenInfScolDao.selectOpenInfScolDownTbNm(params);
        	params.put("ownerName", table.getString("ownerCd"));
        	
        	// 공공데이터 파일 서비스 데이터를 조회한다.
        	file = portalOpenInfScolDao.searchUsrDefFileOneData(params);
	        
        	// 데이터가 없는 경우
	        if (file == null) {
	            throw new ServiceException("portal.error.000024", getMessage("portal.error.000024"));
	        }
	        
	        // 공공데이터 파일 서비스 조회이력을 등록한다.
	        //portalOpenInfFileDao.insertOpenInfFileHist(params);
	        
	        // 공공데이터 파일 서비스 조회수를 수정한다.
	        portalOpenInfScolDao.updatUesrDefFileHits(params);
	        
	        file.put("dsId", table.getString("dsId"));
	        file.put("rs", getResourceName(file));
	        file.put("fn", getResourceName(file));
	        
	        file.put(FileDownloadView.FILE_PATH, getFilePath(file));
	        file.put(FileDownloadView.FILE_NAME, getFileName(file));
	        file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
      
        } catch (DataAccessException dae) {
        	EgovWebUtil.exTransactionLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exTransactionLogging(sve);
        } catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
        }
        
        return file;
    }
}