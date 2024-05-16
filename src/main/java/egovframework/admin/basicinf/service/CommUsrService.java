package egovframework.admin.basicinf.service;

import java.util.List;
import java.util.Map;

import egovframework.admin.openinf.service.OpenInf;

/**
 * 사용자정보 서비스를 정의하기 위한 서비스 인터페이스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public interface CommUsrService {

    /**
     * 사용자 정보를 체크한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public CommUsr selectCommUsrCheck(CommUsr commUsr);

    public CommUsr selectCommUsrCheckSSO(CommUsr commUsr);

    /**
     * 사용자 정보를 전체 조회한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommUsrAllIbPaging(CommUsr commUsr);

    /**
     * 사용자 정보를 단건 조회한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    //public CommUsr selectCommUsr(CommUsr commUsr);
    public List<CommUsr> selectCommUsr(CommUsr commUsr);

    /**
     * 사용자 정보를 입력/수정/삭제 한다
     *
     * @param commUsr
     * @param status
     * @return
     * @throws Exception
     */
    public int saveCommUsrCUD(CommUsr commUsr, String status);

    /**
     * 사용자 로그인 실패 횟수 업데이트(성공이면 0, 실패면 +1)
     *
     * @param commUsr
     * @throws Exception
     */
    public int saveCommUsrFailCnt(CommUsr commUsr);

    /**
     * 아이디 체크(회원 존재여부)
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public int selectCommUsrIdChk(CommUsr commUsr);

    /**
     * 로그인 실패 횟수 조회
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public int selectCommUsrFailCnt(CommUsr commUsr);

    /**
     * 패스워드 변경기간 조회(60일 이후이면 true 반환)
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public boolean selectCommUsrChangePwDttm(CommUsr commUsr);

    /**
     * 패스워드 변경(패스워드 변경 기간초과에 따른)
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public int saveCommUsrChangePw(CommUsr commUsr);

    /**
     * PKI 인증서 등록
     *
     * @param commusr
     * @return
     * @throws Exception
     */
    public int savePkiReg(CommUsr commusr);

    /**
     * PKI 인증서 등록 체크
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public CommUsr selectCommUsrPkiCheck(CommUsr commUsr);

    /**
     * Q&A 답변 요청 건수
     *
     * @return
     * @throws Exception
     */
    public int selectQNACnt();

    /**
     * 활용사례 등록 요청 건수
     *
     * @return
     * @throws Exception
     */
    public int selectGalleryCnt();

    /**
     * 관리자의 로그인 접속이력을 기록한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public int insertLogCommUsr(CommUsr commUsr);

    /**
     * 사용자 정보를 조회한다.
     *
     * @param loginVo
     * @return
     * @throws Exception
     */
    public int selectCommUsrInfo(CommUsr commUsr);

    /**
     * AccCd 권한 체크하여 sys,admin 인 경우만 업무처리정보 볼수있다.
     *
     * @return
     * @throws Exception
     */
    public int selectAccCdCheck(CommUsr commUsr);

    /**
     * 이미 등록된 pki라면 등록 못하도록 한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public int selectDupPki(CommUsr commUsr);

    /**
     * 비밀번호 변경시 기존의 비밀번호로 변경못하도록 체크한다.
     *
     * @param commUsr
     * @return
     * @throws Exception
     */
    public int selectUserPwCheck(CommUsr commUsr);

    /**
     * GPIN 관리자 중복체크
     *
     * @return
     * @throws Exception
     */
    public int gpinAdminDupCheck(CommUsr commUsr);

    /**
     * ID중복체크
     *
     * @param commUsr
     * @param status
     * @return
     * @throws Exception
     */
    public int commUsrIdDup(CommUsr commUsr, String status);
}
