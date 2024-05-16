package egovframework.admin.user.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.user.service.UserKey;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("UserKeyDao")
public class UserKeyDao extends EgovComAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<UserKey> userKeyAll(UserKey userKey) throws DataAccessException, Exception{
		return (List<UserKey>) list("UserKeyDao.UserKeyAll",userKey);
	}
	
	public int userKeyAllCnt(UserKey userKey) throws DataAccessException, Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("UserKeyDao.UserKeyAllCnt", userKey);
    }
	
	public int updateUserKey(UserKey userKey) throws DataAccessException, Exception{
		return update("UserKeyDao.UpdateUserKey",userKey);
	}
}
