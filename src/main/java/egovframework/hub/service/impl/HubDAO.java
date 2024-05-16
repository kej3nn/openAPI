package egovframework.hub.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.hub.service.Hub;

/**
 * OPEN API DB에 접근하는 Class
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
@Repository("HubDAO")
public class HubDAO extends EgovComAbstractDAO {

    
    /**
     * OPEN API사용하는 MessageList를 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<HashMap<?,?>> selectApiMessageList(Hub hub)  {
       	return (List<HashMap<?, ?>>) list("HubListDao.selectApiMessageList", hub);
    }

    /**
     * 사용자 인증키를 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<HashMap<?,?>> selectCheckUsrKey(Hub hub)  {
       	return (List<HashMap<?, ?>>) list("HubListDao.selectCheckUsrKey", hub);
     }
    
    /**
     * 1일 트랙픽 체크를 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
   	public int selectApiTrf(Hub hub)  {
       	return (Integer)selectByPk("HubListDao.selectApiTrf", hub);
     }
    
    /**
     * OPEN API 서비스를 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<HashMap<?,?>> selectService(Hub hub)  {
       	return (List<HashMap<?, ?>>) list("HubListDao.selectService", hub);
     }
    
    /**
     * 서비스의 필수 사용자 변수를 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<HashMap<?,?>> selectServiceRegNeed(Hub hub)  {
       	return (List<HashMap<?, ?>>) list("HubListDao.selectServiceRegNeed", hub);
     }
    
    
    /**
     * 서비스 대상의 조회 컬럼을 목록을 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<LinkedHashMap<?,?>> selectServiceColList(Hub hub)  {
       	return (List<LinkedHashMap<?, ?>>) list("HubListDao.selectServiceColList", hub);
     }
    
    /**
     * 서비스 대상의 조회 CDATA 목록을 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<LinkedHashMap<?,?>> selectServiceColCdataList(Hub hub)  {
       	return (List<LinkedHashMap<?, ?>>) list("HubListDao.selectServiceColCdataList", hub);
     }
    
    /**
     * 서비스 대상의 시스템 변수 목록을 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<LinkedHashMap<?,?>> selectServiceSystemValList(Hub hub)  {
       	return (List<LinkedHashMap<?, ?>>) list("HubListDao.selectServiceSystemValList", hub);
     }
    
    /**
     * 서비스 대상의 사용자 변수 목록을 조회한다.
     * @param hub
     * @return
     * @
     */
    @SuppressWarnings("unchecked")
   	public List<LinkedHashMap<?,?>> selectServiceUserValList(Hub hub)  {
       	return (List<LinkedHashMap<?, ?>>) list("HubListDao.selectServiceUserValList", hub);
     }
    
    /**
     * 서비스 대상의 정렬 순서 목록을 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
   	public List<LinkedHashMap<?,?>> selectServiceOrderByList(Hub hub)  {
       	return (List<LinkedHashMap<?, ?>>) list("HubListDao.selectServiceOrderByList", hub);
     }
    
    /**
     * OPEN API  real data를 조회한다.
     * @param hub
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<LinkedHashMap<?,?>> selectHubData(Hub hub)  {
    	return (List<LinkedHashMap<?, ?>>) list("HubListDao.selectHubData", hub);
    }
    
	/**
	 * OPEN API real data 갯수를 조회한다.
	 * @param hub
	 * @return
	 * @throws Exception
	 */
	public Object selectHubDataCnt(Hub hub)  {
    	return selectByPk("HubListDao.selectHubDataCnt", hub);
    }
    
    /**
     * LOG 기록을 INSERT 한다. 
     * 인증키 여부를 따라서 쿼리 목록이 변경된다.
     * @param hub
     * @throws Exception
     */
    public void insertLog(Hub hub)  {
    	if(!hub.getActKey().equals("")){
    		 insert("HubListDao.insertLog", hub);
    	}else{
    		insert("HubListDao.insertLogSimple", hub);
    	}
    }
    
}
