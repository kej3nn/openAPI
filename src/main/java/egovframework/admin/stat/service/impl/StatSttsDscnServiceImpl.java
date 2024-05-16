package egovframework.admin.stat.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatSttsDscnService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 관리자 연계정보설정 서비스 클래스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/09/07
 */

@Service(value="statSttsDscnService")
public class StatSttsDscnServiceImpl extends BaseService implements StatSttsDscnService {

	@Resource(name="statSttsDscnDao")
	protected StatSttsDscnDao statSttsDscnDao;

	@Override
	public List<Record> statSttsDscnList(Params params) {
		return (List<Record>) statSttsDscnDao.selectSttsDscnList(params);
	}

	/**
	 * 연계설정정보 데이터 저장(CUD)
	 */
	@Override
	public Result saveSttsDscn(Params params) {
		List<Record> mergeList = new ArrayList<Record>();
		List<Record> delList = new ArrayList<Record>();
		Record r = null;
		Params[] data = params.getJsonArray(Params.SHEET_DATA);
		
		try {
			
			if ( data.length > 0 ) {
				for (int i = 0; i < data.length; i++) {
					Params obj = data[i];
					r = new Record();
					String rowStatus = obj.getString(ModelAttribute.ACTION_STATUS);		//시트 상태
					r.put("regId", params.getString("regId"));
					r.put("updId", params.getString("updId"));
					if ( rowStatus.equals(ModelAttribute.ACTION_INS) 
							|| rowStatus.equals(ModelAttribute.ACTION_UPD) ) {	
						//등록 or 수정일경우 MERGE 처리
						for ( Object key : obj.keySet() ) {
							r.put(key, obj.get(String.valueOf(key)));
						}
						mergeList.add(r);
					} else if ( rowStatus.equals(ModelAttribute.ACTION_DEL) ) {
						//삭제 상태일 경우
						r.put("dscnId", obj.getInt("dscnId"));
						delList.add(r);
					}
				}
			}
			
			if ( delList.size() > 0 ) {
				//삭제 처리
				statSttsDscnDao.deleteSttsDscn(delList);
			}
			if ( mergeList.size() > 0 ) {
				//머지 처리
				statSttsDscnDao.saveSttsDscn(mergeList);
			}
			
		} catch(ServiceException sve) {
			error("Exception : " , sve);
			EgovWebUtil.exLogging(sve);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));	
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		
		return success(getMessage("admin.message.000006"));	//저장이 완료되었습니다.
	}
	
}
