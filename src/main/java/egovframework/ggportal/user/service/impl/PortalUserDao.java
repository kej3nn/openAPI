package egovframework.ggportal.user.service.impl;


import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

import java.util.List;

/**
 * 사용자 정보를 관리하는 DAO 클래스이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/01
 */
@Repository("ggportalUserDao")
public class PortalUserDao extends BaseDao {
    /**
     * 사용자 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectUser(Params params) {
        // 사용자 정보를 조회한다.
        return (Record) select("PortalUserDao.selectUser", params);
    }
    
    /**
     * 회원 ID로 사용자 정보를 조회한다. 
     * @param params
     * @return
     */
    public Record selectUserInputId(Params params) {
    	// 사용자 정보를 조회한다.
    	return (Record) select("PortalUserDao.selectUserInputId", params);
    }
    
    /**
     * SSO로 접근시 사용자 정보를 조회한다.(전자문서)
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSSOUser(Record record) {
        // 사용자 정보를 조회한다.
        return (Record) select("PortalUserDao.selectSSOUser", record);
    }

    /**
     * 통합회원 ID로 기존 회원 Id 조회
     * @param user
     * @return
     */
    public Record selectNahomeUser1(List<Record> checkUserId) {
        return (Record)select("PortalUserDao.selectNahomeUser1", checkUserId);
    }

    /**
     * 통합회원 ID로 기존 회원 Id 조회
     * @param user
     * @return
     */
    public Record selectNahomeUser(Record user) {
        return (Record)select("PortalUserDao.selectNahomeUser", user);
    }

    /**
     * 전환된 통합회원 id로 기존회원 id를 변경한다.
     * @param user
     * @return
     */
    public Object updateNahomeUser(Record user) {
        return update("PortalUserDao.updateNahomeUser", user);
    }

    /**
     * 관리자일 경우 전환
     * @param user
     * @return
     */
    public Object updateCommUser(Record user){
        return update("PortalUserDao.updateCommUser",user);
    }

    /**
     * 사용자 정보를 머지한다. 
     * @param params
     * @return
     */
    public Object mergeUser(Record user) {
    	return update("PortalUserDao.mergeUser", user);
    }
    
    /**
     * 사용자 정보를 등록한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Object insertUser(Params params) {
        // 사용자 정보를 등록한다.
        return insert("PortalUserDao.insertUser", params);
    }
    
    /**
     * 사용자 정보를 수정한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public int updateUser(Params params) {
        // 사용자 정보를 수정한다.
        return update("PortalUserDao.updateUser", params);
    }
   
    /**
     * 포털 유저 재조회(입력한 시퀀스 조회하기 위해)
     */
    public Record selectSeqUser(Record user) {
    	return (Record) select("PortalUserDao.selectSeqUser", user);
    }
    
    
}