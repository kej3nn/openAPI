package egovframework.soportal.stat.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.common.base.model.Params;

public interface StatPortalDownService {
	void portalDown2Excel(HttpServletRequest request, HttpServletResponse response, Params params) ;
	
	void portalDown2Text(HttpServletRequest request, HttpServletResponse response, Params params) ;
	
	void portalDown2Csv(HttpServletRequest request, HttpServletResponse response, Params params) ;
	
	void portalDown2Xml(HttpServletRequest request, HttpServletResponse response, Params params) ;
	
	void portalDown2Json(HttpServletRequest request, HttpServletResponse response, Params params) ;
	
	void portalDown2Hwp(HttpServletRequest request, Params params) ;
}
