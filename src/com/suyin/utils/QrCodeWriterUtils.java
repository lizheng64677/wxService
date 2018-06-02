package com.suyin.utils;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.suyin.utils.zxing.MatrixToImageWriter;
public class QrCodeWriterUtils {

    private final static Logger log=Logger.getLogger(QrCodeWriterUtils.class);
	/**
	 * 
	 * @param openid  用户微信openid
	 * @param text    二维码内置参数 tourl 扫描二维码时，跳转的路径
	 * @param tempPath 生成二维码时，定义的系统临时存放路径
	 * @return
	 * @throws WriterException
	 * @throws IOException
	 */
	public static synchronized String createQrcodeImage(String openid,String text,String tempPath) throws WriterException, IOException{
		MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
		Map<EncodeHintType, String> hints = new HashMap<EncodeHintType, String>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
	
		String cordUrl="";
		try{
			BitMatrix bitMatrix = multiFormatWriter.encode(text+" ", BarcodeFormat.QR_CODE, 400, 400, hints);
			File path=new File(tempPath);
			if(!path.exists()){
				path.mkdirs();
			}
			//二维码临时路径/用户openid/.jpg 
			File file = new File(tempPath+openid+".jpg");
			if(!file.exists()){
				file.mkdir();
			}
			MatrixToImageWriter.writeToFile(bitMatrix, "jpg", file);
			cordUrl=tempPath+openid+".jpg";
		}catch(Exception ex){
			log.error(ex);
		}
		return cordUrl;
	}
	/**
	 * 
	 * @param openid  用户微信openid
	 * @param text    二维码内置参数 tourl 扫描二维码时，跳转的路径
	 * @param tempPath 生成二维码时，定义的系统临时存放路径
	 * @return
	 * @throws WriterException
	 * @throws IOException
	 */
	public static synchronized BufferedImage  createQrcodeImage(String openid,String text) throws WriterException, IOException{
		MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
		Map<EncodeHintType, String> hints = new HashMap<EncodeHintType, String>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		try{
			BitMatrix bitMatrix = multiFormatWriter.encode(text+" ", BarcodeFormat.QR_CODE, 400, 400, hints);
			BufferedImage image= MatrixToImageWriter.toBufferedImage(bitMatrix);
			return image;
		}catch(Exception ex){
			log.error(ex);
		}
		return null;
	}
	/**
	 * 二维码海报合成
	 * @param projectUrl  项目相对路径
	 * @param userCodeUrl 用户二维码路径
	 * @param userId	 用户主键id
	 * @param userName	 用户名称
	 * @return
	 */
	public static synchronized OutputStream generateCode(String templateurl, InputStream inputStream ,String userId, String userName,HttpServletResponse resp) {  
	    Font font = new Font("微软雅黑", Font.PLAIN, 30);// 添加字体的属性设置  
	    OutputStream outStream =null;
	    try {  
	        // 加载本地模板图片  
	        BufferedImage imageLocal = ImageIO.read(new File(templateurl));  
	        // 加载用户的二维码  
	        BufferedImage imageCode = ImageIO.read(inputStream);  
	        // 以本地图片为模板  
	        Graphics2D g = imageLocal.createGraphics();  
	        // 在模板上添加用户二维码(地址,左边距,上边距,图片宽度,图片高度,未知)  
	        g.drawImage(imageCode, 160, imageLocal.getHeight() - 280, 120, 120, null);  
	        // 设置文本样式  
	        g.setFont(font);  
	        g.setColor(Color.BLACK);  
	        // 拼接新的用户名称  
	        String newUserName = userName+ "的邀请二维码";  
	        // 添加用户名称  
	        g.drawString(newUserName, 620, imageLocal.getHeight() - 130);  
	        // 完成模板修改  
	        g.dispose();  
			outStream = resp.getOutputStream();
	        // 生成新的合成过的用户二维码并写入新图片  
	        ImageIO.write(imageLocal, "png", outStream);  
	    } catch (Exception e) {  
	        e.printStackTrace();  
	    }  
	    return outStream;

	}  
}
