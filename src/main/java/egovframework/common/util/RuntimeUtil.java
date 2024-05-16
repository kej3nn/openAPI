package egovframework.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;

public class RuntimeUtil {

    private static final Logger logger = Logger.getLogger(RuntimeUtil.class);

    public static void execCmdAsync(ArrayList<String> args, String dir) throws InterruptedException {

        if (args.isEmpty()) {
            logger.debug("\n\n #### execCmd arguments is null, error -1");
            return;
        }

        //OS 종류 확인

        String osName = System.getProperty("os.name");
        if (osName == null) {
            osName = "";
        }
        logger.debug(" - OS Name: " + osName);

        int length = args.size();
        logger.debug(" - Arguement length: " + length);

        StringBuilder sb = new StringBuilder();

        logger.debug(" - StringBuilder capacity: " + sb.capacity());
        logger.debug(" - StringBuilder length: " + sb.length());

        for (String str : args) {
            sb.append(str);
            sb.append(" ");
        }

        logger.debug(" - StringBuilder length: " + sb.length());
        logger.debug(" - Path: " + dir);
        logger.debug(" - Command: " + sb.toString());

        String[] cmd = null;

        if (osName.toLowerCase().startsWith("window")) {
            // OS 가  Windows 일때 명령어 라인 생성
            cmd = new String[]{"cmd.exe", "/y", "/c", sb.toString()};
            logger.debug(" Command_cmd: " + cmd);
        } else {
            cmd = new String[]{"/bin/sh", "-c", sb.toString()};
        }

        File fileDir = new File(dir);

        // 콘솔 명령 실행
        try {
            Runtime.getRuntime().exec(cmd, null, fileDir);
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        }
    }

    public static void execCmd(ArrayList<String> args) throws InterruptedException {

        if (args.isEmpty()) {
            logger.debug("\n\n #### execCmd arguments is null, error -1");
            return;
        }

        //OS 종류 확인

        String osName = System.getProperty("os.name");
        if (osName == null) {
            osName = "";
        }
        logger.debug(" - OS Name: " + osName);

        int length = args.size();
        logger.debug(" - Arguement length: " + length);

        StringBuilder sb = new StringBuilder();

        logger.debug(" - StringBuilder capacity: " + sb.capacity());
        logger.debug(" - StringBuilder length: " + sb.length());

        for (String str : args) {
            sb.append(str);
            sb.append(" ");
        }

        logger.debug(" - StringBuilder length: " + sb.length());
        logger.debug(" - Command: " + sb.toString());

        Process process = null;
        BufferedReader br = null;

        try {
            String[] cmd = null;

            if (osName.toLowerCase().startsWith("window")) {
                // OS 가  Windows 일때 명령어 라인 생성
                cmd = new String[]{"cmd.exe", "/y", "/c", sb.toString()};
            } else {
                cmd = new String[]{"/bin/sh", "-c", sb.toString()};
            }

            // 콘솔 명령 실행
            process = Runtime.getRuntime().exec(cmd);

            // 실행 결과 확인 (에러)
            StringBuffer stdMsg = new StringBuffer();

            // 스레드로 inputStream 버퍼 비우기
            ProcessOutputThread o = new ProcessOutputThread(process.getInputStream(), stdMsg);
            o.start();

            StringBuffer errMsg = new StringBuffer();

            // 스레드로 errorStream 버퍼 비우기
            o = new ProcessOutputThread(process.getErrorStream(), errMsg);
            o.start();

            // 수행종료시까지 대기
            process.waitFor();

            logger.debug("stdMsg : " + stdMsg);
            logger.debug("errMsg : " + stdMsg);

        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        }

        if (process != null) {
            process.destroy();
        }

        sb.delete(0, sb.length());
        sb.setLength(0);
        sb = null;

    }
}


// 스레드로 inputStream 버퍼 비우기 위한 클래스 생성
class ProcessOutputThread extends Thread {

    private InputStream is;
    private StringBuffer msg;

    public ProcessOutputThread(InputStream is, StringBuffer msg) {
        this.is = is;
        this.msg = msg;
    }

    public synchronized void run() {
        try {
            msg.append(getStreamString(is));
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    EgovWebUtil.exLogging(e);
                }
            }
        }
    }

    private String getStreamString(InputStream is) {
        BufferedReader reader = null;

        try {
            reader = new BufferedReader(new InputStreamReader(is));
            StringBuffer out = new StringBuffer();
            String stdLine;

            while ((stdLine = reader.readLine()) != null) {
                out.append(stdLine);
            }

            return out.toString();

        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
            return "";
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            return "";
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    EgovWebUtil.exLogging(e);
                }
            }
        }
    }
}