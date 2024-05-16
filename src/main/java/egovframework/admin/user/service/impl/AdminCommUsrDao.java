package egovframework.admin.user.service.impl;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.user.service.CommUsr;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("AdminCommUsrDao")
public class AdminCommUsrDao extends EgovComAbstractDAO{

	/**
	 * ID중복체크
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int memRegUsrIdDup(CommUsr commUsr) throws DataAccessException, Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("AdminCommUsrDao.memRegUsrIdDup", commUsr);
	}

	/**
	 * 관리자 회원계정 등록하기전 usr_cd 추출 max+1
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int getUsrCd() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("AdminCommUsrDao.getUsrCd");
	}

	/**
	 * 관리자 회원계정 등록 INSERT
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int insertUsr(CommUsr commUsr) throws DataAccessException, Exception {
		return (Integer)update("AdminCommUsrDao.insertUsr",commUsr);
	}

	/**
	 * 비밀번호 초기화로 update
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int initialPw(CommUsr commUsr) throws DataAccessException, Exception {
		return (Integer)update("AdminCommUsrDao.initialPw", commUsr); 
	}

	/**
	 * 초기화된 비밀번호와 함께 관리자 정보 조회
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public CommUsr getAdminUserIdPwSearchInfo(CommUsr commUsr) throws DataAccessException, Exception{
		return (CommUsr)selectByPk("AdminCommUsrDao.getAdminUserIdPwSearchInfo", commUsr);
	}

	/**
	 * 관리자 회원가입후 sms전송하기 위한 필요정보 조회
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public CommUsr selectSmsSendInfo(CommUsr commUsr) throws DataAccessException, Exception{
		return (CommUsr)selectByPk("AdminCommUsrDao.selectSmsSendInfo",commUsr);
	}

	/**
	 * 아이디/비밀번호 일치하는지 체크한다.
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int selectPwConfirm(CommUsr commUsr) throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("AdminCommUsrDao.selectPwConfirm",commUsr);
	}

	/**
	 * 아이디/비밀번호 체크완료시 회원의 정보를 조회한다.
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public CommUsr getMemIdPwSearchInfo(CommUsr commUsr) throws DataAccessException, Exception{
		return (CommUsr)selectByPk("AdminCommUsrDao.getMemIdPwSearchInfo",commUsr);
	}

	/**
	 * 회원정보 수정시 비밀번호 변경 없을시 기존 비밀번호 가져온다.
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public String getUserPW(CommUsr commUsr) throws DataAccessException, Exception{
		return (String) selectByPk("AdminCommUsrDao.getUserPW",commUsr);
	}

	/**
	 * 관리자 회원정보 수정한다. UPDATE
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int updateUser(CommUsr commUsr) throws DataAccessException, Exception{
		return (Integer)update("AdminCommUsrDao.updateUser", commUsr); 
	}

	/**
	 * 아이핀 인증(관리자 최초 로그인시)
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int saveIpinAgree(CommUsr commUsr) throws DataAccessException, Exception {
		return (Integer)update("AdminCommUsrDao.saveIpinAgree",commUsr);
	}
	
	/**
	 * I-PIN 인증내역으로 관리자 ID 찾기
	 * @param commUsr
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public String findAdminId(CommUsr commUsr) throws DataAccessException, Exception{
		return (String) selectByPk("AdminCommUsrDao.findAdminId",commUsr);
	}
	
	
}