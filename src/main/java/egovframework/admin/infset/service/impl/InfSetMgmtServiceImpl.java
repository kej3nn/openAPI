package egovframework.admin.infset.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.nhncorp.lucy.security.xss.XssSaxFilter;

import egovframework.admin.infset.service.InfSetMgmtService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 정보셋을 관리하는 서비스 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/07/29
 */

@Service(value="infSetMgmtService")
public class InfSetMgmtServiceImpl extends BaseService implements InfSetMgmtService {

	@Resource(name="infSetMgmtDao")
	protected InfSetMgmtDao infSetDao;

	/**
	 * 메인 리스트 조회(페이징 처리)
	 */
	@Override
	public Paging selectInfSetMainListPaging(Params params) {
		// 분류체계 여러개 검색(IN 절)
		if ( StringUtils.isNotEmpty(params.getString("cateIds")) ) {
			ArrayList<String> iterCateId = new ArrayList<String>(Arrays.asList(params.getString("cateIds").split(",")));
			params.set("iterCateId", iterCateId);
		}
		
		// 공개유형 여러개 검색체크
		if ( !StringUtils.isEmpty(params.getString("openTypeDoc")) || !StringUtils.isEmpty(params.getString("openTypeOpen")) 
				|| !StringUtils.isEmpty(params.getString("openTypeStat"))) {
			params.set("openTypeExist", "Y");
		}
		
		Paging list = infSetDao.selectMainList(params, params.getPage(), params.getRows());
		return list;
	}
	
	/**
	 * 정보셋 분류체계 팝업 조회
	 */
	@Override
	public List<Record> selectInfSetCatePop(Params params) {
		return infSetDao.selectInfSetCatePop(params);
	}

	/**
	 * 상세 데이터 조회
	 */
	@Override
	public Record selectDtl(Params params) {
		return infSetDao.selectDtl(params);
	}

	/**
	 * 정보셋 관리 데이터 저장
	 */
	@Override
	public Result saveInfSet(Params params) {
		try {
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				// 신규 시퀀스 조회
				params.put("seq", infSetDao.getSqInfoInfsSeq());
				
				// 신규 정보ID 조회
				params.put("infsId", infSetDao.getInfsId(params));
			}
			
			// 정보셋 마스터 정보 등록
			saveInfSetMst(params);
			
			// 정보셋 키워드 등록
			saveInfSetTag(params);
			
			// 정보셋 관리 분류 등록
			saveInfoSetCate(params);
			
			// 정보셋 관리 담당자 등록
			saveInfoSetUsr(params);
			
			// 정보셋 마스터정보 대표여부 데이터 수정(위 트랜젝션(대표여부 데이터) 처리후 수정됨)
			int updCnt = (Integer) infSetDao.updateInfoSetMstRpst(params);
			if ( updCnt <= 0 ) {
				throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
			
			// 데이터 백업
			infSetDao.execSpBcupInfoSet(params);
			
			//데이터 처리진행코드에 따른 메시지
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				return success(getMessage("admin.message.000003"));
			} else if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				return success(getMessage("admin.message.000004"));
			} else {
				return success(getMessage("admin.message.000003"));
			}
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			EgovWebUtil.exTransactionLogging(dae);
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}
	
	/**
	 * 정보셋 마스터정보 데이터 등록/수정
	 */
	private void saveInfSetMst(Params params) {
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
		
		if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {
			infSetDao.insertInfoSetMst(params);
		} 
		else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
			infSetDao.updateInfoSetMst(params);
		}
	}
	
	/**
	 * 정보셋 데이터 삭제
	 */
	public Result deleteInfSet(Params params) {
		try {
			// 백업 후 삭제
			infSetDao.execSpBcupInfoSet(params);
			
			return success(getMessage("admin.message.000005"));	//삭제가 완료 되었습니다.
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}
	
	/**
	 * 정보셋 태그 수정
	 */
	private void saveInfSetTag(Params params) {
		String infsId = params.getString("infsId");
		String schwTagCont = params.getString("schwTagCont");
		String[] schwTagContArr = schwTagCont.split(",");
		
		if ( schwTagContArr.length > 0 ) {
			// DELETE 하고
			infSetDao.deleteInfSetTag(params);
			
			// FOR LOOP INSERT
			for ( String tag : schwTagContArr ) {
				Record record = new Record();
				record.put("infsId", infsId);
				record.put("tagNm", tag);
				infSetDao.insertInfSetTag(record);
			}
		}
	}
	
	/**
	 * 정보셋 관리 관련 분류 조회
	 */
	@Override
	public List<Record> selectInfoSetCate(Params params) {
		return infSetDao.selectInfoSetCate(params);
	}
	/**
	 * 정보셋 관리 관련 분류 등록 저장
	 */
	public void saveInfoSetCate(Params params) throws JSONException {
		Record record = null;
		String infsId = params.getString("infsId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		
		JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson2")).getJSONArray("data");
		for ( int i=0; i < jsonArray.length(); i++ ) {
			JSONObject jObj = (JSONObject) jsonArray.get(i);
			String status = jObj.getString("status");
			record = new Record();
			record.put("infsId", infsId);
			record.put("cateId", jObj.getString("cateId"));
			
			// 삭제로 넘어온 행
			if ( StringUtils.equals(status, ModelAttribute.ACTION_DEL) ) {
				infSetDao.deleteInfoSetCate(record);
			}
			else if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) || StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
				record.put("regId", regId);
				record.put("updId", updId);
				record.put("rpstYn", jObj.getString("rpstYn"));
				record.put("useYn",  jObj.getString("useYn"));
				infSetDao.mergeInfoSetCate(record);
			}
		}
	}
	
	/**
	 * 정보셋 관리 관련 유저 조회
	 */
	public List<Record> selectInfoSetUsr(Params params) {
		return infSetDao.selectInfoSetUsr(params);
	}
	/**
	 * 정보셋 관리 관련 담당자 CUD
	 */
	public void saveInfoSetUsr(Params params) throws JSONException {
		
		Record record = null;
		String infsId = params.getString("infsId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		
		JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
		for ( int i=0; i < jsonArray.length(); i++ ) {
			JSONObject jObj = (JSONObject) jsonArray.get(i);
			String status = jObj.getString("status");
			record = new Record();
			record.put("infsId", infsId);
			record.put("seqceNo", jObj.getString("seqceNo"));
			
			// 삭제로 넘어온 행
			if ( StringUtils.equals(status, ModelAttribute.ACTION_DEL) ) {
				infSetDao.deleteInfoSetUsr(record);
			}
			else if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) || StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
				record.put("regId", regId);
				record.put("updId", updId);
				record.put("orgCd", jObj.getString("orgCd"));
				record.put("usrCd", StringUtils.isEmpty(jObj.getString("usrCd")) ? "0" : jObj.getString("usrCd") );
				record.put("rpstYn", jObj.getString("rpstYn"));
				record.put("prssAccCd", jObj.getString("prssAccCd"));
				record.put("srcViewYn", jObj.getString("srcViewYn"));
				record.put("useYn", jObj.getString("useYn"));
				infSetDao.mergeInfoSetUsr(record);
			}
		}
	}
	
	/**
	 * 문서 목록 리스트 조회(팝업)
	 */
	@Override
	public List<Record> selectDocListPop(Params params) {
		return infSetDao.selectDocListPop(params);
	}
	
	/**
	 * 공공데이터 목록 리스트 조회(팝업)
	 */
	@Override
	public List<Record> selectOpenListPop(Params params) {
		return infSetDao.selectOpenListPop(params);
	}

	/**
	 * 통계 목록 리스트 조회(팝업)
	 */
	@Override
	public List<Record> selectStatListPop(Params params) {
		return infSetDao.selectStatListPop(params);
	}

	/**
	 * 정보셋 관리 관련 문서데이터 CUD
	 */
	@Override
	public Result saveInfSetRel(Params params) {
		try {
			Record record = null;
			String objIdKey = params.getString("objIdKey");
			String infsTagKey = params.getString("infsTagKey");
			String infsId = params.getString("infsId");
			String regId = params.getString("regId");
			String updId = params.getString("updId");
			
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for ( int i=0; i < jsonArray.length(); i++ ) {
				JSONObject jObj = (JSONObject) jsonArray.get(i);
				String status = jObj.getString("status");
				record = new Record();
				record.put("infsId", infsId);
				record.put("infsTag",  infsTagKey);					// 정보셋 구분
				record.put("objId",  jObj.getString(objIdKey));		// 객체ID
				
				// 삭제로 넘어온 행
				if ( StringUtils.equals(status, ModelAttribute.ACTION_DEL) ) {
					infSetDao.deleteInfoSetRel(record);
				}
				else if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) || StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
					record.put("regId", regId);
					record.put("updId", updId);
					record.put("vOrder", jObj.getInt("vOrder"));
					record.put("useYn",  jObj.getString("useYn"));
					infSetDao.mergeInfoSetRel(record);
				}
			}
			
			// 정보셋 관리 관련 데이터 저장시 마스터 테이블에 문서, 공공, 통계 갯수 수정
			infSetDao.updateInfoSetMstRelCnt(params);
			
		} catch(DataAccessException e){
			EgovWebUtil.exTransactionLogging(e);
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000006"));
	}

	/**
	 * 정보셋 관리 관련 문서데이터 조회
	 */
	@Override
	public List<Record> selectInfoSetRelDoc(Params params) {
		return infSetDao.selectInfoSetRelDoc(params);
	}

	/**
	 * 정보셋 관리 관련 공공데이터 조회
	 */
	@Override
	public List<Record> selectInfoSetRelOpen(Params params) {
		return infSetDao.selectInfoSetRelOpen(params);
	}

	/**
	 * 정보셋 관리 관련 통계데이터 조회
	 */
	@Override
	public List<Record> selectInfoSetRelStat(Params params) {
		return infSetDao.selectInfoSetRelStat(params);
	}

	/**
	 * 정보셋 관리 공개/공개취소 처리
	 */
	@Override
	public Result updateInfSetOpenState(Params params) {
		try {
			String openState = StringUtils.equals(params.getString("openState"), "Y") ? "공개" : "공개취소";
			infSetDao.updateInfSetOpenState(params);
			
			return success("정상적으로 " + openState + "처리 되었습니다.");
		} catch(DataAccessException dae){
			EgovWebUtil.exTransactionLogging(dae);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}

	/**
	 * 정보셋 관리 설명 조회
	 */
	@Override
	public List<Record> selectInfSetExp(Params params) {
		return infSetDao.selectInfSetExp(params);
	}

	/**
	 * 정보셋 관리 설명 데이터 등록/수정
	 */
	@Override
	public Result saveInfSetExp(Params params) {
		
		try {
			
			XssSaxFilter filter = XssSaxFilter.getInstance("lucy-xss-sax.xml", true);
			String infsDtlCont = params.getString("infsDtlCont");
			String filteredInfsDtlCont = filter.doFilter(infsDtlCont);
			params.put("infsDtlCont", filteredInfsDtlCont);
			
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				infSetDao.insertInfSetExp(params);
			}
			else if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				infSetDao.updateInfSetExp(params);
			}
			
			return success(getMessage("admin.message.000007"));
			
		} catch(DataAccessException dae){
			EgovWebUtil.exTransactionLogging(dae);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}

	/**
	 * 정보셋 관리 설명 데이터 삭제
	 */
	@Override
	public Result deleteInfSetExp(Params params) {
		try {
			infSetDao.deleteInfSetExp(params);
			
			return success(getMessage("admin.message.000005"));
		} catch(DataAccessException dae){
			EgovWebUtil.exTransactionLogging(dae);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}

	/**
	 * 정보셋 관리 설명 시트 순서 저장
	 */
	@Override
	public Result saveInfSetExpOrder(Params params) {
		String updId = params.getString("updId");
		Params[] data = params.getJsonArray(Params.SHEET_DATA);
		
		for (int i = 0; i < data.length; i++) {
        	data[i].put("updId", updId);
        	infSetDao.saveInfSetExpOrder(data[i]);
        }
		
		return success(getMessage("저장이 완료되었습니다."));
	}
	
}
