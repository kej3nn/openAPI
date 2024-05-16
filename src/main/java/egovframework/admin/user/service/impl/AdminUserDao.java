package egovframework.admin.user.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 관리자 정보를 관리하는 DAO 클래스이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/01
 */
@Repository("adminUserDao")
public class AdminUserDao extends BaseDao {
	/**
     * 관리자화면 접근시 사용자 정보를 확인한다. 	
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public int selectUserCheck(Params params) {
        return (Integer) select("adminUserDao.selectUserCheck", params);
    }
    
    /**
     * 관리자화면 접근시 관리자 정보를 확인한다. 
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public int selectAdmUserCheck(Params params) {
        return (Integer) select("adminUserDao.selectAdmUserCheck", params);
    }
    
    /**
     * 관리자 정보를 조회한다. 
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public CommUsr selectAdmUser(Params params) {
    	return (CommUsr) select("adminUserDao.selectAdmUser", params);
    }
    
    /**
     * 관리자 정보를 머지한다. 
     * @param params
     * @return
     */
    public Object mergeCommUser(Record user) {
    	return update("adminUserDao.mergeCommUser", user);
    }

    /**
     * 관리자 로그인 이력정보를 등록한다.
     * @param params
     */
    public void insertLogCommUsr(Params params) {
    	insert("adminUserDao.insertLogCommUsr", params);
    }
}
