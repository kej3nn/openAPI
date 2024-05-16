package egovframework.portal.nadata.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;
import egovframework.portal.nadata.service.PortalNaDataSitemapService;

/**
 * 국회사무처 정보서비스 사이트맵 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Service(value="portalNaDataSitemapService")
public class PortalNaDataSitemapServiceImpl extends BaseService implements PortalNaDataSitemapService {

	@Resource(name="portalNaDataSitemapDao")
	private PortalNaDataSitemapDao portalNaDataSitemapDao;
	
	/**
	 * 기관을 조회한다.
	 */
	@Override
	public List<Record> selectCommOrgList(Params params) {
		return portalNaDataSitemapDao.selectCommOrgList(params);
	}
	
	/**
	 * 정보서비스 사이트맵 리스트 조회
	 */
	@Override
	public List<Record> selectSiteMapList(Params params) {
		
		String[] schHdnOrgCd = params.getStringArray("schHdnOrgCd");
		ArrayList<String> schArrOrgCd = new ArrayList<String>(Arrays.asList(schHdnOrgCd));
		params.set("schArrOrgCd", schArrOrgCd);
		
		return (List<Record>) portalNaDataSitemapDao.selectSiteMapList(params);
	}
	
	/**
	 * 사이트맵 이미지 썸네일 조회
	 */
	@Override
	public Record selectDataSiteMapThumbnail(Params params) {
		Record file = (Record) portalNaDataSitemapDao.selectNaDataSiteMapDtl(params);
		
		Record thumbnail = new Record();  
        thumbnail.put("srvmId",     params.getString("srvmId"));
        thumbnail.put("tmnlImgFile", file.getString("tmnlImgFile"));
        thumbnail.put("tmnl2ImgFile", file.getString("tmnl2ImgFile"));
        
        thumbnail.put(ImageView.FILE_PATH, getFilePath(file,params.getString("gb")));
        if(params.getString("gb").equals("preView")) {
        	thumbnail.put(ImageView.FILE_NAME, file.getString("tmnlImgFile"));
        } 
        else if(params.getString("gb").equals("siteMap")) {
        	thumbnail.put(ImageView.FILE_NAME, file.getString("tmnl2ImgFile"));
        } else {
        	thumbnail.put(ImageView.FILE_NAME, "");
        }
        
        return thumbnail;
	}
	
	/**
	 * 사이트맵 파일 정보 가져오기
	 * @param file
	 * @return
	 */
	private String getFilePath(Record file, String gb) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.NaDataSiteMapFilePath"));
        if(gb.equals("preView")) {
        	buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("tmnlImgFile")));
        } else if(gb.equals("siteMap")) {
        	buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("tmnl2ImgFile")));
        }
        
        return buffer.toString();
    }
	
	/**
	 * 사이트맵 메뉴목록 불러오기
	 */
	@Override
	public List<Record> selectMenuList(Params params) {
		return (List<Record>) portalNaDataSitemapDao.selectMenuList(params);
	}

	/**
	 * 정보서비스 사이트맵 검색 조회
	 */
	@Override
	public List<Record> searchSiteMapList(Params params) {
		
		String[] schHdnOrgCd = params.getStringArray("schHdnOrgCd");
		ArrayList<String> schArrOrgCd = new ArrayList<String>(Arrays.asList(schHdnOrgCd));
		params.set("schArrOrgCd", schArrOrgCd);
		
		return (List<Record>) portalNaDataSitemapDao.searchSiteMapList(params);
	}

	/**
	 * 메뉴정보를 로그에 담는다.
	 * @param model
	 * @param params
	 */
	@Override
	public void insertLogMenu(Params params) {
		//메뉴정보를 로그에 담는다.
		portalNaDataSitemapDao.insertLogMenu(params);
	}	
	
}
