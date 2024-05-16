package egovframework.portal.nadata.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;
import egovframework.common.util.UtilTree;
import egovframework.portal.nadata.service.PortalNaDataCatalogService;

/**
 * 국회사무처 정보서비스 카탈로그 화면 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Service(value="portalNaDataCatalogService")
public class PortalNaDataCatalogServiceImpl extends BaseService implements PortalNaDataCatalogService {

	@Resource(name="portalNaDataCatalogDao")
	private PortalNaDataCatalogDao portalNaDataCatalogDao;
	
	/**
	 * 정보카달로그 상위분류 리스트 조회
	 */
	@Override
	public List<Record> selectNaTopCateList(Params params){
		return portalNaDataCatalogDao.selectNaTopCateList(params);
	}
	
	/**
	 * 정보카달로그 썸네일 불러오기
	 */
	@Override
	public Record selectNaSetCateThumbnail(Params params) {
		Record file = new Record();
		if("cate".equals(params.getString("gb"))){
			file = (Record) portalNaDataCatalogDao.selectNaSetCateDtl(params);
		}else{
			file = (Record) portalNaDataCatalogDao.selectNaDataImgPath(params);
		}
		
        
		Record thumbnail = new Record();
        thumbnail.put(ImageView.FILE_PATH, getFilePath(file, params.getString("gb")));
        
        return thumbnail;
	}
	
	 /**
	 * 정보카탈로그분류 트리 목록을 조회한다.
	 */
	@Override
	public List<Map<String, Object>> selectNaDataCateTree(Params params) {
		List<Record> list = portalNaDataCatalogDao.selectNaDataCateTree(params);
		
		return UtilTree.convertorTreeData(list, "T", "infoId", "parInfoId", "infoNm", "gubunTag", "vOrder");
	}
	
	/**
	 * 정보카달로그 분류 파일 정보 가져오기
	 * @param file
	 * @return
	 */
	private String getFilePath(Record file, String gb) {
        StringBuffer buffer = new StringBuffer();
        if(gb.equals("cate")){
        	buffer.append(EgovProperties.getProperty("Globals.NaSetCateFilePath"));
        }else{
        	buffer.append(EgovProperties.getProperty("Globals.NaCmpsFilePath"));
        }
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        
        return buffer.toString();
    }
	
	/**
	 * 정보카탈로그 상세 조회
	 */
	@Override
	public Record selectInfoDtl(Params params) {
		
		// 정보카달로그 서비스 조회수 수정
    	portalNaDataCatalogDao.updateNaDataCatalogViewCnt(params);
    	
		return portalNaDataCatalogDao.selectInfoDtl(params); 
	}
	
	/**
	 * 정보카탈로그 디렉토리 목록 검색
	 */
	public Paging selectNaSetDirPaging(Params params) {
		return portalNaDataCatalogDao.searchNaSetDirPaging(params, params.getPage(), params.getRows());
	}

	/**
	 * 정보카탈로그와 연결된 카테고르의 최상위 ID 조회
	 */
	@Override
	public String selectNaSetTopCateId(String infoId) {
		return portalNaDataCatalogDao.selectNaSetTopCateId(infoId);
	}

	/**
	 * 정보카탈로그 트리 목록을 조회한다.
	 */
	@Override
	public List<Record> selectNaDataCatalogExcel(Params params) {
		return portalNaDataCatalogDao.selectNaDataCateTree(params);
	}
	
	/**
	 * 정보카탈로그 목록 검색(페이징)
	 */
	public Paging selectNaSetListPaging(Params params) {
		return portalNaDataCatalogDao.selectNaSetListPaging(params, params.getPage(), params.getRows());
	}

	/**
	 * 정보카탈로그 목록(전체)
	 */
	@Override
	public List<Record> selectNaDataCatalogListExcel(Params params) {
		return portalNaDataCatalogDao.selectNaSetList(params);
	}
	
}
