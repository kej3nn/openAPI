package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenInfRe;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("OpenInfReDAO")
public class OpenInfReDAO extends EgovComAbstractDAO {
    @SuppressWarnings("unchecked")
    public List<OpenInfRe> openInfReListAll(OpenInfRe openInfRe) throws DataAccessException, Exception {
        return (List<OpenInfRe>) list("OpenInfReDao.openInfReListAll", openInfRe);
    }

    public int updateOpenInfRe(OpenInfRe openInfRe) throws DataAccessException, Exception {
        return update("OpenInfReDao.updateOpenInfRe", openInfRe);
    }
}
