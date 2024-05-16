package egovframework.common.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.logging.Logger;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;

public class SFTPSyncManager {
    private boolean LOG_DEBUG = true;
    private final Logger LOGGER = Logger.getLogger(SFTPSyncManager.class.getName());


    private Session session = null;
    private Channel channel = null;
    private ChannelSftp sftp = null;

    /**
     * 초기화
     *
     * @param host
     * @param port
     * @param username
     * @param password
     */
    public void init(String host, int port, String username, String password) {
        JSch jsch = new JSch();

        try {
            session = jsch.getSession(username, host, port);
            session.setPassword(password);
            session.setConfig("StrictHostKeyChecking", "no");
            session.connect();

            log("sFTP 접속 성공");

            channel = session.openChannel("sftp");
            channel.connect();

            sftp = (ChannelSftp) channel;
        } catch (JSchException e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 업로드 하여 싱크맞추기
     *
     * @param fromPath
     * @param toPath
     * @throws SftpException
     */
    public void uploadSync(String fromPath, String toPath) throws SftpException {
        log("uploadSync 작업 시작");
        // toPath 의 모든 하위디렉토리 까지 생성
        mkdirs(toPath);
        uploadDir(fromPath, toPath);
        log("uploadSync 작업 종료");
    }

    /**
     * 다운로드 하여 싱크 맞추기
     *
     * @param fromPath
     * @param toPath
     */
    public void downloadSync(String fromPath, String toPath) {
        log("downloadSync 작업 시작");
        downloadDir(fromPath, toPath);
        log("downloadSync 작업 종료");

    }

    /**
     * 디렉토리 하위 파일들을 삭제합니다.
     *
     * @param path
     */
    public void emptyDir(String path) {

        try {
            if (sftp != null) {
                sftp.cd(path);
                sftp.rm(path);
            }
        } catch (SftpException e) {
            EgovWebUtil.exLogging(e);
        }

    }

    /**
     * 연결 끊기
     */
    public void disconnect() {
        if (session != null) {
            session.disconnect();
        }
        if (channel != null) {
            channel.disconnect();
        }
        if (sftp != null && sftp.isConnected()) {
            sftp.disconnect();
            sftp.exit();
            sftp.quit();
        }

        log("sFTP 접속 종료");
    }

    // 파일 업로드
    private void uploadDir(String dir, String workingPath) {
        FileInputStream fis = null;
/*		try {
			
			if(fileList == null) {
				throw new Exception("로컬에 디렉토리가 존재하지 않습니다.");
			}
			
			
			// 로컬의 디렉토리 파일 목록
			for(File file : fileList) {
				// 디렉토리 이면
				if(file.isDirectory()) {
					String _workingPath = replaceDirStr(workingPath);
					// 현재 sFTP디렉토리에 디렉토리 생성
					Vector<LsEntry> toFiles = sftp.ls(_workingPath);
					boolean dirChk = false;
					for(LsEntry toFile : toFiles) {
						if(toFile.getAttrs().isDir() && toFile.getFilename().equals(file.getName())) {
							dirChk = true;
						}
					}
					if(!dirChk) {
						sftp.mkdir(_workingPath + file.getName());
					}
					uploadDir(file.getPath(), _workingPath + file.getName());
				}
				// 파일이면
				else {
					// 현재 작업 디렉토리 설정
					sftp.cd(workingPath);
					// 현재 sFTP디렉토리의 파일 목록
					Vector<LsEntry> toFiles = sftp.ls(workingPath);
					boolean flag = true;
					for(LsEntry toFile : toFiles) {
						// 파일명과 용량이 같으면 같은파일로 간주함.
						if(file.getName().equals(toFile.getFilename()) && file.length() == toFile.getAttrs().getSize()) {
							flag = false;
							break;
						}
					}
					// 없는 파일일 때만 업로드 한다.
					if(flag) {
						fis = new FileInputStream(file);
						sftp.put(fis, file.getName());
						log(replaceDirStr(workingPath) + file.getName() + " uploaded success!");
					}
				}
			}
		} catch (SftpException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(fis != null) {fis.close();}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}*/
    }

    // 파일 다운로드
    private void downloadDir(String workingPath, String dir) {
        InputStream is = null;
        FileOutputStream fos = null;
		
/*		try {
			// 작업 디렉토리 변경
			sftp.cd(workingPath);
			Vector<LsEntry> fromFiles = sftp.ls(workingPath);
			for(LsEntry file : fromFiles) {
				// 디렉토리인 경우
				if(file.getAttrs().isDir()) {
					if(chkDirName(file.getFilename())) {
						String _dir = replaceDirStr(dir);
						String _workingPath = replaceDirStr(workingPath);
						// 로컬에 디렉토리 생성
						downloadDir(_workingPath + file.getFilename(), _dir + file.getFilename());
					}
				}
				// 파일인 경우
				else {
					// 작업 디렉토리 변경
					sftp.cd(workingPath);
					// 현재 로컬 디렉토리의 파일 목록
					if(toFiles != null) {
						boolean flag = true;
						for(File toFile : toFiles) {
							// 파일명과 용량이 같으면 같은파일로 간주함.
							if(file.getFilename().equals(toFile.getName()) && file.getAttrs().getSize() == toFile.length()) {
								flag = false;
								break;
							}
						}
						// 없는 파일일 때만 다운로드 한다.
						if(flag) {
							is = sftp.get(file.getFilename());
							int i = 0;
							while ((i = is.read()) != -1) {
								fos.write(i);
							}
							log(replaceDirStr(dir) + file.getFilename() + " downloaded success!");
						}
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SftpException e) {
			e.printStackTrace();
		} finally {
			try {
				if(is != null) {	is.close();}
				if(fos != null) {fos.close();}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}*/

    }

    // 디렉토리명 끝에 '/' 붙이기
    private String replaceDirStr(String dir) {
        String result = "";
        if (dir.charAt(dir.length() - 1) != '/') {
            result = dir + "/";
        } else {
            result = dir;
        }
        return result;
    }

    // sFTP 최초 대상 디렉토리 생성
    private void mkdirs(String path) {
        String[] pathList = path.split("/");
        if (pathList.length > 0) {
            for (int i = 0; i < pathList.length; i++) {
                if (!"".equals(pathList[i])) {
                    if (i == 0) {
                        pathList[i] = "/" + pathList[i];
                    } else {
                        pathList[i] = pathList[i - 1] + "/" + pathList[i];
                    }
                    try {
                        if (sftp != null) {
                            sftp.mkdir(pathList[i]);
                        }

                    } catch (SftpException e) {
                        EgovWebUtil.exLogging(e);
                    }
                }
            }
        }
    }

    // 리눅스 등에서 '.' 나 '..' 등 상위 디렉토리로 가는 항목이 isDirectory() == true 가 되는것을 방지
    private boolean chkDirName(String dirName) {
        char[] arr = dirName.toCharArray();
        for (char c : arr) {
            if (c != '.') {
                return true;
            }
        }
        return false;
    }

    private void log(String message) {
        if (LOG_DEBUG) {
            LOGGER.info(message);
        }
    }


    public void runsftp(String flag, String fromPath, String toPath) {

        String host = EgovProperties.getProperty("sftp.host");
        String pass = EgovProperties.getProperty("sftp.pass");
        String port = EgovProperties.getProperty("sftp.port");
        String user = EgovProperties.getProperty("sftp.user");


        try {
            this.init(host, Integer.parseInt(port), user, pass);

            if ("U".equals(flag)) {
                this.uploadSync(fromPath, toPath);
            } else if ("D".equals(flag)) {
                this.downloadSync(fromPath, toPath);
            }

            this.disconnect();
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }
}
