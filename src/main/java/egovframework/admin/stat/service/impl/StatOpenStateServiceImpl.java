package egovframework.admin.stat.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.stat.service.StatOpenStateService;
import egovframework.admin.stat.service.StatSttsCateService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;

/**
 * 관리자 통계공개 현황 서비스 구현체
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2018/01/26
 */

@Service(value="statOpenStateService")
public class StatOpenStateServiceImpl extends BaseService implements StatOpenStateService {

	@Resource(name="statOpenStateDao")
	protected StatOpenStateDao statOpenStateDao;
	
	/**
	 * 통계표 현황
	 */
	@Override
	public List<Record> statTblStateList(Params params) {
		return (List<Record>) statOpenStateDao.selectStatTblState(params);
	}

	/**
	 * 통계표 누적 공계현황
	 */
	@Override
	public List<Record> statOpenStateList(Params params) {
		return (List<Record>) statOpenStateDao.selectStatOpenState(params);
	}

	
}
