package egovframework.com.cmm.web;

/*
 * Copyright 2001-2006 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the ";License&quot;);
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS"; BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.fileupload.FileItem;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.BaseException;
import egovframework.common.base.exception.ServiceException;

/**
 * 실행환경의 파일업로드 처리를 위한 기능 클래스
 *
 * @author 공통서비스개발팀 이삼섭
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.25  이삼섭          최초 생성
 *   2011.06.11 서준식          스프링 3.0 업그레이드 API변경으로인한 수정
 *
 * </pre>
 * @since 2009.06.01
 */
public class EgovMultipartResolver extends CommonsMultipartResolver {
    public EgovMultipartResolver() {
    }


    /**
     * 첨부파일 처리를 위한 multipart resolver를 생성한다.
     *
     * @param servletContext
     */
    public EgovMultipartResolver(ServletContext servletContext) {
        super(servletContext);
    }

    /**
     * multipart에 대한 parsing을 처리한다.
     */
    @SuppressWarnings("unchecked")
    @Override
    protected MultipartParsingResult parseFileItems(List<FileItem> fileItems, String encoding) {
    	/*
    //스프링 3.0변경으로 수정한 부분
    MultiValueMap<String, MultipartFile> multipartFiles = new LinkedMultiValueMap<String, MultipartFile>();
	Map<String, String[]> multipartParameters = new HashMap<String, String[]>();

	// Extract multipart files and multipart parameters.
	for (Iterator it = fileItems.iterator(); it.hasNext();) {
	    FileItem fileItem = (FileItem)it.next();

	    if (fileItem.isFormField()) {

		String value = null;
		if (encoding != null) {
		    try {
			value = fileItem.getString(encoding);
		    } catch (UnsupportedEncodingException ex) {
			if (logger.isWarnEnabled()) {
			    logger.warn("Could not decode multipart item '" + fileItem.getFieldName() + "' with encoding '" + encoding
				    + "': using platform default");
			}
			value = fileItem.getString();
		    }
		} else {
		    value = fileItem.getString();
		}
		String[] curParam = (String[])multipartParameters.get(fileItem.getFieldName());
		if (curParam == null) {
		    // simple form field
		    multipartParameters.put(fileItem.getFieldName(), new String[] { value });
		} else {
		    // array of simple form fields
		    String[] newParam = StringUtils.addStringToArray(curParam, value);
		    multipartParameters.put(fileItem.getFieldName(), newParam);
		}
	    } else {

		if (fileItem.getSize() > 0) {
		    // multipart file field
		    CommonsMultipartFile file = new CommonsMultipartFile(fileItem);
		    
		
		    //스프링 3.0 업그레이드 API변경으로인한 수정
		    List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		    fileList.add(file);
		    
		    
		    if (multipartFiles.put(fileItem.getName(), fileList) != null) { // CHANGED!!
			throw new MultipartException("Multiple files for field name [" + file.getName()
				+ "] found - not supported by MultipartResolver");
		    }
		    if (logger.isDebugEnabled()) {
			logger.debug("Found multipart file [" + file.getName() + "] of size " + file.getSize() + " bytes with original filename ["
				+ file.getOriginalFilename() + "], stored " + file.getStorageDescription());
		    }
		}

	    }
	}
	
	return new MultipartParsingResult(multipartFiles, multipartParameters);
	*/
        /**
         * hsJ 추가.. 확장자 체크 부분 추가위해
         */
        MultiValueMap<String, MultipartFile> multipartFiles = new LinkedMultiValueMap<String, MultipartFile>();
        Map<String, String[]> multipartParameters = new HashMap<String, String[]>();

        // Extract multipart files and multipart parameters.
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {
                String value;
                String partEncoding = determineEncoding(fileItem.getContentType(), encoding);
                if (partEncoding != null) {
                    try {
                        value = fileItem.getString(partEncoding);
                    } catch (UnsupportedEncodingException ex) {
                        if (logger.isWarnEnabled()) {
                            logger.warn("Could not decode multipart item '" + fileItem.getFieldName() + "' with encoding '" + partEncoding + "': using platform default");
                        }
                        value = fileItem.getString();
                    }
                } else {
                    value = fileItem.getString();
                }
                String[] curParam = multipartParameters.get(fileItem.getFieldName());
                if (curParam == null) {
                    // simple form field
                    multipartParameters.put(fileItem.getFieldName(), new String[]{value});
                } else {
                    // array of simple form fields
                    String[] newParam = StringUtils.addStringToArray(curParam, value);
                    multipartParameters.put(fileItem.getFieldName(), newParam);
                }
            } else {
                // multipart file field
                CommonsMultipartFile file = new CommonsMultipartFile(fileItem);
                checkFileExtension(file.getOriginalFilename());
                multipartFiles.add(file.getName(), file);
                if (logger.isDebugEnabled()) {
                    logger.debug("Found multipart file [" + file.getName() + "] of size " + file.getSize() +
                            " bytes with original filename [" + file.getOriginalFilename() + "], stored " +
                            file.getStorageDescription());
                }
            }
        }
        return new MultipartParsingResult(multipartFiles, multipartParameters, null);
    }

    private String determineEncoding(String contentTypeHeader, String defaultEncoding) {
        if (!StringUtils.hasText(contentTypeHeader)) {
            return defaultEncoding;
        }
        MediaType contentType = MediaType.parseMediaType(contentTypeHeader);
        Charset charset = contentType.getCharSet();
        return charset != null ? charset.name() : defaultEncoding;
    }

    private static String[] exts = new String[]{
            "doc", "docx", "hwp", "pdf", "ppt", "pptx", "txt", "xls", "xlsx", "csv"                            // 문서
            , "bmp", "gif", "ief", "jpe", "jpeg", "jpg", "png", "tif", "tiff"                                // 이미지
            , "zip", "tar"                                                                            // 압축
            , "avi", "mp4", "wmv", "mpg", "mpeg", "mov", "mkv"                                        // 동영상
    };

    private void checkFileExtension(String fileName) {
        try {
            if (fileName != null && !"".equals(fileName)) {
                int idx = fileName.lastIndexOf(".");
                if (idx > -1) {
                    String _ext = fileName.substring(idx + 1).toLowerCase();
                    boolean chk = false;
                    for (String ext : exts) {
                        if (ext.equals(_ext)) {
                            chk = true;
                            break;
                        }
                    }
                    if (!chk) {
                        throw new ServiceException("파일 업로드를 허용하지 않는 확장자 입니다.");
                    }
                } else {
                    throw new ServiceException("파일 확장자가 없습니다.");
                }
            }
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
            throw new ServiceException(sve.getMessage());
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new ServiceException(e.getMessage());
        }
    }
}
