package egovframework.admin.stat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONException;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatStddMetaService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 통계표 표준메타 정의 서비스
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/07/03
 */

@Service(value="statStddMetaService")
public class StatStddMetaServiceImpl extends BaseService implements StatStddMetaService {

	@Resource(name="statStddMetaDao")
	protected StatStddMetaDao statStddMetaDao;

	/**
	 * 표준메타정보 메인 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> statStddMetaListPaging(Params params) {
		return statStddMetaDao.selectStatStddMetaList(params);
	}

	/**
	 * 표준메타정보 상세 조회
	 */
	@Override
	public Map<String, Object> statStddMetaDtl(Map<String, String> paramMap) {
		return statStddMetaDao.selectStatStddMetaDtl(paramMap);
	}
	
	/**
	 * 표준메타정보 CUD 처리
	 */
	@Override
	public Result saveStatStddMeta(Params params) {
		boolean result = false;
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, Object> dtlMap = new HashMap<String, Object>();
		
		try {
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				statStddMetaDao.insertStatStddMeta(params);
				result = true;
			} else if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				int cnt = (Integer) statStddMetaDao.updateStatStddMeta(params);
				if ( cnt > 0 ) { 
					result = true;
				}
			} else if ( ModelAttribute.ACTION_DEL.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				statStddMetaDao.deleteStatStddMeta(params);
				result = true;
			}
		} catch (ServiceException sve) {
			return failure("시스템 오류가 발생하였습니다.");
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
	 * 표준메타정보 순서저장
	 */
	@Override
	public Result saveStatStddMetaOrder(Params params) {
		Params[] data = params.getJsonArray(Params.SHEET_DATA);
		try {
			for (int i = 0; i < data.length; i++) {
				statStddMetaDao.saveStatStddMetaOrder(data[i]);
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
	
}
