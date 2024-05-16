package egovframework.portal.doc.service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalDocInfService {
	/**
     * 파일 서비스 유형
     */
    public static final String SERVICE_TYPE_FILE = "F";

	public Record selectDocInfMeta(Params params);
	
	public Record insertDocInfAppr(Params params);
	
}
