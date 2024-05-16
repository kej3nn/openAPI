package egovframework.admin.stat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.stat.service.StatStddItmService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 통계표 표준 항목 분류 정의 서비스
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/06/26
 */

@Service(value="statStddItmService")
public class StatStddItmServiceImpl extends BaseService implements StatStddItmService {

	@Resource(name="statStddItmDao")
	protected StatStddItmDao statStddItmDao;

	/**
	 * 표준항목분류정보 메인 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> statStddItmListPaging(Params params) {
		return statStddItmDao.selectStatStddItmList(params);
	}

	/**
	 * 표준항목분류정보 상세 조회
	 */
	@Override
	public Map<String, Object> statStddItmDtl(Map<String, String> paramMap) {
		//Map<String, Object> rMap = new HashMap<String, Object>();
		//rMap.put("DATA", statStddItmDao.selectStatStddItmDtl(paramMap));
		return statStddItmDao.selectStatStddItmDtl(paramMap);
	}

	/**
	 * 표준항목분류정보 CUD 처리
	 */
	@Override
	public Result saveStatStddItm(Params params) {
		boolean result = false;
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, Object> dtlMap = new HashMap<String, Object>();
		
		try {
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				statStddItmDao.insertStatStddItm(params);
				result = true;
			} else if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				/*
				paramMap.put("itmId", params.getString("itmId"));
				dtlMap = statStddItmDtl(paramMap);
				String sPreParItmId = String.valueOf(dtlMap.get("parItmId"));	//변경 전 상위항목 ID
				String sParItmId = params.getString("parItmId");				//변경 후 상위항목 ID
				if ( !sPreParItmId.equals(sParItmId) ) {	//상위 항목구분이 변경되었을경우
					//변경 전 상위항목 구분 자식 존재여부 조회
					String sIsLeaf = String.valueOf(statStddItmDao.selectStatStddItmIsLeaf(sParItmId));	
					if ( "Y".equals(sIsLeaf) ) {
						throw new ServiceException("변경 하기 전 상위항목 구분에 자식항목이 있습니다.\n자식이 있는 항목은 상위 항목구분을 변경할 수 없습니다.");
					}
				}
				*/
				paramMap.put("itmId", params.getString("itmId"));
				dtlMap = statStddItmDtl(paramMap);
				String sPreParItmId = String.valueOf(dtlMap.get("parItmId"));	//변경 전 상위항목 ID
				String sParItmId = params.getString("parItmId");				//변경 후 상위항목 ID
				if ( !sPreParItmId.equals(sParItmId) ) {	//상위 항목구분이 변경되었을경우
					String sItmId = params.getString("itmId");
					String sIsLeaf = String.valueOf(statStddItmDao.selectStatStddItmIsLeaf(sItmId));	
					if ( "Y".equals(sIsLeaf) ) {
						throw new ServiceException("변경하려는 항목에 자식항목이 있어 변경할 수 없습니다.");
					}					
				}
				int cnt = (Integer) statStddItmDao.updateStatStddItm(params);
				if ( cnt > 0 ) {
					result = true;
				}
			} else if ( ModelAttribute.ACTION_DEL.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				String sItmId = params.getString("itmId");
				String sIsLeaf = String.valueOf(statStddItmDao.selectStatStddItmIsLeaf(sItmId));	
				if ( "Y".equals(sIsLeaf) ) {
					throw new ServiceException("삭제하려는 항목에 자식항목이 있습니다\n자식항목 먼저 삭제해 주세요.");
				}
				statStddItmDao.deleteStatStddItm(params);
				result = true;
			}
		} catch (ServiceException sve) {
			return failure(getMessage("시스템 오류가 발생하였습니다"));
        } catch (Exception e) {
            return failure("시스템 오류가 발생하였습니다.");
        }
		
		if ( result ) {
			return success(getMessage("admin.message.000007"));	//처리가 완료되었습니다
		} else {
			return failure(getMessage("admin.error.000003"));	//저장에 실패하였습니다.
		}
	}

	/**
	 * 표준항목분류명 저장
	 */
	@Override
	public Result saveStatStddItmNm(Params params) {
		CommUsr loginVO = null;
		Params[] data = params.getJsonArray(Params.SHEET_DATA);
		
		if(EgovUserDetailsHelper.isAuthenticated()) {
        	//사용자 인증
    		EgovUserDetailsHelper.getAuthenticatedUser();
    		loginVO = (CommUsr)EgovUserDetailsHelper.getAuthenticatedUser();
        }
        
		
		String updId = "";
		if (loginVO != null) {
			updId = StringUtils.defaultString(loginVO.getUsrId());
		}
		
        for (int i = 0; i < data.length; i++) {
        	//분류명을 저장한다.
        	data[i].put("updId", updId);
            statStddItmDao.saveStatStddItmNm(data[i]);
        }
        
		return success(getMessage("저장이 완료되었습니다."));
	}

	/**
	 * 표준항목분류 순서저장
	 */
	@Override
	public Result saveStatStddItmOrder(Params params) {
		Record rec = null;
		try {
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for (int i = 0; i < jsonArray.length(); i++) {
	        	rec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
        		rec.put("itmId", jsonObj.getString("itmId"));
        		rec.put("vOrder", jsonObj.getInt("vOrder"));
        		statStddItmDao.saveStatStddItmOrder(rec);
	        		
			}
		} catch(JSONException je) {
			error("Exception : " , je);
			EgovWebUtil.exTransactionLogging(je);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));	
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000004"));
	}
	
}
