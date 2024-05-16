package egovframework.common.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.util.Stack;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.springframework.dao.DataAccessException;

import egovframework.com.cmm.EgovWebUtil;

/**
 * Zip 파일 압축 & 해제 유틸
 *
 * @author hsJang
 */
public class UtilZip {

    private static boolean debug = false;

    /*
    public void unzip(File zippedFile) throws IOException {
        unzip(zippedFile, Charset.defaultCharset().name());
    }*/
	/*
	public void unzip(File zippedFile, String charsetName ) throws IOException {
		unzip(zippedFile, zippedFile.getParentFile(), charsetName);
	}*/
	/*
	public void unzip(File zippedFile, File destDir) throws IOException {
		FileInputStream fis = null;
		
		try {
			unzip(fis, destDir, Charset.defaultCharset().name());
		} catch(IOException ioe) {
			EgovWebUtil.exLogging(ioe);
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
		} finally {
			try {
        		if ( fis != null ) {
        			fis.close();
        		}
        	} catch(Exception e) {
        		EgovWebUtil.exLogging(e);
        	}
		}
	}*/
	/*
	public void unzip(File zippedFile, File destDir, String charsetName) throws IOException {
		FileInputStream fis = null;
		
		try {
			unzip(fis, destDir, charsetName);
		} catch(IOException ioe) {
			EgovWebUtil.exLogging(ioe);
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
		} finally {
			try {
        		if ( fis != null ) {
        			fis.close();
        		}
        	} catch(Exception e) {
        		EgovWebUtil.exLogging(e);
        	}
		}
	}*/
    public void unzip(InputStream is, File destDir) throws IOException {
        unzip(is, destDir, Charset.defaultCharset().name());
    }

    public void unzip(InputStream is, File destDir, String charsetName) {
        ZipArchiveInputStream zis = null;
        ;
        ZipArchiveEntry entry;
        String name;
        File target;
        int nWritten = 0;
        BufferedOutputStream bos;
        byte[] buf = new byte[1024 * 8];

        try {
            if (!destDir.exists()) {
                destDir.mkdirs();
            }

            zis = new ZipArchiveInputStream(is, charsetName, false);
            while ((entry = zis.getNextZipEntry()) != null) {
                name = EgovWebUtil.filePathReplaceAll(entry.getName());

                target = new File(destDir, name);
                // 수정 : 권한 설정
                target.setExecutable(true, true);
                target.setReadable(true);
                target.setWritable(true, true);

                if (entry.isDirectory()) {
                    target.mkdirs(); /*  does it always work? */
                    debug("dir  : " + name);
                } else {
                    target.createNewFile();
                    bos = new BufferedOutputStream(new FileOutputStream(target));
                    while ((nWritten = zis.read(buf)) >= 0) {
                        bos.write(buf, 0, nWritten);
                    }
                    bos.close();
                    debug("file : " + name);
                }
            }
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * compresses the given file(or dir) and creates new file under the same directory.
     *
     * @param src file or directory
     * @throws IOException
     */
    public void zip(File src) throws IOException {
        zip(src, Charset.defaultCharset().name(), true);
    }

    /**
     * zips the given file(or dir) and create
     *
     * @param src        file or directory to compress
     * @param includeSrc if true and src is directory, then src is not included in the compression. if false, src is included.
     * @throws IOException
     */
    public void zip(File src, boolean includeSrc) throws IOException {
        zip(src, Charset.defaultCharset().name(), includeSrc);
    }

    /**
     * compresses the given src file (or directory) with the given encoding
     *
     * @param src
     * @param charSetName
     * @param includeSrc
     * @throws IOException
     */
    public void zip(File src, String charSetName, boolean includeSrc) throws IOException {
        zip(src, src.getParentFile(), charSetName, includeSrc);
    }

    /**
     * compresses the given src file(or directory) and writes to the given output stream.
     *
     * @param src
     * @param os
     * @throws IOException
     */
    public void zip(File src, OutputStream os) throws IOException {
        zip(src, os, Charset.defaultCharset().name(), true);
    }

    /**
     * compresses the given src file(or directory) and create the compressed file under the given destDir.
     *
     * @param src
     * @param destDir
     * @param charSetName
     * @param includeSrc
     * @throws IOException
     */
    public void zip(File src, File destDir, String charSetName, boolean includeSrc) throws IOException {
        FileOutputStream fos = null;

        try {
            String fileName = src.getName();
            if (!src.isDirectory()) {
                int pos = fileName.lastIndexOf(".");
                if (pos > 0) {
                    fileName = fileName.substring(0, pos);
                }
            }
            fileName += ".zip";

            File zippedFile = new File(destDir, EgovWebUtil.filePathReplaceAll(fileName));
            if (!zippedFile.exists()) zippedFile.createNewFile();
            fos = new FileOutputStream(zippedFile);
            zip(src, fos, charSetName, includeSrc);
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (DataAccessException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
    }

    public String zipByEtl(String srcDir, String destDir) throws IOException {
        FileOutputStream fos = null;
        StringBuffer zipFilePath = null;

        try {
            File _srcDir = new File(EgovWebUtil.folderPathReplaceAll(srcDir));
            String path = _srcDir.getPath();
            zipFilePath = new StringBuffer(new File(EgovWebUtil.folderPathReplaceAll(destDir)).getPath());
            if (path.indexOf("/") != -1) {
                zipFilePath.append("/" + path.substring(path.indexOf("/")).replaceAll("/", "_"));
            } else if (path.indexOf("\\") != -1) {
                zipFilePath.append("\\" + path.substring(path.indexOf("\\")).replaceAll("\\\\", "_"));
            }
            zipFilePath.append(".zip");
            fos = new FileOutputStream(zipFilePath.toString());
            zip(_srcDir, fos, Charset.defaultCharset().name(), false);

        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (DataAccessException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }

        return zipFilePath.toString();
    }

    public void zip(File src, OutputStream os, String charsetName, boolean includeSrc) throws IOException {
        ZipArchiveOutputStream zos = new ZipArchiveOutputStream(os);
        zos.setEncoding(charsetName);
        FileInputStream fis = null;

        int length;
        ZipArchiveEntry ze;
        byte[] buf = new byte[8 * 1024];
        String name;

        try {
            Stack<File> stack = new Stack<File>();
            File root;
            if (src.isDirectory()) {
                if (includeSrc) {
                    stack.push(src);
                    root = src.getParentFile();
                } else {
                    File[] fs = src.listFiles();
                    for (int i = 0; i < fs.length; i++) {
                        stack.push(fs[i]);
                    }
                    root = src;
                }
            } else {
                stack.push(src);
                root = src.getParentFile();
            }

            while (!stack.isEmpty()) {
                File f = stack.pop();
                name = toPath(root, f);
                if (f.isDirectory()) {
                    debug("dir  : " + name);
                    File[] fs = f.listFiles();
                    if (fs != null) {
                        for (int i = 0; i < fs.length; i++) {
                            if (fs[i].isDirectory()) stack.push(fs[i]);
                            else stack.add(0, fs[i]);
                        }
                    }
                    ze = new ZipArchiveEntry(name);
                    zos.putArchiveEntry(ze);
                    zos.closeArchiveEntry();
                } else {
                    debug("file : " + name);
                    ze = new ZipArchiveEntry(name);
                    zos.putArchiveEntry(ze);
                    fis = new FileInputStream(f);
                    while ((length = fis.read(buf, 0, buf.length)) >= 0) {
                        zos.write(buf, 0, length);
                    }
                    zos.closeArchiveEntry();
                }
            }
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
                if (zos != null) {
                    zos.close();
                }
            } catch (DataAccessException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
    }

    private String toPath(File root, File dir) {
        String path = dir.getAbsolutePath();
        path = path.substring(root.getAbsolutePath().length()).replace(File.separatorChar, '/');
        if (path.startsWith("/")) path = path.substring(1);
        if (dir.isDirectory() && !path.endsWith("/")) path += "/";
        return path;
    }

    private static void debug(String msg) {
    }
    /*
	public static void main(String[] args) throws IOException {
		UtilZip uz = new UtilZip();
//		uz.zipByEtl("C:\\DATA\\upload\\mainmng\\aaa", "C:\\DATA\\receive");
		uz.unzip(new File("C:\\ETL_data\\send\\_DATA_upload_mainmng.zip"), new File("/DATA/upload/mainmng"));
	}*/
}
