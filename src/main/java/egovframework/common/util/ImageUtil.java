package egovframework.common.util;
/*
 * ImageUtil.java
 *
 * GNU Lesser General Public License
 * http://www.gnu.org/licenses/lgpl.html
 */

import java.io.*;
import java.nio.BufferOverflowException;

import org.apache.log4j.Logger;
import org.apache.commons.lang.*;
import org.springframework.dao.DataAccessException;

import java.awt.Image;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;


import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.imageConv.AnimatedGifEncoder;
import egovframework.common.imageConv.GifDecoder;

public class ImageUtil {
    private static final Logger logger = Logger.getLogger(ImageUtil.class);

    public static void createThumbnail(String load, String save, String type, int w, int h) {
        BufferedInputStream stream_file = null;
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(load);
            stream_file = new BufferedInputStream(fis);
            createThumbnail(stream_file, save, type, w, h);

        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (stream_file != null) {
                    stream_file.close();
                }
                if (fis != null) {
                    fis.close();
                }
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
            }
        }

    }

    public static void createThumbnail(BufferedInputStream stream_file, String save, String type, int w, int h) {
        try {

            if (StringUtils.equals(StringUtils.lowerCase(type), "gif")) {
                getGifImageThumbnail(stream_file, save, type, w, h);
            } else {
                getImageThumbnail(stream_file, save, type, w, h);
            }

        } catch (ServiceException sve) {
            logger.error(sve);
        } catch (Exception e) {
            logger.error(e);
        }

    }

    public static void getImageThumbnail(BufferedInputStream stream_file, String save, String type, int w, int h) {
        OutputStream bos = null;
        try {
            bos = new FileOutputStream(EgovWebUtil.filePathBlackList(save));
            BufferedImage bi = ImageIO.read(stream_file);

            int width = 0;
            int height = 0;
            if (bi != null) {
                width = bi.getWidth();
                height = bi.getHeight();
            }
            if (w < width) {
                width = w;
            }
            if (h < height) {
                height = h;
            }

            BufferedImage bufferIm = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

            bi = bi == null ? bufferIm : bi;

            Image atemp = bi.getScaledInstance(width, height, Image.SCALE_AREA_AVERAGING);

            Graphics2D g2 = bufferIm.createGraphics();
            g2.drawImage(atemp, 0, 0, width, height, null);
            ImageIO.write(bufferIm, type, bos);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (bos != null) {
                    bos.close();
                }
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
            }
        }
    }

    public static void getGifImageThumbnail(BufferedInputStream stream_file, String save, String type, int w, int h) {

        GifDecoder dec = new GifDecoder();
        AnimatedGifEncoder enc = new AnimatedGifEncoder();
        dec.read(stream_file);

        int cnt = dec.getFrameCount();

        int delay = 0;
        int width = 0;
        int height = 0;

        try {
            enc.start(save);
            enc.setRepeat(0);

            for (int i = 0; i < cnt; i++) {
                BufferedImage frame = dec.getFrame(i);
                delay = dec.getDelay(i);

                width = frame.getWidth();
                height = frame.getHeight();
                if (w < width) {
                    width = w;
                }
                if (h < height) {
                    height = h;
                }

                BufferedImage destimg = new BufferedImage(width, height, BufferedImage.TYPE_4BYTE_ABGR);
                Graphics2D g = destimg.createGraphics();

                g.drawImage(frame, 0, 0, width, height, null);
                enc.setDelay(delay);

                enc.addFrame(destimg);
            }

            enc.finish();
        } catch (ServiceException sve) {
            logger.error(sve);
        } catch (Exception ex) {
            logger.error(ex);
        }

    }

}