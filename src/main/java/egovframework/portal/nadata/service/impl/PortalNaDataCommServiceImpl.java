package egovframework.portal.nadata.service.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;
import egovframework.portal.nadata.service.PortalNaDataCommService;

/**
 * 보고서&발간물 화면 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Service(value="portalNaDataCommService")
public class PortalNaDataCommServiceImpl extends BaseService implements PortalNaDataCommService {

	@Resource(name="portalNaDataCommDao")
	private PortalNaDataCommDao portalNaDataCommDao;
	
    /**
     * 분류 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectDataCommItm(Params params) {
        return portalNaDataCommDao.selectDataCommItm(params);
    }
    
    /**
     * 기관 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectDataCommOrg(Params params) {
        return portalNaDataCommDao.selectDataCommOrg(params);
    }
    
    /**
     * 발간주기 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectDataCommCycle(Params params) {
        return portalNaDataCommDao.selectDataCommCycle(params);
    }    
    
    /**
     * 국회사무처 보고서&발간물 내용을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchNaDataComm(Params params) {
        // 게시판 내용을 검색한다.
        return portalNaDataCommDao.searchNaDataComm(params, params.getPage(), params.getRows());
    }
    
	/**
	 * 국회사무처 보고서&발간물 썸네일 불러오기
	 */
	@Override
	public Record selectNaDataCommThumbnail(Params params) {
		Record thumbnail = new Record();
		
		thumbnail.put(ImageView.FILE_PATH, getFilePath(params));
		thumbnail.put(ImageView.FILE_NAME, params.getString("tmnlImgFile"));
        
        return thumbnail;
	} 
	
	/**
	 * 국회사무처 보고서&발간물 이미지 파일 정보 가져오기
	 * @param file
	 * @return
	 */
	private String getFilePath(Params params) {
        StringBuffer buffer = new StringBuffer();
        if ( StringUtils.equals("L", params.getString("srvCd")) ) {
        	buffer.append(EgovProperties.getProperty("Globals.OpenlinkImg"));
        }
        else if ( StringUtils.equals("S", params.getString("srvCd")) ) {
        	buffer.append(EgovProperties.getProperty("Globals.OpensheetImg"));
        }
        else {
        	buffer.append(EgovProperties.getProperty("Globals.OpenfileImg"));
        }
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(params.getString("tmnlImgFile")));
        
        return buffer.toString();
    }
}
