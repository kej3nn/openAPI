package egovframework.admin.expose.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;

public interface AdminNasSendInfoService {

    public boolean exposeProcSend(HttpServletRequest request, Params params);

    public void cancelProcSend(HttpServletRequest request, Params params);

}
