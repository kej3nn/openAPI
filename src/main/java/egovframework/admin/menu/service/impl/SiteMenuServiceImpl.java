package egovframework.admin.menu.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.menu.service.SiteMenuService;
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
 * 관리자 메뉴 관리 클래스
 * 
 * @author 	손정식
 * @version	1.0
 * @since	2019/07/31
 */

@Service(value="siteMenuService")
public class SiteMenuServiceImpl extends BaseService implements SiteMenuService {

	public static final int BUFF_SIZE = 2048;
	
	@Resource(name="siteMenuDao")
	protected SiteMenuDao siteMenuDao;

	/**
	 * 메뉴 관리 메인 리스트 조회
	 */
	@Override
	public List<Record> siteMenuList(Params params) {
		return (List<Record>) siteMenuDao.selectSiteMenuList(params);
	}
	
	/**
	 * 메뉴 관리 팝업 리스트 조회
	 */
	@Override
	public List<Record> siteMenuPopList(Params params) {
		return (List<Record>) siteMenuDao.selectSiteMenuPopList(params);
	}

	/**
	 * 메뉴 관리 상세 조회
	 */
	@Override
	public Record siteMenuDtl(Params params) {
		return (Record) siteMenuDao.selectSiteMenuDtl(params);
	}

	/**
	 * 메뉴 관리 ID 중복체크
	 */
	@Override
	public Record siteMenuDupChk(Params params) {
		return (Record) siteMenuDao.selectSiteMenuDupChk(params);
	}

	/**
	 * 메뉴 관리 등록/수정
	 */
	@Override
	public Object saveSiteMenu(HttpServletRequest request, Params params) {
		/* 데이터 저장 */
		siteMenuDao.saveSiteMenu(params);
		return success(getMessage("admin.message.000006"));
		
			//관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
			//siteMenuDao.updateSiteMenuFullnm(params);
	}

	/**
	 * 정보 썸네일 불러오기
	 */
	@Override
	public Record selectSiteMenuThumbnail(Params params) {
		Record file = (Record) siteMenuDao.selectSiteMenuDtl(params);
        
		Record thumbnail = new Record();
        thumbnail.put("cateId",     params.getString("cateId"));
        thumbnail.put("saveFileNm", params.getString("saveFileNm"));
        
        thumbnail.put(ImageView.FILE_PATH, getFilePath(file));
        thumbnail.put(ImageView.FILE_NAME, params.getString("saveFileNm"));
        
        return thumbnail;
	}

	/**
	 * 메뉴 관리 삭제
	 */
	@Override
	public Object deleteSiteMenu(Params params) {
		siteMenuDao.deleteSiteMenu(params);

		return success(getMessage("admin.message.000005"));
	}

	/**
	 * 메뉴 관리 순서 저장
	 */
	@Override
	public Result saveSiteMenuOrder(Params params) {
		Record rec = null;
	
		try {
			/*
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for (int i = 0; i < jsonArray.length(); i++) {
	        	rec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	        	rec.put("cateId", jsonObj.getString("cateId"));
	        	rec.put("vOrder", jsonObj.getInt("vOrder"));
	        	statSttsCateDao.saveStatSttsCateOrder(rec);
			}
			*/
			Params[] data = params.getJsonArray(Params.SHEET_DATA);
			for (int i = 0; i < data.length; i++) {
				rec = new Record();
	        	rec.put("menuId", data[i].getString("menuId"));
	        	rec.put("vOrder", data[i].getInt("vOrder"));
	        	siteMenuDao.saveSiteMenuOrder(rec);
			}
		} catch(ServiceException sve) {
			EgovWebUtil.exTransactionLogging(sve);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000004"));
	}
	
	/**
	 * 메뉴 관리 파일 정보 가져오기
	 * @param file
	 * @return
	 */
	private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.SiteMenuFilePath"));
        buffer.append(file.getString("cateId"));
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        
        return buffer.toString();
    }
}
