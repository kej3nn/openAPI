package egovframework.hub.service.impl.heler;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import egovframework.common.HubConfig;
import egovframework.hub.service.Hub;
import egovframework.hub.service.impl.HubDAO;
import egovframework.common.util.UtilNumber;
import egovframework.common.util.UtilString;

/**
 * 서비스 대상의 Data Error check 하는 class
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
@Component
public class HubErrorCheckHelper {
	@Resource(name = "HubDAO")
    public HubDAO hubDao;
	protected static final Log logger = LogFactory.getLog(HubErrorCheckHelper.class);
	
	/**
	 * 사용자 인증키의 에러를 체크하여 에러메시지를 셋팅한다.
	 * @param hub
	 * @param hubErrorMsg
	 * @throws Exception
	 */
	public void checkUsrKey(Hub hub) {
    	if(UtilString.null2Blank(hub.getActKey()).equals("") ){ //sample 제외
    		return ;
    	}
    	if(!UtilString.null2Blank(hub.getMsgString()).equals("")){ //기존 에러가 있으면 리턴
			return ;
		}
    	List<HashMap<?,?>> result = hubDao.selectCheckUsrKey(hub); //인증키 조회
    	if(result.size() > 0){ 
    		for(HashMap<?,?> map : result){
    			if(((String)map.get("KEY_STATE")).equals("P")){ //사용중지
    				hub.setMsgString(hub.getErrPause());
    			} 
    			if(!((String)map.get("LIMIT_CD")).equals("NONE")){ //이용제한
    				hub.setMsgString(hub.getInfoUseKeyLimits());
    			}
    			//KEY LOG 정보 기록
    			hub.setUserCd(((BigDecimal)map.get("USER_CD")).intValue());
    			hub.setKeySeq(((BigDecimal)map.get("KEY_SEQ")).intValue());
    		}
    	}else{ //인증키 없음
    		hub.setMsgString(hub.getErrKey());
    	}
    }
	
	/**
	 * 1일 트랙픽 제한을 체크한다.
	 * @param hub
	 * @param hubErrorMsg
	 * @throws Exception
	 */
	public void checkApiTrf(Hub hub) {
		if(UtilString.null2Blank(hub.getActKey()).equals("") ){
    		return ;
    	}
    	if(!UtilString.null2Blank(hub.getMsgString()).equals("")){ //기존 에러가 있으면 리턴
			return ;
		}
    	int apTrfCnt = hubDao.selectApiTrf(hub) ;
    	if( apTrfCnt > 0){ 
    		hub.setMsgString(hub.getErrApiTrf());
    	}
    }
    
    /**
     * 조회하는 페이지번호, 사이즈가 숫자인지 판단하여 에러메시지를 셋팅한다.
     * @param value
     * @param hubErrorMsg
     * @throws Exception
     */
    public void checkDataType(String value,Hub hub){
    	if(!UtilString.null2Blank(hub.getMsgString()).equals("")){ //기존 에러가 있으면 리턴
			return ;
		}
    	//값이 있으면서 숫자가 아닐경우
    	if(!UtilNumber.isInt(value)){
    		hub.setMsgString(hub.getErrCntType());
    	}
    }
    
    /**
     * 조회건수가 HubConfig.HUB_DATA_MAX보다 크면 에레메시지를 셋팅한다.
     * @param value
     * @param hubErrorMsg
     * @throws Exception
     */
    public void checkDataMax(String value,Hub hub){
    	if(!UtilString.null2Blank(hub.getMsgString()).equals("")){ //기존 에러가 있으면 리턴
			return ;
		}
    	if(Integer.parseInt(value) > HubConfig.HUB_DATA_MAX){ 
    		hub.setMsgString(hub.getErrCntTypeKey());
    	}
    }
    
    /**
     * 서비스가 존재하는지 체크하여 에러메시지를 셋팅한다.
     * @param hub
     * @param hubErrorMsg
     * @throws Exception
     */
    public void checkService(Hub hub) {
    	List<HashMap<?,?>> result = hubDao.selectService(hub); //서비스 존재 여부
    	if(result.size() < 1){ 
    		hub.setMsgString(hub.getErrService());
    	}else{
    		for(HashMap<?,?> map : result){
    			hub.setDsId((String)map.get("DS_ID"));
    			hub.setInfId((String)map.get("INF_ID"));
    			hub.setInfSeq(((BigDecimal)map.get("INF_SEQ")).intValue());
    			hub.setOwnerCd((String)map.get("OWNER_CD"));
    			hub.setDsCd((String)map.get("DS_CD"));
    		}
    	}
    }
    
    /**
     * 사용자 필수 변수를 체크하여 에러메시지를 반환한다.
     * @param hub
     * @param hubErrorMsg
     * @throws Exception
     */
    public void checkRegNeed(Hub hub) {
    	if(!UtilString.null2Blank(hub.getMsgString()).equals("")){ //기존 에러가 있으면 리턴
			return ;
		}
    	List<HashMap<?,?>> result = hubDao.selectServiceRegNeed(hub); //변수 필수 체크
    	if(result.size() > 0){ 
    		HashMap<String, String> paramMap = hub.getQueryMap();
    		for(HashMap<?,?> map : result){
    			if(UtilString.null2Blank(paramMap.get((String)map.get("COL_ID"))).equals("")){
    				hub.setMsgString(hub.getErrMdt());
    			}
    		}
    	}
    }
}
