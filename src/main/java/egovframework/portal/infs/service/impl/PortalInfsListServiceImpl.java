package egovframework.portal.infs.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.infs.service.PortalInfsListService;
import egovframework.portal.infs.web.PortalInfsListDownload;

/**
 * 사전정보공개 목록을 관리하는 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/12
 */
@Service(value="portalInfsListService")
public class PortalInfsListServiceImpl extends BaseService implements PortalInfsListService {

	@Resource(name="portalInfsListDao")
	protected PortalInfsListDao portalInfsListDao;

	/**
	 * 정보공개 목록 조회(페이징)
	 */
	@Override
	public Paging selectInfsListPaging(Params params) {
		
		setFormSearchParam(params);	// 검색폼 파라미터 데이터 처리

		return portalInfsListDao.selectInfsListPaging(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 검색폼 파라미터 데이터 처리(IBATIS에서 조회 되도록) 
	 */
	private void setFormSearchParam(Params params) {
		
		String[] schHdnCateId = params.getStringArray("schHdnCateId");
		ArrayList<String> schArrCateId = new ArrayList<String>(Arrays.asList(schHdnCateId));
		params.set("schArrCateId", schArrCateId);
		
		String[] schHdnTag = params.getStringArray("schHdnTag");
		ArrayList<String> schArrTag = new ArrayList<String>(Arrays.asList(schHdnTag));
		params.set("schArrTag", schArrTag);
		
		String[] schHdnSrvCd = params.getStringArray("schHdnSrvCd");
		params.set("schJoinSrvCd", StringUtils.join(schHdnSrvCd, "|"));
	}

	/**
	 * 기관을 조회한다.(최상위조직)
	 */
	@Override
	public List<Record> selectCommOrgTop(Params params) {
		return portalInfsListDao.selectCommOrgTop(params);
	}
	
	/**
	 * 특정 NAME으로 전달되는 조회 파라미터를 유지한다.
	 */
	public void keepSearchParam(Params params, Model model) {
		Record record = new Record();
		Record hdnRecord = new Record();
		
		Set<Object> keySet = params.keySet();
		Iterator<Object> iter = keySet.iterator();
		while ( iter.hasNext() ) {
			String key = (String) iter.next();
			
			if ( key.startsWith("sch") || StringUtils.equals("page", key) || StringUtils.equals("rows", key) ) {
				if ( params.get(key) instanceof String ) {
					if ( StringUtils.isNotEmpty(params.getString(key)) ) {
						if ( key.startsWith("schHdn") ) {
							hdnRecord.put(key, params.getString(key));
						}
						else {
							record.put(key, params.getString(key));
						}
					}
				}
				else if ( params.get(key) instanceof String[] ) {
					if ( !CollectionUtils.sizeIsEmpty(params.getStringArray(key)) ) {
						if ( key.startsWith("schHdn") ) {
							hdnRecord.put(key, new ArrayList<String>(Arrays.asList(params.getStringArray(key))));
						}
						else {
							record.put(key, new ArrayList<String>(Arrays.asList(params.getStringArray(key))));
						}
					}
				}	
				else if ( params.get(key) instanceof Integer ) {
					if ( key.startsWith("schHdn") ) {
						hdnRecord.put(key, params.getInt(key));
					}
					else {
						record.put(key, params.getInt(key));
					}
				}
			}
		
		}
		model.addAttribute("schParams", record);
		model.addAttribute("schHdnParams", hdnRecord);
	}
	
	/**
	 * 정보셋 ID에 속한 정보서비스 목록을 조회한다.
	 */
	@Override
	public List<Record> selectInfsInfoRelList(Params params) {
		params.set("infaIds", new ArrayList<String>(Arrays.asList(params.getStringArray("paramInfaIds"))));
		
		return portalInfsListDao.selectInfsInfoRelList(params);
	}

	/**
	 * 정보공개 일괄 다운로드를 수행한다.
	 */
	@Override
	public void download(HttpServletRequest request, HttpServletResponse response, Params params) {
		// 체크된 정보셋 ID
		List<String> chkInfaList = new ArrayList<String>(Arrays.asList(params.getStringArray("schChkInfaId")));
		params.put("infaIds", chkInfaList);
		
		// 선택된 정보서비스 목록을 조회한다.
		List<Record> dsList = portalInfsListDao.selectInfsInfoList(params);
		PortalInfsListDownload.download(response, request, params, dsList);
		
	}
}
