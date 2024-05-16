package egovframework.ggportal.user.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.ggportal.bbs.service.impl.PortalBbsAdminDao;
import egovframework.ggportal.bbs.service.impl.PortalBbsFileDao;
import egovframework.ggportal.bbs.service.impl.PortalBbsFileServiceImpl;
import egovframework.ggportal.bbs.service.impl.PortalBbsLinkDao;
import egovframework.ggportal.bbs.service.impl.PortalBbsListDao;
import egovframework.ggportal.expose.service.impl.PortalExposeInfoDao;
import egovframework.ggportal.user.service.PortalMyPageService;

@Service("ggportalMyPageService")
public class PortalMyPageServiceImpl extends PortalBbsFileServiceImpl implements PortalMyPageService {

    /**
     * 게시판 설정을 관리하는 DAO
     */
    @Resource(name="ggportalBbsAdminDao")
    private PortalBbsAdminDao portalBbsAdminDao;
    
    /**
     * 게시판 내용을 관리하는 DAO
     */
    @Resource(name="ggportalBbsListDao")
    private PortalBbsListDao portalBbsListDao;
    
    /**
     * 게시판 첨부파일을 관리하는 DAO
     */
    @Resource(name="ggportalBbsFileDao")
    private PortalBbsFileDao portalBbsFileDao;
    
    /**
     * 게시판 링크를 관리하는 DAO
     */
    @Resource(name="ggportalBbsLinkDao")
    private PortalBbsLinkDao portalBbsLinkDao;
    
    /**
     * MyPage DAO
     */
    @Resource(name="ggportalMyPageDao")
    private PortalMyPageDao portalMyPageDao;
    
    /**
     * 정보공개 청구 관리하는 DAO
     */
    @Resource(name="portalExposeInfoDao")
    private PortalExposeInfoDao portalExposeInfoDao;
    
	@Override
	public Result insertUtilGalleryCUD(Params params) {
        // 개인정보 수집 및 이용 동의여부를 확인한다.
        checkAgreeYn(params, "portal.error.000044");
        
        // 보안코드를 확인한다.
        checkSecuCd(params, "portal.error.000045");
        
        // 게시판 설정을 확인한다.
        Record config = checkBbsAdmin(params, "portal.error.000014");
        
        // 게시판 답글 여부를 확인한다.
        checkAnsYn(params, config, "portal.error.000038");
        
        // 게시판 답글 태그를 확인한다.
        checkAnsTag(params, config, "portal.error.000038");
        
        // 게시판 첨부파일을 확인한다.
        checkBbsFile(params, config, new String[] {
            "portal.error.000046",
            "portal.error.000047",
            "portal.error.000048",
            "portal.error.000049"
        });
        
        // 게시판 내용을 등록한다.
        portalBbsListDao.insertBbsList(params);

        // 공공데이터게시판에 등록
        String[] infIdArr = null;
        if(params.get("infId") instanceof String) {
        	infIdArr = new String[]{(String)params.get("infId")};
        } else if(params.get("infId") instanceof String[]) {
        	infIdArr  = (String[])params.get("infId");
        }
        if(infIdArr != null) {
        	Params temp = null;
	        for(int i = 0 ; i < infIdArr.length ; i ++) {
	        	temp = new Params();
	        	temp.put("bbsCd", params.get("bbsCd"));
	        	temp.put("seq", params.get("seq"));
	        	temp.put("regId", params.get("regId"));
	        	temp.put("infId", infIdArr[i]);
	        	portalBbsListDao.insertBbsInf(temp);
	        }
        }
        // 게시판 내용 공공데이터수를 수정한다.
        portalBbsListDao.updateBbsListInfCnt(params);
        
        
        if ( StringUtils.isNotBlank(params.getString("dvpHpYn")) || StringUtils.isNotBlank(params.getString("dvpKakaoYn")) ) {
        	if ( StringUtils.equals(params.getString("dvpHpYn"), params.getString("dvpKakaoYn")) ) {
        		throw new ServiceException("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
        	}
        }
        // 안내수신 정보를 수정한다.
        portalMyPageDao.updateDvp(params);
        
        params.put("topYn", "Y");
        insertBbsFile(params, "mainImg");
        params.remove("topYn");
        insertBbsFile(params, "examImg");

        // 게시판 내용 첨부파일수를 수정한다
        portalBbsListDao.updateBbsListFileCnt(params);
        
        // 게시판 링크를 저장
        String[] linkNmArr = null;
        String[] linkUrlArr = null;
        if(params.get("linkNm") instanceof String) {
        	linkNmArr = new String[]{(String)params.get("linkNm")};
        	linkUrlArr = new String[]{(String)params.get("url")};
        } else if(params.get("linkNm") instanceof String[]) {
        	linkNmArr = (String[])params.get("linkNm");
        	linkUrlArr = (String[])params.get("url");
        }
        if(linkNmArr != null) {
        	Params temp = null;
	        for(int i = 0 ; i < linkNmArr.length ; i ++) {
	        	temp = new Params();
	        	temp.put("bbsCd", params.get("bbsCd"));
	        	temp.put("seq", params.get("seq"));
	        	temp.put("linkNm", linkNmArr[i]);
	        	temp.put("url", linkUrlArr[i]);
	        	portalBbsLinkDao.insertBbsLink(temp);
	        }
	        // 게시판 내용 링크수를 수정한다.
	        portalBbsListDao.updateBbsListLinkCnt(params);
        }
		return success(getMessage("portal.message.000003"));
	}
	
	@Override
	public Result updateUtilGalleryCUD(Params params) {
		
        // 개인정보 수집 및 이용 동의여부를 확인한다.
        checkAgreeYn(params, "portal.error.000044");
        
        // 보안코드를 확인한다.
        checkSecuCd(params, "portal.error.000045");
        
        // 게시판 설정을 확인한다.
        Record config = checkBbsAdmin(params, "portal.error.000014");
        
        // 게시판 내용을 확인한다.
        Record data = checkBbsList(params, "portal.error.000034");
        
        // 사용자 코드를 확인한다.
        checkUserCd(params, data, "portal.error.000036");
        
        // 사용자 비밀번호를 확인한다.
        checkUserPw(params, data, "portal.error.000043");
        
        // 게시판 첨부파일을 확인한다.
        checkBbsFile(params, config, new String[] {
            "portal.error.000046",
            "portal.error.000047",
            "portal.error.000048",
            "portal.error.000049"
        });
        
        // 안내수신 정부를 수정한다.
        portalMyPageDao.updateDvp(params);
        // 게시판 내용을 수정한다.
        portalBbsListDao.updateBbsList(params);
        
        // 게시판 이미지첨부파일을 삭제한다.
        deleteBbsFile(params, "dtchMainFile");
        deleteBbsFile(params, "dtchFile");
        
        params.put("topYn", "Y");
        insertBbsFile(params, "mainImg");
        params.remove("topYn");
        insertBbsFile(params, "examImg");

        // 게시판 내용 첨부파일수를 수정한다
        portalBbsListDao.updateBbsListFileCnt(params);
        
        
        
       // 기존의 공공게시판 데이터를 삭제 후 새로 저장
        String[] infIdArr = null;
        if(params.get("infId") instanceof String) {
        	infIdArr = new String[]{(String)params.get("infId")};
        } else if(params.get("infId") instanceof String[]) {
        	infIdArr  = (String[])params.get("infId");
        }
        if(infIdArr != null) {
        	Params temp = null;
        	// 기존 데이터 삭제
        	portalBbsListDao.deleteBbsInf(params);
	        for(int i = 0 ; i < infIdArr.length ; i ++) {
	        	temp = new Params();
	        	temp.put("bbsCd", params.get("bbsCd"));
	        	temp.put("seq", params.get("seq"));
	        	temp.put("regId", params.get("regId"));
	        	temp.put("infId", infIdArr[i]);
	        	portalBbsListDao.insertBbsInf(temp);
	        }
        }
        // 게시판 내용 공공데이터수를 수정한다.
        portalBbsListDao.updateBbsListInfCnt(params);
        
        
        // 기존의 게시판 링크를 삭제 후 새로 저장
        String[] linkNmArr = params.getStringArray("linkNm");
        String[] linkUrlArr = params.getStringArray("url");
        if(linkNmArr != null) {
        	// 기존 링크 삭제
        	portalBbsLinkDao.deleteBbsLink(params);
        	Params temp = null;
	        for(int i = 0 ; i < linkNmArr.length ; i ++) {
	        	temp = new Params();
	        	temp.put("bbsCd", params.get("bbsCd"));
	        	temp.put("seq", params.get("seq"));
	        	temp.put("linkNm", linkNmArr[i]);
	        	temp.put("url", linkUrlArr[i]);
	        	portalBbsLinkDao.insertBbsLink(temp);
	        }
	        // 게시판 내용 링크수를 수정한다.
	        portalBbsListDao.updateBbsListLinkCnt(params);
        }
        return success(getMessage("portal.message.000004"));
	}
	
	@Override
	public List<?> searchOpenApi(Params params) {
		return portalMyPageDao.searchOpenAPI(params);
	}
    
	//OpenAPI 인증키 폐기
	@Override
	public Result updateDiscardActKey(Params params) {
		portalMyPageDao.updateDiscardActKey(params); 
		return success(getMessage("portal.message.000004"));
	}
	
	@Override
	public Object selectUserInfo(Params params) {
		return portalMyPageDao.selectUserInfo(params);
	}
	
	@Override
	public Result updateUserInfoCUD(Params params) {
		
		portalMyPageDao.updateUserInfo(params);
		
		return success(getMessage("portal.message.000004"));
	}
    
	@Override
	public Result deleteUserInfoCUD(Params params) {
		portalMyPageDao.deleteUserKey(params);
		portalMyPageDao.deleteUserInfo(params);
		
		return success(getMessage("portal.message.000007"));
	}
	
	@Override
	public List<?> selectListUseActKey(Params params) {
		return portalMyPageDao.selectListUseActKey(params);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////// private method /////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////
    /**
     * 개인정보 수집 및 이용 동의여부를 확인한다.
     * 
     * @param params 파라메터
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkAgreeYn(Params params, String error) {
        // // 부모 게시판 내용 일련번호가 없는 경우
        // if ("".equals(params.getString("pSeq"))) {
        //     // 개인정보 수집 및 이용에 동의하지 않은 경우
        //     if (!"Y".equals(params.getString("agreeYn"))) {
        //         throw new ServiceException(error, getMessage(error));
        //     }
        // }
        
        return true;
    }
    
    /**
     * 보안코드를 확인한다.
     * 
     * @param params 파라메터
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkSecuCd(Params params, String error) {
        // // 부모 게시판 내용 일련번호가 없는 경우
        // if ("".equals(params.getString("pSeq"))) {
        //     // 보안코드가 일치하지 않는 경우
        //     if (!params.getCaptcha(Params.CAPTCHA).isCorrect(params.getString("secuCd"))) {
        //         throw new ServiceException(error, getMessage(error));
        //     }
        // }
        
        return true;
    }
    
    /**
     * 게시판 답글 여부를 확인한다.
     * 
     * @param params 파라메터
     * @param config 설정
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkAnsYn(Params params, Record config, String error) {
    	try{
    		// 부모 게시판 내용 일련번호가 있는 경우
	        if (!"".equals(params.getString("pSeq"))) {
	            // 게시판 답글을 등록할 수 없는 경우
	            if (!"Y".equals(config.getString("ansYn"))) {
	                throw new ServiceException(error, getMessage(error));
	            }
	        }
	        
    	 } catch (ServiceException sve) {
         	EgovWebUtil.exLogging(sve);
         } catch (Exception e) {
         	EgovWebUtil.exLogging(e);
 		}
        return true;
    }
    
    /**
     * 게시판 답글 태그를 확인한다.
     * 
     * @param params 파라메터
     * @param config 설정
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkAnsTag(Params params, Record config, String error) {
        try{
	    	// 부모 게시판 내용 일련번호가 있는 경우
	        if (!"".equals(params.getString("pSeq"))) {
	            // 게시판 댓글을 등록할 수 없는 경우
	            if (!"N".equals(config.getString("ansTag"))) {
	                throw new ServiceException(error, getMessage(error));
	            }
	        }
	        
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        
        return true;
    }
    
    /**
     * 게시판 설정을 확인한다.
     * 
     * @param params 파라메터
     * @param error 오류코드
     * @return 확인결과
     */
    private Record checkBbsAdmin(Params params, String error) {
        // 게시판 설정을 조회한다.
        Record config = portalBbsAdminDao.selectBbsAdmin(params);
        
        try{
	        // 게시판 분류가 없는 경우
	        if (config == null) {
	            throw new ServiceException(error, getMessage(error, new String[] {
	                params.getString("bbsCd").toUpperCase()
	            }));
	        }
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        
        return config;
    }
    
    /**
     * 게시판 내용을 확인한다.
     * 
     * @param params 파라메터
     * @param error 오류코드
     * @return 확인결과
     */
    private Record checkBbsList(Params params, String error) {
        
    	// 게시판 내용을 조회한다.
        Record data = portalBbsListDao.selectBbsList(params);
        try{
	        // 게시판 내용이 없는 경우
	        if (data == null) {
	            throw new ServiceException(error, getMessage(error));
	        }
	        
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        
        return data;
    }
    
    /**
     * 첨부된 이미지 파일을 확인한다.
     * 
     * @param params 파라메터
     * @param config 설정
     * @param errors 오류코드
     * @return 확인결과
     */
    private boolean checkBbsFile(Params params, Record config, String[] errors) {
        long size = config.getLong("sizeLimit") * 1024 * 1024;
        
        try{ 
	       
        	MultipartFile[] files = params.getFileArray("atchFile");
	        
	        Pattern pattern = Pattern.compile("(.)+\\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$");
	        
	        for (int i = 0; i < files.length; i++) {
	            MultipartFile file =  files[i];
	            
	            if (file.isEmpty()) {
	                continue;
	            }
	            
	            // 첨부파일 확장자가 제한된 확장자가 아닌 경우
	            if (!pattern.matcher(file.getOriginalFilename().toLowerCase()).matches()) {
	            	throw new ServiceException(errors[0], getMessage(errors[0]));
	            }
	            
	            // 첨부파일 크기 제한이 있는 경우
	            if (size > 0) {
	                // 첨부파일 크기가 제한된 크기를 초과한 경우
	                if (file.getSize() > size) {
	                    throw new ServiceException(errors[3], getMessage(errors[3], new String[] { config.getString("sizeLimit") }));
	                }
	            }
	        }
	        
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}  
        
        return true;
    }

    /**
     * 사용자 코드를 확인한다.
     * 
     * @param params 파라메터
     * @param data 데이터
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkUserCd(Params params, Record data, String error) {
    	try{
	        // 사용자 코드가 다른 경우
	        if (!data.getString("userCd").equals(params.getString(Params.USER_CD))) {
	            throw new ServiceException(error, getMessage(error));
	        }
	        
    	} catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
    	
        return true;
    }
    
    /**
     * 사용자 비밀번호를 확인한다.
     * 
     * @param params 파라메터
     * @param data 데이터
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkUserPw(Params params, Record data, String error) {
        // // 부모 게시판 내용 일련번호가 없는 경우
        // if ("".equals(params.getString("pSeq"))) {
        //     // 사용자 비밀번호가 다른 경우
        //     if (!data.getString("userPw").equals(params.getString("userPw"))) {
        //         throw new ServiceException(error, getMessage(error));
        //     }
        // }
        
        return true;
    }

    /**
     * 통계스크랩 목록을 조회한다.
     */
	@Override
	public Paging statUserScrapList(Params params) {
		return portalMyPageDao.selectStatUserScrapList(params, params.getPage(), params.getRows());
	}

	/**
	 * 통계스크랩 삭제
	 */
	@Override
	public Result delStatUserScrap(Params params) {
		portalMyPageDao.delStatUserItmScrap(params);
		portalMyPageDao.delStatUserItmMScrap(params);
		portalMyPageDao.delStatUserScrap(params);
		return success(getMessage("portal.message.000005"));
	}

	/**
	 * 뉴스레터 수신정보 조회
	 */
	@Override
	public Record selectNewsletter(Params params) {
		return portalMyPageDao.selectNewsletter(params);
	}
	
	/**
	 * 뉴스레터 수신정보 등록/삭제
	 */
	@Override
	public Result saveNewsletterAgree(Params params) {
		portalMyPageDao.saveNewsletterAgree(params);
		return success(getMessage("portal.message.000006"));
	}

	/**
	 * 유저 검색로그 조회
	 */
	@Override
	public Paging searchSearchHisData(Params params) {
		return portalMyPageDao.searchSearchHisData(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 청구 기본정보 조회
	 */
	@Override
	public Object selectExposeDefaultUpdInfo(Params params) {
		return portalMyPageDao.selectExposeDefaultUpdInfo(params);
	}
	
	/**
	 * 청구 기본정보 수정
	 */
	@Override
	public Result updateExposeDefaultUpdCUD(Params params) {
		try {
   			
   			// 본인인증 확인
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	        HttpSession session = req.getSession();
	        if ( StringUtils.isEmpty((String)session.getAttribute("loginName")) ) {
	        	throw new ServiceException("본인인증이 되지 않았습니다.");
			}
	        else {
	        	params.set("user2Ssn", (String) session.getAttribute("loginRno2"));
	        }
   			
	        if ( StringUtils.isNotBlank(params.getString("hpYn")) || StringUtils.isNotBlank(params.getString("kakaoYn")) ) {
	        	if ( StringUtils.equals(params.getString("hpYn"), params.getString("kakaoYn")) ) {
	        		throw new ServiceException("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
	        	}
	        }
   	        
   			portalMyPageDao.updateExposeDefaultUpd(params);
		}catch (DataAccessException dae) { 
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) { 
			EgovWebUtil.exLogging(e);
		}
		
		return success(getMessage("portal.message.000004"));
		
	}
	
	@Override
	public List<Record> selectOpenInfSearchPop(Params params) {
		return portalMyPageDao.selectOpenInfSearchPop(params);
	}
	
	@Override
	public Result updateDvp(Params params) {
		portalMyPageDao.updateDvp(params); 
		return success(getMessage("portal.message.000004"));
	}
	
	 /**
     * 정보공개 나의 청구서 목록을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchMyOpnzAplList(Params params) {
    	    	
        return portalMyPageDao.searchMyOpnzAplList(params, params.getPage(), params.getRows());
    }
    
    /**
	 * 기존 청구서 저장
	 */
	@Override
	public Result updateMyOpnzApl(Params params) {
		try {
   			
   			// 실명인증 확인
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	        HttpSession session = req.getSession();
	        
	        List<Record> dataList = (List<Record>) portalMyPageDao.getOpnAplNoList(params);
	        
	        if ( StringUtils.isEmpty((String)session.getAttribute("dupInfo")) ) {
	        	throw new ServiceException("실명인증이 되지 않았습니다.");
			}
	        else {
				
				if(dataList.size() > 0) {
					for ( Record data : dataList ) {
						
						String aplNo = data.getString("aplNo");
						data.put("aplNo", aplNo);
						data.put("aplDi", (String) session.getAttribute("dupInfo"));
						data.put("userId", (String) session.getAttribute("userId"));
						data.put("aplRno1", (String) session.getAttribute("loginRno1"));
						data.put("aplPn", (String) session.getAttribute("loginName"));
						
						portalMyPageDao.updateMyOpnzApl(data);
					}
				} else {
					throw new ServiceException("저장할 내역이 없습니다.");
				}
	        }
   			
		}catch (DataAccessException dae) { 
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) { 
			EgovWebUtil.exLogging(e);
		}
		return success(getMessage("청구서가 저장 되었습니다."));
		
	}
}
