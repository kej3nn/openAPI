package egovframework.admin.service.service.impl.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibatis.sqlmap.client.event.RowHandler;

import egovframework.admin.service.service.OpenInfScol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.impl.OpenInfScolDAO;
import egovframework.common.util.UtilString;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public class OpenInfRowHandler implements RowHandler {

    private static final Logger logger = Logger.getLogger(OpenInfRowHandler.class);

    @Override
    public void handleRow(Object arg0) {
        LinkedHashMap<String, ?> map = (LinkedHashMap<String, ?>) arg0;
        //다운로드시에만 사용한다.

    }
}