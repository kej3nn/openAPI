package egovframework.admin.openinf.service;

import java.util.List;
import java.util.Map;

public interface OpenInfPrssService {

    public Map<String, Object> selectOpenInfPrssListAllIbPaging(OpenInf OpenInf);

    public List<OpenInf> selectOpenInfPrssDtl(OpenInf OpenInf);

    public int openInfPrssRegCUD(OpenInf saveVO, String status);

    public Map<String, Object> selectOpenInfPrssLogIbPaging(OpenInf OpenInf);
}
