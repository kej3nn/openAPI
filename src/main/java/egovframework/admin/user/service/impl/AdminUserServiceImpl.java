package egovframework.admin.user.service.impl;



import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.user.service.AdminUserService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

/**
 * 사용자 정보를 관리하는 서비스 클래스이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/01
 */
@Service("adminUserService")
public class AdminUserServiceImpl extends BaseService implements AdminUserService {

	@Resource(name="adminUserDao")
	private AdminUserDao adminUserDao;

	/**
	 * 관리자 메뉴 접근시 유저 및 권한 체크
	 */
	@Override
	public int updateLoginProc(Params params) {
		
		try {
			HttpSession session = getSession();
			
			// 관리자에 데이터 없을경우 등록
			Record user = new Record();
			user.put("usrCd", session.getAttribute(SessionAttribute.USER_CD));
			user.put("usrId", session.getAttribute(SessionAttribute.USER_ID));
			user.put("usrNm", session.getAttribute(SessionAttribute.USER_NM));
			user.put("orgCd", session.getAttribute(SessionAttribute.DEPT_CODE));
			// 2023-12. 테스트 위해 임시 설정 ::start
			user.put("usrCd", Integer.valueOf("31052379"));
            user.put("usrId", "nasys");
            user.put("usrNm", "관리자");
            user.put("orgCd", "9710220");
            // 2023_12_02. 테스트 위한 임시 설정 ::end
			adminUserDao.mergeCommUser(user);
			
			// 체크 파라미터
			params.set("userCd", user.getInt("usrCd"));
			params.set("userId", user.getString("usrId"));
			params.set("deptCode", user.getString("orgCd"));
			
			// 사용자 체크
			int iUserCheck = adminUserDao.selectUserCheck(params);
			
			if ( iUserCheck == 0 ) {
				return -90;
			}
			
			// 관리자 체크
			int iAdmUserCheck = adminUserDao.selectAdmUserCheck(params);
			
			if ( iAdmUserCheck == 0 ) {
				return -80;
			}
			
			// 정보 조회 후 관리자 세션 저장
			CommUsr commUsr = adminUserDao.selectAdmUser(params);
			getSession().setAttribute("loginVO", commUsr);
			
			// 로그인 이력 등록
			
			adminUserDao.insertLogCommUsr(params);
		} catch(ServiceException sve) {
			EgovWebUtil.exLogging(sve);
		} catch(Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			return -99;
		}
		
		return 1;
	}
	
}
