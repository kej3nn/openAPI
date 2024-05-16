/*
 * @(#)PortalUserKeyServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service.impl;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.ggportal.user.service.PortalUserKeyService;

/**
 * 사용자 인증키를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalUserKeyService")
public class PortalUserKeyServiceImpl extends BaseService implements PortalUserKeyService {
    /**
     * 사용자 인증키를 관리하는 DAO
     */
    @Resource(name="ggportalUserKeyDao")
    private PortalUserKeyDao portalUserKeyDao;
    
    
	@Override
	public Result insertActKeyCUD(Params params) {
		boolean result = false;
        String msg = "";
		Record record = portalUserKeyDao.selectActKeyCnt(params);
		try{
			if(record.getInt("cnt") > 9) {
				msg = "더 이상 인증키를 발급받으실 수 없습니다.";
			} else {
				String actKey = UUID.randomUUID().toString().replaceAll("-", "");
				params.put("actKey", actKey);
				portalUserKeyDao.insertActKey(params);
			}
			result = true;	
		} catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        	throw new ServiceException(getMessage("portal.error.000003"));
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
        	throw new ServiceException(getMessage("portal.error.000003"));
		}
		if (result) {
        	if(msg.equals("")) return success(getMessage("portal.message.000003"));	
        	else return success(msg);
        } else {
            return failure(getMessage("portal.error.000003")); 
        }
	}
	
	@Override
	public Result deleteActKey(Params params) {
		portalUserKeyDao.deleteActKey(params);
		return success("정상적으로 인증키 폐기하였습니다.");	
	}
	
	@Override
	public List<?> searchActKey(Params params) {
		return portalUserKeyDao.searchActKey(params);
	}
	
	
}