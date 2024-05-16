package egovframework.ggportal.user.service.impl;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.HashEncrypt;
import egovframework.common.util.UtilEncryption;
import egovframework.ggportal.expose.service.impl.PortalExposeInfoDao;
import egovframework.ggportal.user.service.PortalUserService;
import egovframework.portal.model.User;

/**
 * 사용자 정보를 관리하는 서비스 클래스이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/01
 */
@Service("ggportalUserService")
public class PortalUserServiceImpl extends BaseService implements PortalUserService {
	
    /**
     * 사용자 정보를 관리하는 DAO
     */
    @Resource(name="ggportalUserDao")
    private PortalUserDao portalUserDao;
    
    /**
     * 사용자 로그인 이력을 관리하는 DAO
     */
    @Resource(name="ggportalLogUserDao")
    private PortalLogUserDao portalLogUserDao;
    
    /**
     * 정보공개 청구 관리하는 DAO
     */
    @Resource(name="portalExposeInfoDao")
    private PortalExposeInfoDao portalExposeInfoDao;
    
    /**
	 * 포털 로그인 처리
	 */
	@Override
	public int checkUserLoginProcCUD(HttpServletRequest request, Params params) {
		int result = -99;
		
		String memberId = params.getString("memberId");
    	String memberPw = params.getString("memberPw");
    	
    	// 입력체크
    	if ( StringUtils.isBlank(memberId) && StringUtils.isBlank(memberPw) ) {
    		result = -90;
    		return result;
    	}
    	
    	// 암호화
    	UtilEncryption ue = new UtilEncryption();
    	params.set("memberPw", ue.encSHA256(memberPw));
    	
    	// 유저 확인
    	Record user = portalUserDao.selectUser(params);
    	if ( user == null ) {
    		result = -80;
    		return result;
    	}
    	
    	// 유저정보 등록(데이터가 없을경우)
    	portalUserDao.mergeUser(user);
    	
    	Record insUser = portalUserDao.selectSeqUser(user);
    	
    	 // 사용자 로그인 이력을 등록한다.
    	params.set("userCd", insUser.getInt("userCd"));
        portalLogUserDao.insertLogUser(params);
        
        // 세션 세팅
        HttpSession session = getSession();
        
        // 정보공개 청구 세션 세팅
        Params opnLoginUsrParam = new Params();
        opnLoginUsrParam.set("regId", insUser.getInt("userCd"));
        setOpnUsrAuthentication(session, opnLoginUsrParam);
    	
    	User usr = new User();
    	usr.setUserCd(insUser.getInt("userCd"));
    	usr.setUserId(user.getString("memberId"));
    	usr.setUserNm(user.getString("name"));
    	usr.setDeptCode(user.getString("deptCode"));
    	usr.setSessionOrgCd(user.getString("orgCd"));
    	usr.setSessionOrgNm(user.getString("orgNm"));
    	session.setAttribute(SessionAttribute.USER,         		usr);
    	session.setAttribute(SessionAttribute.USER_CD,      	usr.getUserCd());
    	session.setAttribute(SessionAttribute.USER_ID,      	usr.getUserId());
    	session.setAttribute(SessionAttribute.USER_NM,      	usr.getUserNm());
    	session.setAttribute(SessionAttribute.ORG_NAME, 		user.getString("orgNm"));
    	session.setAttribute(SessionAttribute.ORG_CODE, 		user.getString("orgCd"));
    	session.setAttribute(SessionAttribute.DEPT_CODE, 		usr.getDeptCode());
    	
    	String accIp = user.getString("accIp");
    	String accYn = "N";
        if( StringUtils.equals(accIp, "*") ) {
        	accYn = "Y";
        } else {
        	//접속 IP 확인
        	String remoteIp = request.getRemoteAddr();
        	String[] ipArr = remoteIp.split("[.]");
        	String chkIp = ipArr.length > 2 ? ipArr[0]+"."+ipArr[1] : remoteIp;
            if(accIp.contains(chkIp)) {
            	accYn = "Y";
            }
            else {
            	accYn = "N";
            }
        }
        session.setAttribute(SessionAttribute.IS_ADMIN, 		accYn);
        
    	result = 1;
    	
    	return result;
	}
	
	/**
	 * 포털 SSO 로그인 처리
	 */
	public int checkUserSSOLoginProcCUD(HttpServletRequest request, Params params) {
		int result = -99;
		
		String memberId = params.getString("memberId");
    	
    	// 입력체크
    	if ( StringUtils.isBlank(memberId) ) {
    		result = -90;
    		return result;
    	}
    	
    	// 유저 확인(로그인 ID로 유저를 조회한다.)
    	Record user = portalUserDao.selectUserInputId(params);
    	if ( user == null ) {
    		result = -80;
    		return result;
    	}

		try {
			//전환된 톨합회원 ID로 기존회원 ID 조회
			Record checkUser = portalUserDao.selectNahomeUser(user);

			//유저정보가 있을경우 수정
			if(checkUser != null) {
				user.put("checkUserId",checkUser.getString("userId"));
				user.put("checkUserCd",checkUser.getString("userCd"));
				// 전환된 통합회원 id로 기존회원 id를 변경한다.
				portalUserDao.updateNahomeUser(user);
				portalUserDao.updateCommUser(user);
			}
		} catch(RuntimeException e) {
			e.printStackTrace();
			log.info("@@@@@SSOLoginUserId : " + user.getString("memberId"));
		} catch (Exception e) {
			e.printStackTrace();
			log.info("@@@@@SSOLoginUserId : " + user.getString("memberId"));
		}


    	// 유저정보 등록(데이터가 없을경우)
    	portalUserDao.mergeUser(user);
    	
    	Record insUser = portalUserDao.selectSeqUser(user);
    	
    	 // 사용자 로그인 이력을 등록한다.
    	params.set("userCd", insUser.getInt("userCd"));
        portalLogUserDao.insertLogUser(params);
        
        // 세션 세팅
        HttpSession session = getSession();
        
        // 정보공개 청구 세션 세팅
        Params opnLoginUsrParam = new Params();
        opnLoginUsrParam.set("regId", insUser.getInt("userCd"));
        setOpnUsrAuthentication(session, opnLoginUsrParam);
    	
    	User usr = new User();
    	usr.setUserCd(insUser.getInt("userCd"));
    	usr.setUserId(user.getString("memberId"));
    	usr.setUserNm(user.getString("name"));
    	usr.setDeptCode(user.getString("deptCode"));
    	usr.setSessionOrgCd(user.getString("orgCd"));
    	usr.setSessionOrgNm(user.getString("orgNm"));
    	session.setAttribute(SessionAttribute.USER,         		usr);
    	session.setAttribute(SessionAttribute.USER_CD,      	usr.getUserCd());
    	session.setAttribute(SessionAttribute.USER_ID,      	usr.getUserId());
    	session.setAttribute(SessionAttribute.USER_NM,      	usr.getUserNm());
    	session.setAttribute(SessionAttribute.ORG_NAME, 		user.getString("orgNm"));
    	session.setAttribute(SessionAttribute.ORG_CODE, 		user.getString("orgCd"));
    	session.setAttribute(SessionAttribute.DEPT_CODE, 		usr.getDeptCode());
    	
    	String accIp = user.getString("accIp");
    	String accYn = "N";
        if( StringUtils.equals(accIp, "*") ) {
        	accYn = "Y";
        } else {
        	//접속 IP 확인
        	String remoteIp = request.getRemoteAddr();
        	String[] ipArr = remoteIp.split("[.]");
        	String chkIp = ipArr.length > 2 ? ipArr[0]+"."+ipArr[1] : remoteIp;
            if(accIp.contains(chkIp)) {
            	accYn = "Y";
            }
            else {
            	accYn = "N";
            }
        }
        session.setAttribute(SessionAttribute.IS_ADMIN, 		accYn);
        
    	result = 1;
    	
    	return result;
	}
	
	
	
	
	public void setOpnUsrAuthentication(HttpSession session, Params params) {
		
		Map<String, Object> opnLoginUsr = portalExposeInfoDao.selectLoginUserInfo(params);
        
//        if ( !opnLoginUsr.isEmpty() 
//				&& StringUtils.isNotEmpty((String)opnLoginUsr.get("user1Ssn")) && StringUtils.isNotEmpty((String) opnLoginUsr.get("user2Ssn")) ) {
//			
//			session.setAttribute("loginName", (String) opnLoginUsr.get("userNm"));
//			session.setAttribute("loginRno1", (String) opnLoginUsr.get("user1Ssn"));
//			session.setAttribute("loginRno2", (String) opnLoginUsr.get("user2Ssn"));
//		}
		session.removeAttribute("loginDiv"); 
		session.removeAttribute("loginName");
		session.removeAttribute("loginRno1");
		session.removeAttribute("openUserIp");
		session.removeAttribute("dupInfo");
		session.removeAttribute("rauthTag");
		
		if ( !opnLoginUsr.isEmpty() 
				&& StringUtils.isNotEmpty((String)opnLoginUsr.get("rauthDi")) ) {
			
			session.setAttribute("loginName", (String) opnLoginUsr.get("userNm")); 
			session.setAttribute("loginRno1", (String) opnLoginUsr.get("rauthBirth")); //생년월일
			session.setAttribute("dupInfo", (String) opnLoginUsr.get("rauthDi"));      // 본인인증중복가입확인정보 
			session.setAttribute("rauthTag", (String) opnLoginUsr.get("rauthTag"));    //본인인증구분
			session.setAttribute("loginDiv", (String) opnLoginUsr.get("rauthNi"));     //본인인증내외국인구분
		}
	}

	@Override
	public int checkSSOUserLoginProcCUD(Params params) {
		int result = -99;
		
		try {
			
			String encUserData = params.getString("userdata");
			
			HashEncrypt hashEncrypt = new HashEncrypt();
			byte[] keyHash = hashEncrypt.makeHashByte("wjdqhrhdrovhxjf!");
			
			String desUserData = hashEncrypt.decrypt(keyHash, encUserData);
			
			
			if ( StringUtils.isNotEmpty(encUserData) ) {
				
				Record ssoUser = parseSSOUserData(desUserData);
				
				String memDupInfo = ssoUser.getString("id");
				if ( StringUtils.isNotBlank(memDupInfo) ) {
					// 유효한 식별번호가 아닐경우 메인페이지로 이동
					// 문자2개 숫자4개 ex) AA1234
					Pattern pattern = Pattern.compile("^([a-zA-Z]{2})([0-9]{4})$");
					Matcher matcher = pattern.matcher(memDupInfo);
					if( !matcher.matches() ){
						return -81;	// 유효한 식별키가 아님
					}
				}
				else {
					return -80;		// 비정상 연동
				}
				
				String lastlogin = ssoUser.getString("lastlogin");
				
				// 유저 확인
		    	Record tUser = portalUserDao.selectSSOUser(ssoUser);
		    	if ( tUser == null ) {
		    		result = -90;
		    		return result;
		    	}
		    	
		    	String lastLoginYmdhmsf = tUser.getString("lastLoginYmdhmsf");
		    	if ( !StringUtils.equals(lastLoginYmdhmsf, "") ) {
		    		long lLastLoginYmdhmsf = Long.parseLong(lastLoginYmdhmsf);					// 유저 마지막 로그인시간
		    		long lSsoLoginYmdmsf = Long.parseLong(ssoUser.getString("lastlogin"));		// sso 접속시간
		    		
		    		if ( lLastLoginYmdhmsf >= lSsoLoginYmdmsf ) {
		    			return -82;	// 비정상적인 접근
		    		}
		    	}
				
				// 유저정보 등록(데이터가 없을경우)
				Record user = new Record();
				user.put("num", ssoUser.getInt("uid"));
				user.put("memberId", tUser.getString("memberId"));
				user.put("name", tUser.getString("name"));
				user.put("lastLoginYmdhmsf", ssoUser.getString("lastLoginYmdhmsf"));
		    	
		    	portalUserDao.mergeUser(user);
		    	
		    	Record insUser = portalUserDao.selectSeqUser(user);
		    	
		    	// 사용자 로그인 이력을 등록한다.
		    	params.set("userCd", insUser.getInt("userCd"));
		        portalLogUserDao.insertLogUser(params);
				
		        // 세션 세팅
		        HttpSession session = getSession();
		        
		        // 정보공개 청구 세션 세팅
		        Params opnLoginUsrParam = new Params();
		        opnLoginUsrParam.set("regId", insUser.getInt("userCd"));
		        setOpnUsrAuthentication(session, opnLoginUsrParam);
		    	
		    	User usr = new User();
		    	usr.setUserCd(insUser.getInt("userCd"));
		    	usr.setUserId(user.getString("memberId"));
		    	usr.setUserNm(user.getString("name"));
		    	usr.setDeptCode(ssoUser.getString("deptcode"));
		    	usr.setSessionOrgCd(tUser.getString("orgCd"));
		    	usr.setSessionOrgNm(tUser.getString("orgNm"));
		    	session.setAttribute(SessionAttribute.USER,         usr);
		    	session.setAttribute(SessionAttribute.USER_CD,      usr.getUserCd());
		    	session.setAttribute(SessionAttribute.USER_ID,      usr.getUserId());
		    	session.setAttribute(SessionAttribute.USER_NM,      usr.getUserNm());
		    	session.setAttribute(SessionAttribute.ORG_NAME, 	usr.getSessionOrgNm());
		    	session.setAttribute(SessionAttribute.ORG_CODE, 	usr.getSessionOrgCd());
		    	session.setAttribute(SessionAttribute.DEPT_CODE, 	usr.getDeptCode());
		    	
		    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		    	String accIp = tUser.getString("accIp");
		    	String accYn = "N";
		        if( StringUtils.equals(accIp, "*") ) {
		        	accYn = "Y";
		        } else {
		        	//접속 IP 확인
		        	String remoteIp = request.getRemoteAddr();
		        	String[] ipArr = remoteIp.split("[.]");
		        	String chkIp = ipArr.length > 2 ? ipArr[0]+"."+ipArr[1] : remoteIp;
		            if(accIp.contains(chkIp)) {
		            	accYn = "Y";
		            }
		            else {
		            	accYn = "N";
		            }
		        }
		        session.setAttribute(SessionAttribute.IS_ADMIN, 		accYn);
				
		    	result = 1;
			}
			else {
				log.debug("복호화 데이터 없음.");
			}
		}catch(NumberFormatException nfe){
			EgovWebUtil.exLogging(nfe);	
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			return -99;
		}
		
		
		return result;
	}
	
	/**
	 * 전자문서에서 넘어온 XML 파싱
	 * @param str	XML String
	 * @return
	 */
	private Record parseSSOUserData(String str) {
		
		Record user = new Record();
		
		try {
			SAXReader sax = new SAXReader();
			
			InputStream is = new ByteArrayInputStream(str.getBytes());
			
	    	Document dom = sax.read(is);
	    	
	        Element root = dom.getRootElement();
	        
	        Element userElement = root.element("user");
	        
	        for ( Iterator it = userElement.elementIterator(); it.hasNext(); ) {
	        	Element el = (Element) it.next();
	        	user.put(el.getName(), el.getText());
	        }
	        
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return user;
		
	}
	
}