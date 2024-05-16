package egovframework.admin.user.service;

import java.util.ArrayList;
import java.util.Map;

public interface UserKeyService {
//	public List<UserKey> userKeyAllIbPaging(UserKey userKey);
	public Map<String, Object> userKeyAllIbPaging(UserKey userKey);
	public int updateUserKeyCUD(ArrayList<UserKey> list);
}
