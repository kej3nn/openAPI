package egovframework.admin.user.service;

import java.util.List;

public interface UserService {
	public List<UserVo> userListAllIbPaging(UserVo userVo);


	/**
	 * 회원아이디 중복확인
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public int memRegUsrIdDup(CommUsr commUsr);


	/**
	 * 관리자 회원가입 insert 한다.
	 * @param commUsr
	 * @param statusI
	 * @return
	 * @throws Exception
	 */
	public int memRegInsertCUD(CommUsr commUsr, String status);


	/**
	 * 아이디/비밀번호 찾기에서 비밀번호 초기화 후 sms로 보낼정보 조회한다.
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public CommUsr UserInfoCUD(CommUsr commUsr);


	/**
	 * sms전송하기 위한 정보 조회
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public CommUsr selectSmsSendInfo(CommUsr commUsr);


	/**
	 * 아이디/비밀번호 일치하는지 체크한다.
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public boolean selectPwConfirm(CommUsr commUsr);


	/**
	 * 아이디/비밀번호 체크완료시 회원의 정보를 조회한다.
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public CommUsr getMemIdPwSearchInfo(CommUsr commUsr);
	
	/**
	 * 아이핀 인증(관리자 최초 로그인시)
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public int saveIpinAgree(CommUsr commUsr);
	
	/**
	 * I-PIN 인증내역으로 관리자 ID 찾기
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	public String findAdminId(CommUsr commUsr);
}
