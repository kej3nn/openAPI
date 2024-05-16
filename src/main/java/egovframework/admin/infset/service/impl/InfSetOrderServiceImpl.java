package egovframework.admin.infset.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.infset.service.InfSetOrderService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 정보셋 순서를 관리하는 서비스 구현 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/18
 */
@Service(value="infSetOrderService")
public class InfSetOrderServiceImpl extends BaseService implements InfSetOrderService {

	@Resource(name="infSetOrderDao")
	private InfSetOrderDao infSetOrderDao;
	
	/**
	 * 정보셋 순서 목록 조회
	 */
	public List<Record> selectInfSetOrderList(Params params) {
		return (List<Record>) infSetOrderDao.selectInfSetOrderList(params);
	}

	/**
	 * 정보셋 순서 저장
	 */
	@Override
	public Result saveInfSetOrder(Params params) {
		Record rec = null;
		try {
			Params[] data = params.getJsonArray(Params.SHEET_DATA);
			for (int i = 0; i < data.length; i++) {
				rec = new Record();
	        	rec.put("infsId", data[i].getString("infsId"));
	        	rec.put("cateId", data[i].getString("parInfsId"));
	        	rec.put("vOrder", data[i].getInt("vOrder"));
	        	infSetOrderDao.saveInfSetOrder(rec);
			}
		} catch(DataAccessException e){
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000004"));
	}
}
