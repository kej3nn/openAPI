package egovframework.portal.search.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;



import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.portal.search.service.CollectionVO;
import egovframework.portal.search.service.SearchResultVO;
import egovframework.portal.search.service.SearchService;
import egovframework.portal.search.service.SearchVO;
import egovframework.portal.search.service.WnCollection;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("searchSerivce")
public class SearchServiceImpl extends AbstractServiceImpl implements SearchService {	
	
	private  static Logger LOGGER = LoggerFactory.getLogger(SearchServiceImpl.class);
	/**
     * 통합검색 조회
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	@Override
	public SearchResultVO getSearch(SearchVO srchVo) {
		String [] collections = null;
		//boolean isRealTimeKeyword = false;
		//boolean useSuggestedQuery = true;
		
		int ret = 0 ;
    	int QUERY_LOG = 1; 	//0쿼리로그 없음  1 쿼리로그 남김		
    	int EXTEND_OR = 0;	
		QueryAPI530.Search search = new QueryAPI530.Search();
		SearchResultVO resultVo = new SearchResultVO();
		//String cateCollection = "iopen";

		try{
	    	
	    	String query = getCheckReqXSS(srchVo.getQuery(), "");
	    	String reQuery = getCheckReqXSS(srchVo.getReQuery(), "");
	    	String realQuery = getCheckReqXSS(srchVo.getRealQuery(), "");
	    	String sort = getCheckReqXSS(srchVo.getSort(),"RANK");
	    	String sortOrder = getCheckReqXSS(srchVo.getSortOrder(),"DESC");
	    	String searchField = getCheckReqXSS(srchVo.getSearchField(), "ALL");
	    	String collection = getCheckReqXSS(srchVo.getCollection(), "ALL");
	    	
	    	int viewCount = getCheckInteger(srchVo.getViewCount());
	    	int startCount = getCheckInteger(srchVo.getStartCount());
	    	
	    	String startDate = getCheckReqXSS(srchVo.getStartDate(), "19300101");
	    	startDate = startDate.replaceAll("-", "");
	    	String endDate = getCheckReqXSS(srchVo.getEndDate(), getCurrentDate());
	    	endDate = endDate.replaceAll("-", "");
	    	
	    	if("ALL".equals(collection)){
	    		collections = new String [] { "iopen","iopen_name", "iopen_chairman", "iopen_compass" , "iopen_menu" , "iopen_notice", "iopen_file"};
	    		
	    	}else if("ALLR".equals(collection)){
	    		collections = new String[] {"record1", "record2", "record3" , "record4" , "record5" ,"record6"};
	    		
	    	/*}else if("ALLA".equals(collection)){
	    		collections = new String [] {
		    	"homehelp" ,"assem_act" , "chairman", "notice" , "cmmnt"  
		    		};*/ // 홈페이지 리뉴얼
	    	}else if("ALLA".equals(collection)){
	    		collections = new String [] {
		    	"home_data" ,"home_file"
		    		};
	    	}else{
	    		collections = collection.split(",");
	    		viewCount =  10;
	    		srchVo.setViewCount(viewCount);
	    	}

	    	/*if("ALL".equals(collection) || collection.contains("iopen")){
	    		cateCollection = "iopen";
	    	}else if("ALLR".equals(collection)){
	    		cateCollection ="record1";
	    	}else if("ALLA".equals(collection) || "homehelp".equals(collection) || "home_menu".equals(collection)){
	    		cateCollection = "assem_act"; // 홈페이지 리뉴얼
	    	}else{
	    		cateCollection = collection.split(",")[0];
	    	}*/
	    	
	    	
	    	if("1".equals(reQuery))
	    		realQuery = query + " " + realQuery;
	    	else if(!"2".equals(reQuery) || "".equals(realQuery) )
	    		realQuery = query;
	    	
	    	srchVo.setRealQuery(realQuery);
	    	
	    	
	    	ret = search.w3SetCodePage("UTF-8");
	    	ret = search.w3SetQueryLog(QUERY_LOG);
	    	ret = search.w3SetCommonQuery(realQuery, EXTEND_OR);
	    	String indexColl = "";
	    	
	    	
	    	WnCollection wc = new WnCollection();
	    	HashMap<String,HashMap<String,String>> wnCol = wc.SearchConfig();
	    	
	    	for(String coll : collections) {
	    		
	    		indexColl = wnCol.get(coll).get("collection");
	    		//검색대상 컬렉션 설정
	    		ret = search.w3AddCollection(indexColl);
	    		//가상컬렉션 사용시
	    		//ret = search.w3AddAliasCollection(aliasName, collectionName);
	    		
	    		//쿼리 분석기 옵션 설정
	    		ret = search.w3SetQueryAnalyzer(indexColl, 1, 1, 1 ,1);
	    		//출력리스트 설정
	    		
	    		ret = search.w3SetPageInfo(indexColl, (startCount-1) * viewCount, viewCount);
	    		
	    		//하이라이팅 설정
	    		ret = search.w3SetHighlight(indexColl, 1, 1);
	    		//랭킹옵션  설정
	    		//ret = search.w3SetRanking(indexColl, "basic", "rpfmo", 100);
	    		
	    		ret = search.w3SetRanking(indexColl, "keyword", realQuery, 100);
	    		//결과 정렬
	    		if("RANK".equals(sort))
	    			ret = search.w3SetSortField(indexColl, wnCol.get(coll).get("sortField") );	
	    		ret = search.w3SetSortField(indexColl, sort + "/" + sortOrder );
	    		
	    		String setSearchField = "";
	    		//검색필드 설정
	    		if("ALL".equals(searchField)){
	    			setSearchField = wnCol.get(coll).get("searchField");
	    		}else if ("title".equals(searchField)){
	    			setSearchField = wnCol.get(coll).get("searchTitle");
	    		}else if ("content".equals(searchField)){
	    			setSearchField = wnCol.get(coll).get("searchContent");
	    		}else
	    			setSearchField = wnCol.get(coll).get("searchField");
	    		
	    		ret = search.w3SetSearchField(indexColl, setSearchField);
	    		//검색기간 설정
	    		if(!startDate.equals("19300101") || !endDate.equals(getCurrentDate()))
	    			ret = search.w3SetFilterQuery( indexColl, "<RDATE:gte:"+startDate+"> <RDATE:lte:"+endDate+">");
	    		
	    		//ret = search.w3SetDateRange(indexColl, startDate, endDate);
	    		
	    		ret = search.w3SetDocumentField(indexColl, wnCol.get(coll).get("documentField"));
	    	}
	    	
	    	
	    	
	    	// request
	    	ret = search.w3ConnectServer(srchVo.getSearchIp(), srchVo.getSearchPort(), srchVo.getSearchTimeOut());
	    	ret = search.w3ReceiveSearchQueryResult(0);
	    	String debugMsg =  search.w3GetErrorInfo();
	    	
	    	search.w3ReceiveRecentQueryListResult(0, 5);
	    	
	    	/*String recentQuery = "";
	    	for(int r= 0; r <search.w3GetRecentQueryListSize(); r++ ){
	    		
	    		recentQuery += search.w3GetRecentQuery(r) + ",";
	    		
	    	}*/
	    	
	    	//ret = search.w3AddCategoryGroupBy(cateCollection, "TERMS", "1/SC/50");
	    	
	    	// request
	    	String searchIp =  EgovProperties.getProperty("sf1.searchIp");
			int searchPort = Integer.parseInt( EgovProperties.getProperty("sf1.searchPort"));
			int timeOut = Integer.parseInt( EgovProperties.getProperty("sf1.searchTimeout"));
	    	ret = search.w3ConnectServer(searchIp, searchPort, timeOut);
	    	ret = search.w3ReceiveSearchQueryResult(0);
	    	
	    	int allCount = 0;
	    	ArrayList<CollectionVO> resultList = new ArrayList<CollectionVO>();
	    	for( String coll :  collections){
	    		
	    		CollectionVO colVo = new CollectionVO();
	    		
	    		indexColl =wnCol.get(coll).get("collection");
	    		int totalCount  = search.w3GetResultTotalCount(indexColl);
				int resultCount = search.w3GetResultCount(indexColl);
				
				if(totalCount < 0 )
					totalCount = 0;
				if(resultCount < 0 )
					resultCount = 0;
	    		
				allCount += totalCount;
				
				colVo.setTotalCount(totalCount);
				colVo.setResultCount(resultCount);
				
				ArrayList <HashMap<String, Object>> rList = new ArrayList<HashMap<String, Object>>();
				
				String [] documentField = wnCol.get(coll).get("documentField").split(",");	
				for(int j=0; j < resultCount ;  j++){
					
					HashMap <String, Object> rMap = new HashMap<String, Object>();
					for(int k=0; k < documentField.length; k++){
						
						String [] docFlds = split(documentField[k], "/");
						rMap.put(docFlds[0], search.w3GetField(coll, docFlds[0], j));
						
					}
					rList.add(j, rMap);
				}
				
				colVo.setColIndexName(coll);
				colVo.setColDisplayName(wnCol.get(coll).get("collectionName"));
				colVo.setSrchList(rList);
				resultList.add(colVo);
	    	}
	    	
	    	resultVo.setDebugStr(debugMsg); 
			resultVo.setErrorCode(search.w3GetError());
			resultVo.setAllCount(allCount);
			resultVo.setCollectionList(resultList);
	    	LOGGER.debug("[SF Debug ] : " + debugMsg);
	    	
	    	search.w3CloseServer();
		} catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
		return resultVo;
	}
	
	

	@Override
	public String getArk(Params params) {
		StringBuffer urlSb = new StringBuffer();
		
		String searchIp =  EgovProperties.getProperty("sf1.searchIp");
		int simplePort = Integer.parseInt( EgovProperties.getProperty("sf1.simplePort"));
		String returnStr ="";
		urlSb.append("http://");
		String query= params.get("query").toString();
		
		try {
			query = URLEncoder.encode(query,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			EgovWebUtil.exLogging(e);
		}
		
		urlSb.append(searchIp).append(":").append(simplePort);
		urlSb.append("/WNRun.do?");
		urlSb.append("target=").append(params.get("target"));
		urlSb.append("&charset=UTF-8");
		urlSb.append("&query=").append(query);
		urlSb.append("&datatype=json");
		urlSb.append("&convert=").append(params.get("convert"));
		
		String url = urlSb.toString();
		
		// 반환값 
		returnStr = getHtmls(url);
		// JSON 일떄만 변경 함  .. 버전별로 나오는 순서가 다름 상황에 맞게 수정해야함.
		
		return returnStr;
	}


	@Override
	public String getPopword(Params params) {
		StringBuffer urlSb = new StringBuffer();
		
		String searchIp =  EgovProperties.getProperty("sf1.searchIp");
		int simplePort = Integer.parseInt( EgovProperties.getProperty("sf1.simplePort"));
		String returnStr ="";
		urlSb.append("http://");
		
		urlSb.append(searchIp).append(":").append(simplePort);
		urlSb.append("/WNRun.do?");
		urlSb.append("target=").append(params.get("target"));
		urlSb.append("&charset=UTF-8");
		urlSb.append("&range=").append(params.get("range"));
		urlSb.append("&collection=").append(params.get("collection"));
		urlSb.append("&datatype=json");
		
		String url = urlSb.toString();
		
		// 반환값 
		returnStr = getHtmls(url);
				// JSON 일떄만 변경 함  .. 버전별로 나오는 순서가 다름 상황에 맞게 수정해야함.
		if(returnStr.indexOf("\"Query\":[") == -1){  // N 의 값이 아닐때
			if(returnStr.indexOf("\"Query\"") == -1){ // query 조차 없을때
				returnStr = returnStr.replace(",\"Type\":", ",\"Query\":[],\"Type\":"); // 앞단 추가
			}else{ // 1건일때
				returnStr = returnStr.replace("\"Query\":{", "\"Query\":[{"); // 앞단 추가
				returnStr = returnStr.replace(",\"Type\":", "],\"Type\":"); // 앞단 추가
			}
			
		}
		
		
		return returnStr;
	}
	
	
	/**
	 * 
	 * @param receiverURL :  요청 URL
	 * @param mpVo 
	 * @return
	 */
	private String getHtmls(String url){
		StringBuffer receiveMsg = new StringBuffer();
		int errorCode   = 0;
		HttpURLConnection uc = null;
		int searchTimeOut = Integer.parseInt(EgovProperties.getProperty("sf1.searchTimeout"));
		//
		/*String managerType = mpVo.getManagerType();
		if(mpVo.getDebugType().equals("Y")){
			LOGGER.info("[getHtmls() URL]["+url+"]");
		}*/
		
		BufferedReader in = null;
		
		try{
			// -- receive servlet connect
			URL servletUrl = new URL(url);
			uc = (HttpURLConnection)servletUrl.openConnection();
			uc.setConnectTimeout(searchTimeOut);
			uc.setReadTimeout(searchTimeOut);
			uc.setRequestMethod("POST");
			uc.setDoOutput(true);
			uc.setDoInput(true);
			uc.setUseCaches(false);
			uc.connect();
			// init
			errorCode = 0;
			// -- Network error check
			if(uc.getResponseCode() == HttpURLConnection.HTTP_OK){
				String currLine = new String();
				//UTF-8인 경우
				 in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "UTF-8"));
				//BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
				while ((currLine = in.readLine()) != null){
					receiveMsg.append(currLine).append("\r\n");
				}
			}else{
				errorCode = uc.getResponseCode();
				/*receiveMsg.setLength(0);
				
				if(managerType.equals(WNDefine.ARK)){ // 자동완성
					receiveMsg.append(arkErrorMsg( (ArkVO)mpVo , errorCode) ) ;
				}else if(managerType.equals(WNDefine.POPWORD)){ // 인기검색어
					receiveMsg.append(popwordErrorMsg( (PopWordVO)mpVo , errorCode) ) ;
				}else if(managerType.equals(WNDefine.RECOMMEND)){ // 추천검색어
					receiveMsg.append(recommendErrorMsg( (RecommendVO)mpVo , errorCode) ) ; 
				}
				*/
				
			}
		}catch(IOException ex){
			receiveMsg.setLength(0);
		}finally{
			if(uc != null) {
				try{
					uc.disconnect();
				} catch (Exception e) {
					EgovWebUtil.exLogging(e);
				}
			} else if ( in != null){
				try {
					in.close();
                }
                catch (IOException ioe) {
                	EgovWebUtil.exLogging(ioe);
                }
			}
		}
		
		return receiveMsg.toString();
	}
	
	
	
	@Override
	public HashMap<String, Object> getGroup(SearchVO srchVo) {
		
		int ret = 0 ;
    	int QUERY_LOG = 1; 	//0쿼리로그 없음  1 쿼리로그 남김		
    	int EXTEND_OR = 1;	
    	HashMap<String, Object> hMap = new HashMap<String, Object>();
		QueryAPI530.Search search = new QueryAPI530.Search();
	   try{
	    	
	    	String query = getCheckReqXSS(srchVo.getQuery(), "");
	    	String sort = getCheckReqXSS(srchVo.getSort(),"RANK");
	    	String sortOrder = getCheckReqXSS(srchVo.getSortOrder(),"DESC");
	    	String groupField = getCheckReqXSS(srchVo.getGroupField(), "A");
	    	String collection = getCheckReqXSS(srchVo.getCollection(), "iopen");
	    	
	    	String startDate = getCheckReqXSS(srchVo.getStartDate(), "19300101");
	    	String endDate = getCheckReqXSS(srchVo.getEndDate(), getCurrentDate());
	    	
	    	
	    	
	    	if("ALL".equals(collection) || collection.contains("iopen")){
	    		collection = "iopen";
	    	}else if("ALLA".equals(collection) || "homehelp".equals(collection) || "home_menu".equals(collection)){
	    			collection = "assem_act";
	    	}else if("nas".equals(collection)){
	    		collection ="nas_file";
	    	}else if (collection.contains("committee")){
	    		collection = "committee_file";
	    	}
	    	
	    	ret = search.w3SetCodePage("UTF-8");
	    	ret = search.w3SetQueryLog(QUERY_LOG);
	    	ret = search.w3SetCommonQuery(query, EXTEND_OR);
	    	
	    	String indexColl = collection;
	    	WnCollection wc = new WnCollection();
	    	HashMap<String,HashMap<String,String>> wnCol = wc.SearchConfig();
    		//검색대상 컬렉션 설정
    		ret = search.w3AddCollection(indexColl);
    		
    		//쿼리 분석기 옵션 설정
    		ret = search.w3SetQueryAnalyzer(indexColl, 1, 1, 1 ,1);
    		//출력리스트 설정
    		ret = search.w3SetPageInfo(indexColl, (1-1) * 10, 10);
    		
    		//하이라이팅 설정
    		//랭킹옵션  설정
    		//결과 정렬
    		if("RANK".equals(sort))
    			ret = search.w3SetSortField(indexColl, wnCol.get(indexColl).get("sortField") );	
    		ret = search.w3SetSortField(indexColl, sort + "/" + sortOrder );
    		
    		String setSearchField = "";
    		if(!"A".equals(groupField)){
    			setSearchField = "TERMS,TOPIC";
    		}else
    			setSearchField = wnCol.get(indexColl).get("searchField");
    		ret = search.w3SetSearchField(indexColl, setSearchField);
    		
    		
    		//System.out.println("groupField  :  " + groupField  + " : " + setSearchField);
    		
    		ret = search.w3SetFilterQuery( indexColl, "<RDATE:gte:"+startDate+"> <RDATE:lte:"+endDate+">");
    		//검색기간 설정
    		//ret = search.w3SetDateRange(indexColl, startDate, endDate);
    		
    		ret = search.w3SetDocumentField(indexColl, wnCol.get(indexColl).get("documentField"));
	    	
	    	ret = search.w3AddCategoryGroupBy(indexColl, "TERMS", "1/SC/50");
	    	ret = search.w3AddCategoryGroupBy(indexColl, "TOPIC", "1/SC/50");
	    	//ret = search.w3AddCategoryGroupBy(indexColl, "TOPIC", "2/SC/50");
	    	
	    	// request
	    	String searchIp =  EgovProperties.getProperty("sf1.searchIp");
			int searchPort = Integer.parseInt( EgovProperties.getProperty("sf1.searchPort"));
			int timeOut = Integer.parseInt( EgovProperties.getProperty("sf1.searchTimeout"));
	    	ret = search.w3ConnectServer(searchIp, searchPort, timeOut);
	    	ret = search.w3ReceiveSearchQueryResult(0);
	    	int cateCount = search.w3GetCategoryCount(indexColl, "TERMS", 1);
	    	
	    	ArrayList<Object> resultList = new ArrayList<Object>();
	    	
	    	 for(int i = 0; i < cateCount; i++ ) {
	             String name = search.w3GetCategoryName( indexColl, "TERMS", 1, i );
	             int count = search.w3GetDocumentCountInCategory( indexColl, "TERMS", 1, i );
	             
	             HashMap<String,String> resultMap = new HashMap<String,String>();
	             if(name.equals("null")) continue;
	             //System.out.println("TERM = "   + name);
	             resultMap.put("rank",i+1+"");
	             resultMap.put("key",name);
	             resultMap.put("value",Integer.toString(count));
	             resultList.add(resultMap);
	         }
	    	 
	    	 ArrayList<Object> resultList1 = new ArrayList<Object>();
	    	
	    	 int cateCount1 = search.w3GetCategoryCount(indexColl, "TOPIC", 1);
	    	 
	    	 if(cateCount1 >1 ){
		    	 for(int i = 0; i < cateCount1; i++ ) {
		             String name = search.w3GetCategoryName( indexColl, "TOPIC", 1, i );
		             
		             //System.out.println( "1depth : "+ search.w3GetCategoryName( indexColl, "TOPIC", 1, i )  );
		            
		             int count = search.w3GetDocumentCountInCategory( indexColl, "TOPIC", 1, i );
		             
		             HashMap<String,String> resultMap = new HashMap<String,String>();
		             if(name.equals("null")) continue;
		             
		             String names [] = name.split("@");
		             
		             if (names.length >1) {
						name = names[1];
					}
		              
		             resultMap.put("rank",i+1+"");
		             resultMap.put("key",name);
		             resultMap.put("value",Integer.toString(count));
		             resultList1.add(resultMap);
		         }
	    	 }
	    	 
	    	hMap.put("terms", resultList);
	    	hMap.put("topic", resultList1);
	    	
	    } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
	   return hMap;
	}	
	
	 public String getCurrentDate() {
	        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat
	                ("yyyyMMdd", java.util.Locale.KOREA);
	        return dateFormat.format(new java.util.Date());
	}
	
    public String getCheckReqXSS( String parameter, String default_value) {
        String req_value = (parameter == null ||  parameter.equals("")) ? default_value : parameter;
        req_value = req_value.replaceAll("</?[a-zA-Z][0-9a-zA-Z가-\uD7A3ㄱ-ㅎ=/\"\'%;:()\\-# ]+>","");
        req_value = req_value.replaceAll(">","");
        req_value = req_value.replaceAll(">","");
        return req_value;
    }
    
    public int getCheckInteger( int num) {
    	
    	if(num > Integer.MAX_VALUE){
    		num = 0;
    	}
        return num;
    }
    
    
    public static String[] split(String splittee, String splitChar){
        String taRetVal[] = null;
        StringTokenizer toTokenizer = null;
        int tnTokenCnt = 0;

        toTokenizer = new StringTokenizer(splittee, splitChar);
        tnTokenCnt = toTokenizer.countTokens();
        taRetVal = new String[tnTokenCnt];

        for(int i=0; i<tnTokenCnt; i++) {
            if(toTokenizer.hasMoreTokens())	taRetVal[i] = toTokenizer.nextToken();
        }
        
        return taRetVal ;
    }


}
