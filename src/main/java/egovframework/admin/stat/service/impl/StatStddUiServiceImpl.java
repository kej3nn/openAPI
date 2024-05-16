package egovframework.admin.stat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatStddUiService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 통계표 표준 단위 정의 서비스
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/06/28
 */

@Service(value="statStddUiService")
public class StatStddUiServiceImpl extends BaseService implements StatStddUiService {

	@Resource(name="statStddUiDao")
	protected StatStddUiDao statStddUiDao;

	/**
	 * 표준단위정보 메인 리스트 조회
	 */
	@Override
	public List<Record> statStddUiList(Params params) {
		return statStddUiDao.selectStatStddUiList(params);
	}

	/**
	 * 표준단위정보 상세 조회
	 */
	@Override
	public Map<String, Object> statStddUiDtl(Map<String, String> paramMap) {
		return statStddUiDao.selectStatStddUiDtl(paramMap);
	}
	
	/**
	 * 표준단위정보 중복체크(등록시)
	 */
	@Override
	public Map<String, Integer> statStddUiDupChk(Params params) {
		return (Map<String, Integer>) statStddUiDao.selectStatStddUiDupChk(params);
	}

	/**
	 * 표준단위정보 CUD 처리
	 */
	@Override
	public Result saveStatStddUi(Params params) {
		boolean result = false;
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, Object> dtlMap = new HashMap<String, Object>();
		
		try {
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				statStddUiDao.insertStatStddUi(params);
				result = true;
			} else if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				paramMap.put("uiId", params.getString("uiId"));
				dtlMap = statStddUiDtl(paramMap);
				String sPreParUiId = String.valueOf(dtlMap.get("grpUiId"));	//변경 전 상위항목 ID
				String sParUiId = params.getString("grpUiId");				//변경 후 상위항목 ID
				if ( !sPreParUiId.equals(sParUiId) ) {		//상위 항목구분이 변경되었을경우
					String sIsLeaf = String.valueOf(statStddUiDao.selectStatStddUiIsLeaf(params.getString("uiId")));	
					if ( "Y".equals(sIsLeaf) ) {
						throw new ServiceException("변경하려는 항목에 자식항목이 있어 변경할 수 없습니다.");
					}					
				}
				int cnt = (Integer) statStddUiDao.updateStatStddUi(params);
				if ( cnt > 0 ) {
					result = true;
				}
			} else if ( ModelAttribute.ACTION_DEL.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				String sItmId = params.getString("uiId");
				String sIsLeaf = String.valueOf(statStddUiDao.selectStatStddUiIsLeaf(sItmId));	
				if ( "Y".equals(sIsLeaf) ) {
					throw new ServiceException("삭제하려는 항목에 자식항목이 있습니다\n자식항목 먼저 삭제해 주세요.");
				}
				statStddUiDao.deleteStatStddUi(params);
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
	 * 표준단위정보 순서저장
	 */
	@Override
	public Result saveStatStddUiOrder(Params params) {
		Params[] data = params.getJsonArray(Params.SHEET_DATA);
		try {
			for (int i = 0; i < data.length; i++) {
				statStddUiDao.saveStatStddUiOrder(data[i]);
			}
		} catch(DataAccessException dae) {
			error("Exception : " , dae);
			EgovWebUtil.exTransactionLogging(dae);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000004"));
	}
	
	/**
	 * 표준단위정보 단위 그룹 조회
	 */
	public List<Record> statStddGrpUiListPaging(Params params) {
		return statStddUiDao.selectStatStddGrpUiList(params);
	}

	/**
	 * 표준단위정보 팝업 리스트 조회
	 */
	@Override
	public List<Record> statStddUiPopList(Params params) {
		return (List<Record>) statStddUiDao.selectStatStddUiPopList(params);
	}
	
}
