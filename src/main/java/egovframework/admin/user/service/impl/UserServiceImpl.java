package egovframework.admin.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.user.service.CommUsr;
import egovframework.admin.user.service.UserService;
import egovframework.admin.user.service.UserVo;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.util.UtilEncryption;
import egovframework.common.util.UtilString;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("UserService")
public class UserServiceImpl extends AbstractServiceImpl implements UserService{
	
	@Resource(name="UserListDao")
	private UserListDao userListDao;
	
	@Resource(name="AdminCommUsrDao")
	private AdminCommUsrDao adminCommUsrDao;
	
	@Override
	public List<UserVo> userListAllIbPaging(@NonNull UserVo userVo) {
		String email;
		String phone;
		int maxSize;
		String nmStrFirst;
		String nmStrLast;
		String nmStr="";

		String pubDttmFrom = StringUtils.defaultString(userVo.getPubDttmFrom());
		String pubDttmTo = StringUtils.defaultString(userVo.getPubDttmTo());
		if(pubDttmFrom.equals("")){
			userVo.setPubDttmFrom(pubDttmTo);
		}
		if(pubDttmTo.equals("")){
			userVo.setPubDttmTo(pubDttmFrom);
		}
		
		/* 이메일,휴대폰 암호화 진행해야함*/
		
		List<UserVo> list=userListDao.userListAll(userVo);

		return list;
	}

	/**
	 * 회원아이디 중복확인 -1은 중복이다.
	 */
	@Override
	public int memRegUsrIdDup(CommUsr commUsr) {
		int result=0;
		try {
			if (adminCommUsrDao.memRegUsrIdDup(commUsr) > 0) {
				return -1; 
			}
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 관리자 회원가입/ 수정
	 */
	@Override
	public int memRegInsertCUD(@NonNull CommUsr commUsr, String status) {
		int result = 0;
		/*
    	UtilEncryption ue = new UtilEncryption();
    	commUsr.setUsrTel(commUsr.getUsrTelSplit1() + "-" + commUsr.getUsrTelSplit2() + "-" + commUsr.getUsrTelSplit3());
    	commUsr.setUsrHp(commUsr.getUsrHpSplit1() + "-" + commUsr.getUsrHpSplit2() + "-" + commUsr.getUsrHpSplit3());
    	*/
    	try {
    		if(WiseOpenConfig.STATUS_I.equals(status)){
    			int usrCd = adminCommUsrDao.getUsrCd(); //userCd 값 구한다. max+1
    			commUsr.setUsrCd(usrCd);
    			result = adminCommUsrDao.insertUsr(commUsr); //회원가입
    		}
    		else if( WiseOpenConfig.STATUS_U.equals(status)){
    			result = adminCommUsrDao.updateUser(commUsr); //회원정보 수정
    		}
    		else{
    			result = WiseOpenConfig.STATUS_ERR;
    		}
		} catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		
		return result;
	}

	/**
	 * 아이디/비밀번호 찾기에서 비밀번호 초기화 후 sms로 보낼정보 조회한다.
	 */
	@Override
	public CommUsr UserInfoCUD(CommUsr commUsr) {
		CommUsr result = new CommUsr();
		try {
			result = adminCommUsrDao.getAdminUserIdPwSearchInfo(commUsr); //사용자 정보 조회
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 관리자 회원가입후 sms전송하기 위한 정보 조회
	 */
	@Override
	public CommUsr selectSmsSendInfo(CommUsr commUsr) {
		CommUsr result = new CommUsr();
		try {
			result = adminCommUsrDao.selectSmsSendInfo(commUsr);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 아이디/비밀번호 일치하는지 체크한다.
	 */
	@Override
	public boolean selectPwConfirm(@NonNull CommUsr commUsr) {
    	UtilEncryption ue = new UtilEncryption();
		String usrPw = StringUtils.defaultString(commUsr.getUsrPw());
    	commUsr.setUsrPw(ue.encryptSha256(usrPw, usrPw.getBytes()));
    	try {
    		if(adminCommUsrDao.selectPwConfirm(commUsr) == 1){ //아이디 비밀번호가 일치하면 true ,계정은 유일해야한다
    			return true;
    		}
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return false;
	}

	/**
	 * 아이디/비밀번호 체크완료시 회원의 정보를 조회한다.
	 */
	@Override
	public CommUsr getMemIdPwSearchInfo(CommUsr commUsr) {
		CommUsr usr = new CommUsr();
		try {
			usr = adminCommUsrDao.getMemIdPwSearchInfo(commUsr);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    	//UtilEncryption ue = new UtilEncryption();
    	//String usrTel = ue.decrypt(usr.getUsrTelSplit1());
    	//String usrHp = ue.decrypt(usr.getUsrHpSplit1());
    	
    	String usrTel = UtilString.null2Blank(usr.getUsrTelSplit1());
    	//String usrHp = usr.getUsrHpSplit1();
    	String usrHp = UtilString.null2Blank(usr.getUsrHpSplit1());

    	String[] usrTel_sp = usrTel.split("-");
    	//String[] usrHp_sp = usrHp.split("-");
    	String[] usrHp_sp = null;
    	if ( !"".equals(usrHp) ) {
    		usrHp_sp = usrHp.split("-");
    	}
    	
    	if(usrTel_sp != null) {
    		if(usrTel_sp.length == 3) {
    			usr.setUsrTelSplit1(usrTel_sp[0]);
    			usr.setUsrTelSplit2(usrTel_sp[1]);
    			usr.setUsrTelSplit3(usrTel_sp[2]);
    		} else if(usrTel_sp.length == 2) {
    			usr.setUsrTelSplit1(usrTel_sp[0]);
    			usr.setUsrTelSplit2(usrTel_sp[1]);
    		} else if(usrTel_sp.length == 1) {
    			usr.setUsrTelSplit1(usrTel_sp[0]);
    		}
    	}
    	
    	if(usrHp_sp != null) {
    		if(usrHp_sp.length == 3) {
    			usr.setUsrHpSplit1(usrHp_sp[0]);
    			usr.setUsrHpSplit2(usrHp_sp[1]);
    			usr.setUsrHpSplit3(usrHp_sp[2]);
    		} else if(usrHp_sp.length == 2) {
    			usr.setUsrHpSplit1(usrHp_sp[0]);
    			usr.setUsrHpSplit2(usrHp_sp[1]);
    		} else if(usrHp_sp.length == 1) {
    			usr.setUsrHpSplit1(usrHp_sp[0]);
    		}
    	}
    	
		return usr;
	}
	
	/**
	 * 아이핀 인증(관리자 최초 로그인시)
	 */
	public int saveIpinAgree(CommUsr commUsr) {
		int result = 0;
		try {
			result = adminCommUsrDao.saveIpinAgree(commUsr);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		return result;
	}
	
	/**
	 * I-PIN 인증내역으로 관리자 ID 찾기
	 */
	public String findAdminId(CommUsr commUsr) {
		String result = "";
		try {
			result = adminCommUsrDao.findAdminId(commUsr);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
}
