package egovframework.admin.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.user.service.UserKey;
import egovframework.admin.user.service.UserKeyService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("UserKeyService")
public class UserKeyServiceImpl extends AbstractServiceImpl implements UserKeyService{
	
	@Resource(name="UserKeyDao")
	private UserKeyDao userKeyDao;
	
	
    public Map<String, Object> userKeyAllIbPaging(UserKey userKey) {
		int maxSize;
		String str="";
		String strLast;
		String strFirst;
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<UserKey> list = userKeyDao.userKeyAll(userKey);
			for(int i=0;i<list.size();i++){
				/* 아이디 암호화 [*] 처리 */
				maxSize=list.get(i).getUserId().length(); //아이디 총길이
				for(int j=1;j<=maxSize-3;j++){ //비어있는 수만큼 * 붙이기
					str+="*";
				}
				list.get(i).setUserId(list.get(i).getUserId().substring(0,3)+str);
				str="";//초기화
				
				/* 이름 암호화 [*] 처리 */
				maxSize=list.get(i).getUserNm().length(); //이름 총길이
				strLast=list.get(i).getUserNm().substring(maxSize-1,maxSize); //마지막 문자
				strFirst=list.get(i).getUserNm().substring(0,1);//처음 문자
				for(int j=1;j<maxSize;j++){ //비어있는 수만큼 * 붙이기
					str+="*";
				}
				list.get(i).setUserNm(strFirst+str+strLast);
				str="";//초기화
				
				/* 인증키 암호화 [*] 처리 */
				maxSize=list.get(i).getActKey().length(); //아이디 총길이
				for(int j=1;j<=maxSize-1;j++){ //비어있는 수만큼 * 붙이기
					str+="*";
				}
				list.get(i).setActKey(list.get(i).getActKey().substring(0,1)+str);
				str="";//초기화
			}    	
			int cnt = userKeyDao.userKeyAllCnt(userKey);
			map.put("resultList", list);
			map.put("resultCnt", Integer.toString(cnt));
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return map;
    }
	
/*	@Override
	public List<UserKey> userKeyAllIbPaging(UserKey userKey) {
		int maxSize;
		String str="";
		String strLast;
		String strFirst;
		
		List<UserKey> list=userKeyDao.userKeyAll(userKey);
		
		for(int i=0;i<list.size();i++){
			 아이디 암호화 [*] 처리 
			maxSize=list.get(i).getUserId().length(); //아이디 총길이
			for(int j=1;j<=maxSize-3;j++){ //비어있는 수만큼 * 붙이기
				str+="*";
			}
			list.get(i).setUserId(list.get(i).getUserId().substring(0,3)+str);
			str="";//초기화
			
			 이름 암호화 [*] 처리 
			maxSize=list.get(i).getUserNm().length(); //이름 총길이
			strLast=list.get(i).getUserNm().substring(maxSize-1,maxSize); //마지막 문자
			strFirst=list.get(i).getUserNm().substring(0,1);//처음 문자
			for(int j=1;j<maxSize;j++){ //비어있는 수만큼 * 붙이기
				str+="*";
			}
			list.get(i).setUserNm(strFirst+str+strLast);
			str="";//초기화
			
			 인증키 암호화 [*] 처리 
			maxSize=list.get(i).getActKey().length(); //아이디 총길이
			for(int j=1;j<=maxSize-1;j++){ //비어있는 수만큼 * 붙이기
				str+="*";
			}
			list.get(i).setActKey(list.get(i).getActKey().substring(0,1)+str);
			str="";//초기화
		}
		return list;
	}*/
	@Override
	public int updateUserKeyCUD(ArrayList<UserKey> list) {
		int result = 0;
			for(UserKey userKey : list){
				result = saveUserKeyCUD(userKey);
			}
		return result;
	}
	//데이터 수정
	private int saveUserKeyCUD(@NonNull UserKey userKey) {
		int result = 0;
		userKey.setLimitId("관리자");
		try {
			if(StringUtils.defaultString(userKey.getStatus()).equals("U")){
				result += userKeyDao.updateUserKey(userKey);
			}
		} catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		
		return result;
	}
}
