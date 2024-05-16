/*
 * @(#)PortalBbsListServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.ggportal.bbs.service.PortalBbsAdminService;
import egovframework.ggportal.bbs.service.PortalBbsListService;

/**
 * 게시판 내용을 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalBbsListService")
public class PortalBbsListServiceImpl extends PortalBbsFileServiceImpl implements PortalBbsListService {
    /**
     * 그림 확장자 제한
     */
    private static final String EXTENSION_LIMIT_IMG = "IMG";
    
    /**
     * 문서 확장자 제한
     */
    private static final String EXTENSION_LIMIT_DOC = "DOC";
    
    /**
     * 그림 및 문서 확장자 제한
     */
    private static final String EXTENSION_LIMIT_BOTH = "BOTH";
    
    /**
     * 확장자 제한 패턴
     */
    private static final Map<String, Pattern> extensionLimitPattern = new HashMap<String, Pattern>();
    
    /**
     * 클래스 변수를 초기화한다.
     */
    static {
        // 확장자 제한 패턴
        extensionLimitPattern.put(EXTENSION_LIMIT_IMG,  Pattern.compile("(.)+\\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$"));
        extensionLimitPattern.put(EXTENSION_LIMIT_DOC,  Pattern.compile("(.)+\\.(doc|docx|hwp|pdf|ppt|pptx|txt|xls|xlsx)$"));
        extensionLimitPattern.put(EXTENSION_LIMIT_BOTH, Pattern.compile("(.)+\\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff|doc|docx|hwp|pdf|ppt|pptx|txt|xls|xlsx)$"));
    }
    
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
     * 게시판 링크를 관리하는 DAO
     */
    @Resource(name="ggportalBbsLinkDao")
    private PortalBbsLinkDao portalBbsLinkDao;
    
    /**
     * 게시판 공공데이터를 관리하는 DAO
     */
    @Resource(name="ggportalBbsInfDao")
    private PortalBbsInfDao portalBbsInfDao;
    
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
	        
        } catch (DataAccessException dae) {
        	EgovWebUtil.exLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        return data;
    }
    
    /**
     * 비밀글 여부를 확인한다.
     * 
     * @param params 파라메터
     * @param data 데이터
     * @param errors 오류코드
     * @return 확인결과
     */
    private boolean checkSecretYn(Params params, Record data, String[] errors) {
        try{
	    	// 비밀글인 경우
	        if ("Y".equals(data.getString("secretYn"))) {
	            // 로그인후 글을 작성한 경우
	            if (!"".equals(data.getString("userCd"))) {
	                // 사용자 코드가 다른 경우
	                if (!data.getString("userCd").equals(params.getString(Params.USER_CD))) {
	                    throw new ServiceException(errors[0], getMessage(errors[0]));
	                }
	            }
	            // 로그인전 글을 작성한 경우
	            else {
	            	/* password.jsp에서 로그인전 비밀번호를 확인하기 때문에 주석처리
	                // 사용자 비밀번호가 다른 경우
	                if (!data.getString("userPw").equals(params.getString("userPw"))) {
	                    throw new ServiceException(errors[1], getMessage(errors[1]));
	                }
	                */
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
     * 사용자 비밀번호를 확인한다.
     * 
     * @param params 파라메터
     * @param config 설정
     * @param error 오류코드
     * @return 확인결과
     */
    private boolean checkUserPw(Params params, Record config, String error) {
        try{
	    	// 이벤트 게시판이 아닌 경우
	        if (!PortalBbsAdminService.BBS_CODE_EVENT.equals(config.getString("bbsCd"))) {
	            // 사용자 코드가 없는 경우
	            if ("".equals(params.getString(Params.USER_CD))) {
	                // 사용자 비밀번호가 없는 경우
	                if ("".equals(params.getString("userPw"))) {
	                    throw new ServiceException(error, getMessage(error));
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
     * @param errors 오류코드
     * @return 확인결과
     */
    private boolean checkUserCd(Params params, Record data, String[] errors) {
	    try{    
    		// 로그인후 글을 작성한 경우
	        if (!"".equals(data.getString("userCd"))) {
	            // 사용자 코드가 다른 경우
	            if (!data.getString("userCd").equals(params.getString(Params.USER_CD))) {
	                throw new ServiceException(errors[0], getMessage(errors[0]));
	            }
	        }
	        // 로그인전 글을 작성한 경우
	        else {
	            // 사용자 비밀번호가 다른 경우
	            if (!data.getString("userPw").equals(params.getString("userPw"))) {
	                throw new ServiceException(errors[1], getMessage(errors[1]));
	            }
	        }
	        
	    } catch (ServiceException e) {
        	EgovWebUtil.exLogging(e);   
        	throw new ServiceException(e.getMessage());
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
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
     * 게시판 답글 상태를 확인한다.
     * 
     * @param params 파라메터
     * @param data 데이터
     * @param errors 오류코드
     * @return 확인결과
     */
    private boolean checkAnsState(Params params, Record data, String[] errors) {
        try{
	    	// 부모 게시판 내용 일련번호가 없는 경우
	        if ("".equals(params.getString("pSeq"))) {
	            // 게시판 답글이 접수대기 상태가 아닌 경우
	            if (!"RW".equals(data.getString("ansState"))) {
	                throw new ServiceException(errors[0], getMessage(errors[0]));
	            }
	        }
	        // 부모 게시판 내용 일련번호가 있는 경우
	        else {
	            // 게시판 답글이 접수대기 상태가 아닌 경우
	            if (!"RW".equals(data.getString("ansState"))) {
	                throw new ServiceException(errors[1], getMessage(errors[1]));
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
     * 게시판 첨부파일을 확인한다.
     * 
     * @param params 파라메터
     * @param config 설정
     * @param errors 오류코드
     * @return 확인결과
     */
    private boolean checkBbsFile(Params params, Record config, String[] errors) {
        String type = config.getString("extLimit", EXTENSION_LIMIT_BOTH);
        
        long size = config.getLong("sizeLimit") * 1024 * 1024;
      
        try{
	        MultipartFile[] files = params.getFileArray("atchFile");
	        
	        Pattern pattern = extensionLimitPattern.get(type);
	        
	        for (int i = 0; i < files.length; i++) {
	            MultipartFile file =  files[i];
	            
	            if (file.isEmpty()) {
	                continue;
	            }
	            
	            // 첨부파일 확장자가 제한된 확장자가 아닌 경우
	            if (!pattern.matcher(file.getOriginalFilename().toLowerCase()).matches()) {
	                // 그림 파일로 확장자를 제한한 경우
	                if (EXTENSION_LIMIT_IMG.equals(type)) {
	                    throw new ServiceException(errors[0], getMessage(errors[0]));
	                }
	                // 문서 파일로 확장자를 제한한 경우
	                else if (EXTENSION_LIMIT_DOC.equals(type)) {
	                    throw new ServiceException(errors[1], getMessage(errors[1]));
	                }
	                // 그림 및 문서 파일로 확장자를 제한한 경우
	                else {
	                    throw new ServiceException(errors[2], getMessage(errors[2]));
	                }
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
     * 게시판 내용을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchBbsList(Params params) {
    	
    	setFormSearchParam(params);	// 검색폼 파라미터 데이터 처리
    	
        // 게시판 내용을 검색한다.
        return portalBbsListDao.searchBbsList(params, params.getPage(), params.getRows());
    }
    
    /**
     * 사용자 비밀번호를 확인한다.
     * 
     * @param params 파라메터
     * @return 확인결과
     */
    public Result checkUserPw(Params params) {
    	// 사용자 비밀번호를 조회한다.
        Record password = portalBbsListDao.selectUserPw(params);
        try{    
	        
	        // 사용자 비밀번호가 없는 경우
	        if (password == null) {
	            throw new ServiceException("portal.error.000059", getMessage("portal.error.000059"));
	        }
	        
    	} catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
    	} catch (Exception e) {
    		EgovWebUtil.exLogging(e);
		}
        
        // 사용자 비밀번호가 일치하지 않는 경우
        if (password != null) {
            if (!password.getString("userPw").equals(params.getString("userPw"))) {
                return success("matched", "false");
            }
            else {
                return success("matched", "true");
            }
        }
        return success("matched", "false");
    }
    
    /**
     * 비밀글 여부를 확인한다.
     * 
     * @param params 파라메터
     */
    public void checkSecretYn(Params params) {
        try{
	    	// 비밀글 여부를 조회한다.
	        Record data = portalBbsListDao.selectSecretYn(params);
	        
	        // 비밀글 여부가 없는 경우
	        if (data == null) {
	            throw new ServiceException("portal.error.000059", getMessage("portal.error.000059"));
	        }
	        
	        // 비밀글 여부를 확인한다.
	        checkSecretYn(params, data, new String[] {
	            "portal.error.000050",
	            "portal.error.000043"
	        });
	        
	        if (!"".equals(params.getString("userPw"))) {
	            getSession().setAttribute(SessionAttribute.BBS_USER_PW, params.getString("userPw"));
	        }
        } catch (DataAccessException se) {
        	EgovWebUtil.exLogging(se);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
    }
    
    /**
     * 사용자 코드를 확인한다.
     * 
     * @param params 파라메터
     */
    public void checkUserCd(Params params) {
        // 비밀글 여부를 조회한다.
        Record data = portalBbsListDao.selectSecretYn(params);
        try{
	        // 비밀글 여부가 없는 경우
	        if (data == null) {
	            throw new ServiceException("portal.error.000059", getMessage("portal.error.000059"));
	        }
	        
	        // 비밀글 여부를 확인한다.
	        checkUserCd(params, data, new String[] {
	            "portal.error.000036",
	            "portal.error.000043"
	        });
	        
	        if (!"".equals(params.getString("userPw"))) {
	            getSession().setAttribute(SessionAttribute.BBS_USER_PW, params.getString("userPw"));
	        }
	        
        } catch (ServiceException e) {
        	EgovWebUtil.exLogging(e);   
        	throw new ServiceException(e.getMessage());
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
        	throw new ServiceException(e.getMessage());
		}
    }
    
    /**
     * 게시판 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsListCUD(Params params) {
        // 게시판 내용을 확인한다.
        Record data = checkBbsList(params, "portal.error.000059");
        
        // 비밀글 여부를 확인한다.
        checkSecretYn(params, data, new String[] {
            "portal.error.000050",
            "portal.error.000043"
        });
        
        // 사용자 정보를 삭제한다.
        data.remove("userCd");
        data.remove("userPw");
        
        // 첨부파일이 있는 경우
        if (data.getInt("fileCnt") > 0) {
            // 게시판 첨부파일을 검색한다.
            data.put("files", searchBbsFile(params));
        }
        
        // 링크가 있는 경우
        if (data.getInt("linkCnt") > 0) {
            // 게시판 링크를 검색한다.
            data.put("link", portalBbsLinkDao.searchBbsLink(params));
        }
        
        // 공공데이터가 있는 경우
        if (data.getInt("infCnt") > 0) {
            // 게시판 공공데이터를 검색한다.
            data.put("data", portalBbsInfDao.searchBbsInf(params));
        }

        // 안내수신문자 여부 
       	data.put("dvp", portalBbsListDao.searchBbsDvp(params));
       
        // 게시판 내용 조회수를 수정한다.
        if ( StringUtils.isEmpty(params.getString("updYN")) || !"Y".equals(params.getString("updYN")) ) {
        	// update 수정인 경우 조회수 증가하지 않는다.
        	portalBbsListDao.updateBbsListViewCnt(params);
        }
        
        return data;
    }
    
    /**
     * 게시판 댓글을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchBbsListByPSeq(Params params) {
        // 게시판 댓글을 검색한다.
        return portalBbsListDao.searchBbsListByPSeq(params);
    }
    
    /**
     * 게시판 내용을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Result insertBbsListCUD(Params params) {
        // 개인정보 수집 및 이용 동의여부를 확인한다.
        checkAgreeYn(params, "portal.error.000044");
        
        // 보안코드를 확인한다.
        checkSecuCd(params, "portal.error.000045");
        
        // 게시판 설정을 확인한다.
        Record config = checkBbsAdmin(params, "portal.error.000014");
        
        // 사용자 비밀번호를 확인한다.
        checkUserPw(params, config, "portal.error.000060");
        
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
        
        // 게시판 첨부파일을 등록한다.
        insertBbsFile(params, "atchFile");
        
        // 게시판 내용 첨부파일수를 수정한다
        portalBbsListDao.updateBbsListFileCnt(params);
        
        return success(getMessage("portal.message.000003"));
    }
    
    /**
     * 게시판 내용을 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public Result updateBbsListCUD(Params params) {
        // 개인정보 수집 및 이용 동의여부를 확인한다.
        checkAgreeYn(params, "portal.error.000044");
        
        // 보안코드를 확인한다.
        checkSecuCd(params, "portal.error.000045");
        
        // 게시판 설정을 확인한다.
        Record config = checkBbsAdmin(params, "portal.error.000014");
        
        // 게시판 내용을 확인한다.
        Record data = checkBbsList(params, "portal.error.000034");
        
        // 사용자 코드를 확인한다.
        checkUserCd(params, data, new String[] {
            "portal.error.000036",
            "portal.error.000043"
        });
        
        // 게시판 답글 여부를 확인한다.
        checkAnsYn(params, config, "portal.error.000038");
        
        // 게시판 답글 태그를 확인한다.
        checkAnsTag(params, config, "portal.error.000038");
        
        // 게시판 답글 상태를 확인한다.
        checkAnsState(params, data, new String[] {
            "portal.error.000039",
            "portal.error.000040"
        });
        
        // 게시판 첨부파일을 확인한다.
        checkBbsFile(params, config, new String[] {
            "portal.error.000046",
            "portal.error.000047",
            "portal.error.000048",
            "portal.error.000049"
        });
        
        // 게시판 내용을 수정한다.
        portalBbsListDao.updateBbsList(params);
        
        // 게시판 첨부파일을 삭제한다.
        deleteBbsFile(params, "dtchFile");
        
        // 게시판 첨부파일을 등록한다.
        insertBbsFile(params, "atchFile");
        
        // 게시판 내용 첨부파일수를 수정한다
        portalBbsListDao.updateBbsListFileCnt(params);
        
        if (!"".equals(params.getString("newUserPw"))) {
            getSession().setAttribute(SessionAttribute.BBS_USER_PW, params.getString("newUserPw"));
        }
        
        return success(getMessage("portal.message.000004"));
    }
    
    /**
     * 게시판 내용을 삭제한다.
     * 
     * @param params 파라메터
     * @return 삭제결과
     */
    public Result deleteBbsListCUD(Params params) {
        // 게시판 설정을 확인한다.
        Record config = checkBbsAdmin(params, "portal.error.000014");
        
        // 게시판 내용을 확인한다.
        Record data = checkBbsList(params, "portal.error.000035");
        
        // 사용자 코드를 확인한다.
        checkUserCd(params, data, new String[] {
            "portal.error.000037",
            "portal.error.000043"
        });
        
        // 게시판 답글 상태를 확인한다.
        checkAnsState(params, data, new String[] {
            "portal.error.000041",
            "portal.error.000042"
        });
        
        // 게시판 내용을 삭제한다.
        portalBbsListDao.deleteBbsList(params);
        
        return success(getMessage("portal.message.000005"));
    }
    
    /**
	 * 검색폼 파라미터 데이터 처리(IBATIS에서 조회 되도록) 
	 */
	private void setFormSearchParam(Params params) {
		
		String[] schHdnCateId = params.getStringArray("schHdnCateId");
		ArrayList<String> schArrCateId = new ArrayList<String>(Arrays.asList(schHdnCateId));
		params.set("schArrCateId", schArrCateId);

		String[] schHdnUsedId = params.getStringArray("schHdnUsedId");
		ArrayList<String> schArrUsedId = new ArrayList<String>(Arrays.asList(schHdnUsedId));
		params.set("schArrUsedId", schArrUsedId);
		
		String[] schHdnTag = params.getStringArray("schHdnTag");
		ArrayList<String> schArrTag = new ArrayList<String>(Arrays.asList(schHdnTag));
		params.set("schArrTag", schArrTag);
		
		String[] schHdnSrvCd = params.getStringArray("schHdnSrvCd");
		params.set("schJoinSrvCd", StringUtils.join(schHdnSrvCd, "|"));
	}
	
	@Override
	public List<?> searchBbsDvp(Params params) {
		return portalBbsListDao.searchBbsDvp(params);
	}
	
	/**
	 * 참여형 플랫폼 > 활용가이드 엑셀다운로드
	 */
    public List<?> excelBbsList(Params params) {
    	
    	setFormSearchParam(params);	// 검색폼 파라미터 데이터 처리
    	
        // 게시판 내용을 검색한다.
        return portalBbsListDao.excelBbsList(params);
    }
}