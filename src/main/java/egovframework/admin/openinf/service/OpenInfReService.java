package egovframework.admin.openinf.service;

import java.util.ArrayList;
import java.util.List;


public interface OpenInfReService {
    public List<OpenInfRe> openInfReListAll(OpenInfRe openInfRe);

    public int updateOpenInfReCUD(ArrayList<OpenInfRe> list);
}
