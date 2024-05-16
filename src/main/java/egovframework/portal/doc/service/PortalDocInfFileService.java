package egovframework.portal.doc.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalDocInfFileService {

	List<Record> searchDocInfFile(Params params);
	
	Record selectDocInfFileCUD(Params params);
}
