/*
 * @(#)PortalOauthServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service.impl;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.oltu.oauth2.client.OAuthClient;
import org.apache.oltu.oauth2.client.URLConnectionClient;
import org.apache.oltu.oauth2.client.request.OAuthBearerClientRequest;
import org.apache.oltu.oauth2.client.request.OAuthClientRequest;
import org.apache.oltu.oauth2.client.request.OAuthClientRequest.AuthenticationRequestBuilder;
import org.apache.oltu.oauth2.client.request.OAuthClientRequest.TokenRequestBuilder;
import org.apache.oltu.oauth2.client.response.OAuthAccessTokenResponse;
import org.apache.oltu.oauth2.client.response.OAuthAuthzResponse;
import org.apache.oltu.oauth2.client.response.OAuthJSONAccessTokenResponse;
import org.apache.oltu.oauth2.client.response.OAuthResourceResponse;
import org.apache.oltu.oauth2.common.exception.OAuthProblemException;
import org.apache.oltu.oauth2.common.exception.OAuthSystemException;
import org.apache.oltu.oauth2.common.message.types.GrantType;
import org.apache.oltu.oauth2.common.message.types.ResponseType;
import org.apache.oltu.oauth2.common.utils.OAuthUtils;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.RequestToken;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.BaseModel;
import egovframework.common.base.model.Messages;
import egovframework.common.base.model.OauthProvider;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.ggportal.user.service.PortalOauthService;
import egovframework.portal.model.User;

/**
 * 사용자 인증을 처리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOauthService")
public class PortalOauthServiceImpl extends BaseService implements PortalOauthService  {
    /**
     * 사용자 정보를 관리하는 DAO
     */
    @Resource(name="ggportalUserDao")
    private PortalUserDao portalUserDao;
    
    /**
     * 사용자 로그인 이력을 관리하는 DAO
     */
    @Resource(name="ggportalLogUserDao")
    private PortalLogUserDao portalLogUserDao;
    
    /**
     * 사용자 이용약관 동의여부 이력을 관리하는 DAO
     */
    @Resource(name="ggportalLogUserAgreeDao")
    private PortalLogUserAgreeDao portalLogUserAgreeDao;
    
    /**
     * 인증 제공자를 반환한다.
     * 
     * @param params 파라메터
     * @return 인증 제공자
     */
    private OauthProvider getProvider(Params params) {
        String name = params.getString("providerName");
        
        OauthProvider provider = new OauthProvider();
        try{
		    if ("".equals(name)) {
		        throw new ServiceException("portal.error.000008", getMessage("portal.error.000008"));
		    }
		    
		    String prefix = "Oauth2.Provider." + name.substring(0, 1).toUpperCase() + name.substring(1) + ".";
		    
		    provider.put(OauthProvider.PROVIDER_CODE,   getProperty(prefix + OauthProvider.PROVIDER_CODE,   ""));
		    provider.put(OauthProvider.PROVIDER_NAME,   getProperty(prefix + OauthProvider.PROVIDER_NAME,   ""));
		    provider.put(OauthProvider.PROVIDER_DESC,   getProperty(prefix + OauthProvider.PROVIDER_DESC,   ""));
		    provider.put(OauthProvider.AUTH_ENDPOINT,   getProperty(prefix + OauthProvider.AUTH_ENDPOINT,   ""));
		    provider.put(OauthProvider.TOKEN_ENDPOINT,  getProperty(prefix + OauthProvider.TOKEN_ENDPOINT,  ""));
		    provider.put(OauthProvider.CLIENT_ID,       getProperty(prefix + OauthProvider.CLIENT_ID,       ""));
		    provider.put(OauthProvider.SECRET_REQUIRED, getProperty(prefix + OauthProvider.SECRET_REQUIRED, ""));
		    provider.put(OauthProvider.CLIENT_SECRET,   getProperty(prefix + OauthProvider.CLIENT_SECRET,   ""));
		    provider.put(OauthProvider.REDIRECT_URI,    getProperty(prefix + OauthProvider.REDIRECT_URI,    ""));
		    provider.put(OauthProvider.SCOPE_REQUIRED,  getProperty(prefix + OauthProvider.SCOPE_REQUIRED,  ""));
		    provider.put(OauthProvider.SCOPE,           getProperty(prefix + OauthProvider.SCOPE,           ""));
		    provider.put(OauthProvider.STATE_REQUIRED,  getProperty(prefix + OauthProvider.STATE_REQUIRED,  ""));
		    provider.put(OauthProvider.REQUEST_TYPE,    getProperty(prefix + OauthProvider.REQUEST_TYPE,    ""));
		    provider.put(OauthProvider.REQUEST_METHOD,  getProperty(prefix + OauthProvider.REQUEST_METHOD,  ""));
		    provider.put(OauthProvider.PROFILE_URL,     getProperty(prefix + OauthProvider.PROFILE_URL,     ""));
		    provider.put(OauthProvider.REVOKE_TYPE,     getProperty(prefix + OauthProvider.REVOKE_TYPE,     ""));
		    provider.put(OauthProvider.REVOKE_METHOD,   getProperty(prefix + OauthProvider.REVOKE_METHOD,   ""));
		    provider.put(OauthProvider.REVOKE_URL,      getProperty(prefix + OauthProvider.REVOKE_URL,      ""));
		    provider.put(OauthProvider.REVOKE_ARGS,     getProperty(prefix + OauthProvider.REVOKE_ARGS,     ""));
		    
		    if ("".equals(provider.getProviderCode())) {
		        throw new ServiceException("portal.error.000009", getMessage("portal.error.000009", new String[] {
		            name
		        }));
		    }
		    if ("".equals(provider.getProviderName())) {
		        throw new ServiceException("portal.error.000009", getMessage("portal.error.000009", new String[] {
		            name
		        }));
		    }
		    if ("".equals(provider.getProviderDesc())) {
		        throw new ServiceException("portal.error.000009", getMessage("portal.error.000009", new String[] {
		            name
		        }));
		    }
		    if ("".equals(provider.getAuthEndpoint())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.AUTH_ENDPOINT
		        }));
		    }
		    if ("".equals(provider.getTokenEndpoint())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.TOKEN_ENDPOINT
		        }));
		    }
		    if ("".equals(provider.getClientId())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.CLIENT_ID
		        }));
		    }
		    if (provider.getSecretRequired() && "".equals(provider.getClientSecret())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.CLIENT_SECRET
		        }));
		    }
		    if ("".equals(provider.getRedirectUri())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.REDIRECT_URI
		        }));
		    }
		    if (provider.getScopeRequired() && "".equals(provider.getScope())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.SCOPE
		        }));
		    }
		    if ("".equals(provider.getRequestType())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.REQUEST_TYPE
		        }));
		    }
		    if ("".equals(provider.getRequestMethod())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.REQUEST_METHOD
		        }));
		    }
		    if ("".equals(provider.getProfileUrl())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.PROFILE_URL
		        }));
		    }
		    if ("".equals(provider.getRevokeType())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.REVOKE_TYPE
		        }));
		    }
		    if ("".equals(provider.getRevokeMethod())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.REVOKE_METHOD
		        }));
		    }
		    if ("".equals(provider.getRevokeUrl())) {
		        throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		            provider.getProviderName(),
		            OauthProvider.REVOKE_URL
		        }));
		    }
		    // if ("".equals(provider.getRevokeArgs())) {
		    //     throw new SystemException("portal.error.000010", getMessage("portal.error.000010", new String[] {
		    //         provider.getProviderName(),
		    //         OauthProvider.REVOKE_ARGS
		    //     }));
		    // }
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        
        return provider;
    }
    
    /**
     * 상태 토큰을 반환한다.
     * 
     * @return 상태 토큰
     */
    private String getState() {
        String state = (String) getSession().getAttribute(SessionAttribute.STATE);
        
        if (state == null) {
            SecureRandom random = new SecureRandom();
            
            state = new BigInteger(130, random).toString(32);
            
            getSession().setAttribute(SessionAttribute.STATE, state);
        }
        
        return state;
    }
    
    /**
     * 폐기 요청 URL을 반환한다.
     * 
     * @param params 파라메터
     * @param provider 제공자
     * @return 폐기 요청 URL
     */
    private String getRevokeUrl(Params params, OauthProvider provider) {
        StringBuffer buffer = new StringBuffer();
        
        if (OauthProvider.REVOKE_TYPE_QUERY.equals(provider.getRevokeType())) {
            String[] arguments = provider.getRevokeArgs().split(",");
            
            Map<String, Object> parameters = new HashMap<String, Object>();
            
            for (int i = 0; i < arguments.length; i++) {
                String name = arguments[i].trim();
                
                if (!"".equals(name)) {
                    parameters.put(name, getRevokeArg(name, params, provider));
                }
            }
            
            buffer.append(provider.getRevokeUrl());
            
            if (parameters.size() > 0) {
                if (provider.getRevokeUrl().contains("?")) {
                    buffer.append("&");
                }
                else {
                    buffer.append("?");
                }
                
                buffer.append(OAuthUtils.format(parameters.entrySet(), "UTF-8"));
            }
        }
        else if (OauthProvider.REVOKE_TYPE_RESTFUL.equals(provider.getRevokeType())) {
            String[] arguments = provider.getRevokeArgs().split(",");
            
            List<String> parameters = new ArrayList<String>();
            
            for (int i = 0; i < arguments.length; i++) {
                String name = arguments[i].trim();
                
                if (!"".equals(name)) {
                    parameters.add(getRevokeArg(name, params, provider));
                }
            }
            
            if (parameters.size() > 0) {
                buffer.append(MessageFormat.format(provider.getRevokeUrl(), parameters.toArray()));
            }
            else {
                buffer.append(provider.getRevokeUrl());
            }
        }
        else {
            buffer.append(provider.getRevokeUrl());
        }
        
        return buffer.toString();
    }
    
    /**
     * 폐기 요청 인자를 반환한다.
     * 
     * @param name 이름
     * @param params 파라메터
     * @return 폐기 요청 인자
     */
    private Map<String, Object> getRevokeArgs(Params params, OauthProvider provider) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        
        if (OauthProvider.REVOKE_TYPE_SCRIPT.equals(provider.getRevokeType())) {
            String[] arguments = provider.getRevokeArgs().split(",");
            
            for (int i = 0; i < arguments.length; i++) {
                String name = arguments[i].trim();
                
                if (!"".equals(name)) {
                    parameters.put(name,  getRevokeArg(name, params, provider));
                }
            }
        }
        
        return parameters;
    }
    
    /**
     * 폐기 요청 인자를 반환한다.
     * 
     * @param name 이름
     * @param params 파라메터
     * @return 폐기 요청 인자
     */
    private String getRevokeArg(String name, Params params, OauthProvider provider) {
        if ("grant_type".equals(name)) {
            return "delete";
        }
        else if ("client_id".equals(name)) {
            return provider.getClientId();
        }
        else if ("client_secret".equals(name)) {
            return provider.getClientSecret();
        }
        else if ("token".equals(name)) {
            return params.getString("accessToken");
        }
        else if ("access_token".equals(name)) {
            return params.getString("accessToken");
        }
        else if ("authenticity_token".equals(name)) {
            return params.getString("accessToken");
        }
        else if ("service_provider".equals(name)) {
            return provider.getProviderName().toUpperCase();
        }
        else if ("user_id".equals(name)) {
            return (String) getSession().getAttribute(SessionAttribute.USER_ID);
        }
        else if ("url".equals(name)) {
            return "";
        }
        
        return "";
    }
    
    /**
     * 접근 토큰을 요청한다.
     * 
     * @param params 파라메터
     * @param provider 제공자
     * @return 요청결과
     */
    private Result token(HttpServletRequest request, Params params, OauthProvider provider) {
        try {
            // 트위터인 경우
            if (OauthProvider.TWITTER.equals(provider.getProviderName())) {
                HttpSession session = getSession();
                
                log.debug("testgm="+session.getAttribute("testgm"));
                Twitter twitter = (Twitter) session.getAttribute(SessionAttribute.TWITTER);
                
                RequestToken requestT = (RequestToken) session.getAttribute(SessionAttribute.REQUEST_TOKEN);
                
                String verifier = params.getString("oauth_verifier");
                
                twitter.getOAuthAccessToken(requestT, verifier);
                
                session.removeAttribute(SessionAttribute.REQUEST_TOKEN);
            }
            // 트위터가 아닌 경우
            else {
                // 접근 토큰 요청을 설정한다.
                TokenRequestBuilder builder = OAuthClientRequest.tokenLocation(provider.getTokenEndpoint());
                log.debug(provider.getClientId());
                log.debug(provider.getRedirectUri());
                log.debug(GrantType.AUTHORIZATION_CODE);
                log.debug(params.getString("code"));
                builder.setClientId(provider.getClientId());
                builder.setRedirectURI(provider.getRedirectUri());
                builder.setGrantType(GrantType.AUTHORIZATION_CODE);
                builder.setCode(params.getString("code"));
                
                if (provider.getSecretRequired()) {
                    builder.setClientSecret(provider.getClientSecret());
                }
                if (provider.getStateRequired()) {
                    builder.setParameter("state", getState());
                }
                
                // 접근 토큰 요청을 생성한다.
                OAuthClientRequest requestT = builder.buildBodyMessage();
                
                OAuthClient client = new OAuthClient(new URLConnectionClient());
                
                // 접근 토큰 요청을 전송한다.
                OAuthAccessTokenResponse response = client.accessToken(requestT, OAuthJSONAccessTokenResponse.class);
                
                params.put("accessToken", response.getAccessToken());
                
                if ("".equals(params.getString("accessToken"))) {
                    throw new SystemException("portal.error.000012", getMessage("portal.error.000012", new String[] {
                        provider.getProviderName()
                    }));
                }
            }
            
            // 사용자 프로파일을 요청한다.
            return profile(request, params, provider);
        }
        catch (TwitterException te) {
            error("Detected exception: ", te);
            
            //throw new SystemException("portal.error.000002", te.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
        catch (OAuthSystemException oase) {
            error("Detected exception: ", oase);
            
            //throw new SystemException("portal.error.000002", oase.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
        catch (OAuthProblemException oape) {
            error("Detected exception: ", oape);
            
            //throw new SystemException("portal.error.000002", oape.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
        finally {
            getSession().removeAttribute(SessionAttribute.STATE);
        }
    }
    
    /**
     * 사용자 프로파일을 요청한다.
     * 
     * @param params 파라메터
     * @param provider 제공자
     * @return 요청결과
     */
    private Result profile(HttpServletRequest request, Params params, OauthProvider provider) {
        try {
            // 트위터인 경우
            if (OauthProvider.TWITTER.equals(provider.getProviderName())) {
                // 로그인을 처리한다.
                return profileAction(request, params, provider);
            }
            else {
                // 사용자 프로파일 요청을 설정한다.
                OAuthBearerClientRequest builder = new OAuthBearerClientRequest(provider.getProfileUrl());
                
                builder.setAccessToken(params.getString("accessToken"));
                
                // 사용자 프로파일 요청을 생성한다.
                OAuthClientRequest oArequest = null;
                
                // 헤더
                if (OauthProvider.REQUEST_TYPE_HEADER.equals(provider.getRequestType())) {
                	oArequest = builder.buildHeaderMessage();
                }
                // 쿼리
                else if (OauthProvider.REQUEST_TYPE_QUERY.equals(provider.getRequestType())) {
                	oArequest = builder.buildQueryMessage();
                }
                // 바디
                else if (OauthProvider.REQUEST_TYPE_BODY.equals(provider.getRequestType())) {
                	oArequest = builder.buildBodyMessage();
                }
                // 기타
                else {
                    throw new SystemException("portal.error.000013", getMessage("portal.error.000013", new String[] {
                        provider.getProviderName(),
                        OauthProvider.REQUEST_TYPE
                    }));
                }
                
                OAuthClient client = new OAuthClient(new URLConnectionClient());
                
                // 사용자 프로파일 요청을 전송한다.
                OAuthResourceResponse response = client.resource(oArequest, provider.getRequestMethod(), OAuthResourceResponse.class);
                
                if (response.getResponseCode() == 200) {
                    debug("Authorized results: " + response.getBody());
                    
                    params.put("responseBody", response.getBody());
                    
                    // 로그인을 처리한다.
                    return profileAction(request, params, provider);
                }
                else {
                    error("Detected exception: " + response.getBody());
                    
                    throw new SystemException("portal.error.000002", response.getBody());
                }
            }
        }
        catch (OAuthSystemException oase) {
            error("Detected exception: ", oase);
            
           // throw new SystemException("portal.error.000002", oase.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
        catch (OAuthProblemException oape) {
            error("Detected exception: ", oape);
            
            //throw new SystemException("portal.error.000002", oape.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
    }
    
    /**
     * 로그인을 처리한다.
     * 
     * @param params 파라메터
     * @param provider 제공자
     * @return 처리결과
     */
    private Result profileAction(HttpServletRequest request, Params params, OauthProvider provider) {
        // 응답을 분석한다.
        parse(params, provider);
        
        // 사용자 코드가 있는 경우
        if (params.containsKey(Params.USER_CD)) {
            params.remove(Params.USER_CD);
        }
        
        // 사용자 정보를 조회한다.
        Record user = portalUserDao.selectUser(params);
        
        // 사용자 정보가 없는 경우
        if (user == null) {
            // 세션을 생성한다.
            session(request, params, provider);
        }
        // 사용자 정보가 있는 경우
        else {
            // 사용자 로그인 이력을 등록한다.
            portalLogUserDao.insertLogUser(params);
            
            // 세션을 생성한다.
            session(request, user, provider);
        }
        
        // 폐지를 요청한다.
        revoke(params, provider);
        
        return success(getMessage("portal.message.000007"));
    }
    
    /**
     * 응답을 분석한다.
     * 
     * @param params 파라메터
     * @param provider 제공자
     */
    private void parse(Params params, OauthProvider provider) {
        try {
            // 트위터인 경우
            if (OauthProvider.TWITTER.equals(provider.getProviderName())) {
                HttpSession session = getSession();
                
                Twitter twitter = (Twitter) session.getAttribute(SessionAttribute.TWITTER);
                
                twitter4j.User user = twitter.verifyCredentials();
                
                params.put("contSiteCd", provider.getProviderCode());
                params.put("userId",     String.valueOf(user.getId()));
                params.put("userNm",     user.getName());
                params.put("userEmail",  "");
            }
            // 트위터가 아닌 경우
            else {
                JSONObject response = (JSONObject) JSONValue.parse(params.getString("responseBody"));
                
                // 네이버인 경우
                if (response.containsKey("response")) {
                    Object value = response.get("response");
                    
                    if (value instanceof JSONObject) {
                        response = (JSONObject) value;
                    }
                }
                // 다음인 경우
                else if (response.containsKey("result")) {
                    Object value = response.get("result");
                    
                    if (value instanceof JSONObject) {
                        response = (JSONObject) value;
                    }
                }
                
                params.put("contSiteCd", provider.getProviderCode());
                params.put("userId",     response.get("id").toString());
                
                // 카카오톡인 경우
                if (response.containsKey("properties")) {
                    Object value = response.get("properties");
                    
                    if (value instanceof JSONObject) {
                        response = (JSONObject) value;
                    }
                }
                
                if (response.containsKey("name")) {
                    params.put("userNm", response.get("name").toString());
                }
                
                if (response.containsKey("email")) {
                    params.put("userEmail", response.get("email").toString());
                }
            }
            
            if ("".equals(params.getString("userId"))) {
                throw new SystemException("portal.error.000062", getMessage("portal.error.000062", new String[] {
                    provider.getProviderName()
                }));
            }
        }
        catch (TwitterException te) {
            error("Detected exception: ", te);
            
            //throw new SystemException("portal.error.000002", te.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
    }
    
    /**
     * 세션을 생성한다.
     * 
     * @param model 모델
     * @param provider 제공자
     */
    private void session(HttpServletRequest request, BaseModel model, OauthProvider provider) {
        User user = new User();
        
        user.setUserCd(model.getInt("userCd"));
        user.setUserId(model.getString("userId"));
        user.setUserNm(model.getString("userNm"));
        user.setUserEmail(model.getString("userEmail"));
        user.setUserTel(model.getString("userTel"));
        user.setAgreeYn(model.getString("agreeYn"));
        user.setAccIp(model.getString("accIp"));
        
        if (!"".equals(user.getUserEmail())) {
            String[] tokens = user.getUserEmail().split("@");
            
            if (tokens.length == 2) {
                user.setUserEmailSplit1(tokens[0]);
                user.setUserEmailSplit2(tokens[1]);
            }
        }
        if (!"".equals(user.getUserTel())) {
            String[] tokens = user.getUserTel().split("-");
            
            if (tokens.length == 3) {
                user.setUserTelSplit1(tokens[0]);
                user.setUserTelSplit2(tokens[1]);
                user.setUserTelSplit3(tokens[2]);
            }
        }
        
        HttpSession oldSession = getSession(false);
        
        if (oldSession != null) {
            oldSession.invalidate();
        }
        
        HttpSession newSession = getSession(true);
        
        newSession.setAttribute(SessionAttribute.USER,          user);
        newSession.setAttribute(SessionAttribute.USER_CD,       user.getUserCd());
        newSession.setAttribute(SessionAttribute.USER_ID,       user.getUserId());
        newSession.setAttribute(SessionAttribute.USER_NM,       user.getUserNm());
        newSession.setAttribute(SessionAttribute.USER_EMAIL,    user.getUserEmail());
        newSession.setAttribute(SessionAttribute.USER_TEL,      user.getUserTel());
        newSession.setAttribute(SessionAttribute.AGREE_YN,      user.getAgreeYn());
        newSession.setAttribute(SessionAttribute.CONT_SITE_CD,  provider.getProviderCode());
        newSession.setAttribute(SessionAttribute.CONT_SITE_NM,  provider.getProviderDesc());
        newSession.setAttribute(SessionAttribute.PROVIDER_NAME, provider.getProviderName().toLowerCase());
        newSession.setAttribute(SessionAttribute.IS_ADMIN,      user.getAgreeYn());
    }
    
    /**
     * 폐지를 요청한다.
     * 
     * @param params 파라메터
     * @param provider 제공자
     */
    private void revoke(Params params, OauthProvider provider) {
        try {
            // 트위터인 경우
            if (OauthProvider.TWITTER.equals(provider.getProviderName())) {
                // Nothing to do.
            }
            // 트위터가 아닌 경우
            else {
                if (OauthProvider.REVOKE_TYPE_SCRIPT.equals(provider.getRevokeType())) {
                    getRequest().setAttribute(RequestAttribute.REVOKE_TYPE,   provider.getRevokeType());
                    getRequest().setAttribute(RequestAttribute.REVOKE_METHOD, provider.getRevokeMethod());
                    getRequest().setAttribute(RequestAttribute.REVOKE_URL,    getRevokeUrl(params, provider));
                    getRequest().setAttribute(RequestAttribute.REVOKE_ARGS,   getRevokeArgs(params, provider));
                }
                else {
                    // 폐기 요청을 설정한다.
                    OAuthBearerClientRequest builder = new OAuthBearerClientRequest(getRevokeUrl(params, provider));
                    
                    // 폐기 요청을 생성한다.
                    OAuthClientRequest request = null;
                    
                    // 헤더
                    if (OauthProvider.REVOKE_TYPE_HEADER.equals(provider.getRevokeType())) {
                        builder.setAccessToken(params.getString("accessToken"));
                        
                        request = builder.buildHeaderMessage();
                    }
                    // 쿼리
                    else if (OauthProvider.REVOKE_TYPE_QUERY.equals(provider.getRevokeType())) {
                        request = builder.buildQueryMessage();
                    }
                    // RESTful
                    else if (OauthProvider.REVOKE_TYPE_RESTFUL.equals(provider.getRevokeType())) {
                        request = builder.buildQueryMessage();
                    }
                    // 기타
                    else {
                        throw new SystemException("portal.error.000013", getMessage("portal.error.000013", new String[] {
                            provider.getProviderName(),
                            OauthProvider.REVOKE_TYPE
                        }));
                    }
                    
                    OAuthClient client = new OAuthClient(new URLConnectionClient());
                    
                    // 폐기 요청을 전송한다.
                    OAuthResourceResponse response = client.resource(request, provider.getRevokeMethod(), OAuthResourceResponse.class);
                    
                    if (response.getResponseCode() == 200) {
                        debug("Revoked results: " + response.getBody());
                    }
                    else {
                        error("Detected exception: " + response.getBody());
                        
                        throw new SystemException("portal.error.000002", response.getBody());
                    }
                }
            }
        }
        catch (OAuthSystemException oase) {
            error("Detected exception: ", oase);
            
            //throw new SystemException("portal.error.000002", oase.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
        catch (OAuthProblemException oape) {
            error("Detected exception: ", oape);
            
            //throw new SystemException("portal.error.000002", oape.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
    }
    
    /**
     * 제공자를 반환한다.
     * 
     * @param params 파라메터
     * @return 제공자
     */
    public List<OauthProvider> providers(Params params) {
        List<OauthProvider> providers = new ArrayList<OauthProvider>();
        
        for (int i = 0; i < OauthProvider.providerNames.size(); i++) {
            params.put("providerName", OauthProvider.providerNames.get(i).toLowerCase());
            
            OauthProvider provider = getProvider(params);
            
            provider.put(OauthProvider.REVOKE_ARGS, getRevokeArgs(params, provider));
            
            providers.add(provider);
        }
        
        return providers;
    }
    
    /**
     * 인증을 요청한다.
     * 
     * @param params 파라메터
     * @return 요청결과
     */
    public Result authorize(Params params) {
        try {
            // 인증 제공자를 가져온다.
            OauthProvider provider = getProvider(params);
            
            Messages messages = new Messages();
            
            // 트위터인 경우
            if (OauthProvider.TWITTER.equals(provider.getProviderName())) {
                Twitter twitter = new TwitterFactory().getInstance();
                
                twitter.setOAuthConsumer(provider.getClientId(), provider.getClientSecret());
                
                RequestToken token = twitter.getOAuthRequestToken(provider.getRedirectUri());
                
                HttpSession session = getSession();
                
                session.setAttribute(SessionAttribute.TWITTER,       twitter);
                session.setAttribute(SessionAttribute.REQUEST_TOKEN, token);
                session.setAttribute("testgm", "11111");
                
                messages.put("authEndpoint", token.getAuthenticationURL() + "&force_login=true");
            }
            // 트위터가 아닌 경우
            else {
                // 인증 요청을 설정한다.
                AuthenticationRequestBuilder builder = OAuthClientRequest.authorizationLocation(provider.getAuthEndpoint());
                
                builder.setClientId(provider.getClientId());
                builder.setRedirectURI(provider.getRedirectUri());
                builder.setResponseType(ResponseType.CODE != null?ResponseType.CODE.toString():"");
                
                if (provider.getScopeRequired()) {
                    builder.setScope(provider.getScope());
                }
                if (provider.getStateRequired()) {
                    builder.setState(getState());
                }
                
                // 인증 요청을 생성한다.
                OAuthClientRequest request = builder.buildQueryMessage();
                
                messages.put("authEndpoint", request.getLocationUri());
            }
            
            return success(messages);
        }
        catch (TwitterException te) {
            error("Detected exception: ", te);
            
            //throw new SystemException("portal.error.000002", te.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
        catch (OAuthSystemException oase) {
            error("Detected exception: ", oase);
            
            //throw new SystemException("portal.error.000002", oase.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
    }
    
    /**
     * 리다이렉트를 처리한다.
     * 
     * @param params 파라메터
     * @return 처리결과 
     */
    public Result redirectCUD(HttpServletRequest request, Params params) {
        try {
            // 인증 제공자를 가져온다.
            OauthProvider provider = getProvider(params);
            
            // 트위터인 경우
            if (OauthProvider.TWITTER.equals(provider.getProviderName())) {
                // Nothing to do.
            }
            // 트위터가 아닌 경우
            else {
                // 인증 코드를 가져온다.
                OAuthAuthzResponse response = OAuthAuthzResponse.oauthCodeAuthzResponse(getRequest());
                
                params.put("code", response.getCode());
                
                if ("".equals(params.getString("code"))) {
                    throw new SystemException("portal.error.000011", getMessage("portal.error.000011", new String[] {
                        provider.getProviderName()
                    }));
                }
            }
            
            // 접근 토큰을 요청한다.
            return token(request, params, provider);
        }
        catch (OAuthProblemException oape) {
            error("Detected exception: ", oape);
            
            //throw new SystemException("portal.error.000002", oape.getMessage());
            throw new SystemException("portal.error.000002", getMessage("portal.error.000002"));
        }
    }
    
    /**
     * 사용자를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Result registerCUD(HttpServletRequest request, Params params) {
        // 인증 제공자를 가져온다.
        OauthProvider provider = getProvider(params);
        try{
	        // 접속 계정 코드가 없는 경우
	        if ("".equals(params.getString("contSiteCd"))) {
	            throw new ServiceException("portal.error.000052", getMessage("portal.error.000052"));
	        }
	        // 사용자 아이디가 없는 경우
	        if ("".equals(params.getString("userId"))) {
	            throw new ServiceException("portal.error.000053", getMessage("portal.error.000053"));
	        }
	        // 사용자 이름이 없는 경우
	        if ("".equals(params.getString("userNm"))) {
	            throw new ServiceException("portal.error.000054", getMessage("portal.error.000054"));
	        }
	        // // 사용자 이메일이 없는 경우
	        // if ("".equals(params.getString("userEmail1"))) {
	        //     throw new ServiceException("portal.error.000055", getMessage("portal.error.000055"));
	        // }
	        // // 사용자 이메일이 없는 경우
	        // if ("".equals(params.getString("userEmail2"))) {
	        //     throw new ServiceException("portal.error.000055", getMessage("portal.error.000055"));
	        // }
	        // 개인정보 이용약관에 동의하지 않은 경우
	        if (!"Y".equals(params.getString("agree1Yn"))) {
	            throw new ServiceException("portal.error.000056", getMessage("portal.error.000056"));
	        }
	        // 서비스 이용약관에 동의하지 않은 경우
	        if (!"Y".equals(params.getString("agree2Yn"))) {
	            throw new ServiceException("portal.error.000057", getMessage("portal.error.000057"));
	        }
	        
	        // 사용자 코드가 있는 경우
	        if (params.containsKey(Params.USER_CD)) {
	            params.remove(Params.USER_CD);
	        }
	        
	        // 사용자 정보를 조회한다.
	        Record user = portalUserDao.selectUser(params);
	        
	        // 사용자 정보가 없는 경우
	        if (user == null) {
	            // 사용자 정보를 등록한다.
	            portalUserDao.insertUser(params);
	            
	            // 사용자 로그인 이력을 등록한다.
	            portalLogUserDao.insertLogUser(params);
	        }
	        // 사용자 정보가 있는 경우
	        else {
	            // 사용자 정보를 수정한다.
	            portalUserDao.updateUser(params);
	        }
	        
	        // 사용자 정보를 조회한다.
	        user = portalUserDao.selectUser(params);
	        
	        // 사용자 이용약관 동의여부 이력을 등록한다.
	        portalLogUserAgreeDao.insertLogUserAgree(params);
	        
	        // 세션을 생성한다.
	        session(request, user, provider);
	        
        } catch (DataAccessException dae) {
        	EgovWebUtil.exTransactionLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        
        return success(getMessage("portal.message.000003"));
    }
    
    /**
     * 로그아웃을 처리한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
    public Result logout(Params params) {
        HttpSession session = getSession(false);
        
        if (session != null) {
            session.invalidate();
        }
        
        return success(getMessage("portal.message.000007"));
    }
}