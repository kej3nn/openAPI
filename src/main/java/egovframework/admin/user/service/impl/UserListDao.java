package egovframework.admin.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.admin.user.service.UserVo;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("UserListDao")
public class UserListDao extends EgovComAbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<UserVo> userListAll(UserVo userVo){
		return (List<UserVo>) list("UserListDao.selectUserListAll",userVo);
	}
}
