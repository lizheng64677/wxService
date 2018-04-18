package com.suyin.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

/**
 * 图片二维码合成工具类
 * 截图
 * 拼接
 * 合成
 * @author Administrator
 *
 */
public class ImageHandleHelper {
	/**
	 * @Description:截图
	 * @author:liuyc
	 * @time:2016年5月27日 上午10:18:23
	 * @param srcFile源图片、targetFile截好后图片全名、startAcross 开始截取位置横坐标、StartEndlong开始截图位置纵坐标、width截取的长，hight截取的高
	 */
	public static void cutImage(String srcFile, String targetFile, int startAcross, int StartEndlong, int width,
			int hight) throws Exception {
		// 取得图片读入器
		Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("jpg");
		ImageReader reader = readers.next();
		// 取得图片读入流
		InputStream source = new FileInputStream(srcFile);
		ImageInputStream iis = ImageIO.createImageInputStream(source);
		reader.setInput(iis, true);
		// 图片参数对象
		ImageReadParam param = reader.getDefaultReadParam();
		Rectangle rect = new Rectangle(startAcross, StartEndlong, width, hight);
		param.setSourceRegion(rect);
		BufferedImage bi = reader.read(0, param);
		ImageIO.write(bi, targetFile.split("\\.")[1], new File(targetFile));
	}

	/**
	 * @Description:图片拼接 （注意：必须两张图片长宽一致哦）
	 * @author:liuyc
	 * @time:2016年5月27日 下午5:52:24
	 * @param files 要拼接的文件列表
	 * @param type1  横向拼接， 2 纵向拼接
	 */
	public static void mergeImage(String[] files, int type, String targetFile) {
		int len = files.length;
		if (len < 1) {
			throw new RuntimeException("图片数量小于1");
		}
		File[] src = new File[len];
		BufferedImage[] images = new BufferedImage[len];
		int[][] ImageArrays = new int[len][];
		for (int i = 0; i < len; i++) {
			try {
				src[i] = new File(files[i]);
				images[i] = ImageIO.read(src[i]);
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			int width = images[i].getWidth();
			int height = images[i].getHeight();
			ImageArrays[i] = new int[width * height];
			ImageArrays[i] = images[i].getRGB(0, 0, width, height, ImageArrays[i], 0, width);
		}
		int newHeight = 0;
		int newWidth = 0;
		for (int i = 0; i < images.length; i++) {
			// 横向
			if (type == 1) {
				newHeight = newHeight > images[i].getHeight() ? newHeight : images[i].getHeight();
				newWidth += images[i].getWidth();
			} else if (type == 2) {// 纵向
				newWidth = newWidth > images[i].getWidth() ? newWidth : images[i].getWidth();
				newHeight += images[i].getHeight();
			}
		}
		if (type == 1 && newWidth < 1) {
			return;
		}
		if (type == 2 && newHeight < 1) {
			return;
		}

		// 生成新图片
		try {
			BufferedImage ImageNew = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
			int height_i = 0;
			int width_i = 0;
			for (int i = 0; i < images.length; i++) {
				if (type == 1) {
					ImageNew.setRGB(width_i, 0, images[i].getWidth(), newHeight, ImageArrays[i], 0,
							images[i].getWidth());
					width_i += images[i].getWidth();
				} else if (type == 2) {
					ImageNew.setRGB(0, height_i, newWidth, images[i].getHeight(), ImageArrays[i], 0, newWidth);
					height_i += images[i].getHeight();
				}
			}
			//输出想要的图片
			ImageIO.write(ImageNew, targetFile.split("\\.")[1], new File(targetFile));

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:小图片贴到大图片形成一张图(合成)
	 * @author:liuyc
	 * @time:2016年5月27日 下午5:51:20
	 */
	public static final void overlapImage(String bigPath, String smallPath, String outFile) {
		try {
			BufferedImage big = ImageIO.read(new File(bigPath));
			BufferedImage small = ImageIO.read(new File(smallPath));
			Graphics2D g = big.createGraphics();
			int x = (big.getWidth() - small.getWidth()) / 2;
			int y = (big.getHeight() - small.getHeight()) / 2;
			g.drawImage(small, x, y, small.getWidth(), small.getHeight(), null);
			g.dispose();
			ImageIO.write(big, outFile.split("\\.")[1], new File(outFile));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public static String generateCode(String codeUrl, Integer userId, String userName) {  
	    Font font = new Font("微软雅黑", Font.PLAIN, 30);// 添加字体的属性设置  
	  
	    String projectUrl = "d:/sss/";  
	    String imgName = projectUrl + userId + ".png";  
	    try {  
	        // 加载本地图片  
	        String imageLocalUrl = projectUrl + "weixincode2.jpg";  
	        BufferedImage imageLocal = ImageIO.read(new File(imageLocalUrl));  
	        // 加载用户的二维码  
	        BufferedImage imageCode = ImageIO.read(new File(codeUrl));  
	        // 以本地图片为模板  
	        Graphics2D g = imageLocal.createGraphics();  
	        // 在模板上添加用户二维码(地址,左边距,上边距,图片宽度,图片高度,未知)  
	        g.drawImage(imageCode, 170, imageLocal.getHeight() - 300, 120, 120, null);  
	        // 设置文本样式  
	        g.setFont(font);  
	        g.setColor(Color.BLACK);  
	        // 截取用户名称的最后一个字符  
	        String lastChar = userName.substring(userName.length() - 1);  
	        // 拼接新的用户名称  
	        String newUserName = userName.substring(0, 1) + "**" + lastChar + " 的邀请二维码";  
	        // 添加用户名称  
	        g.drawString(newUserName, 620, imageLocal.getHeight() - 130);  
	        g.drawString("ddddddd",100,100);
	        // 完成模板修改  
	        g.dispose();  
	        // 获取新文件的地址  
	        File outputfile = new File(imgName);  
	        // 生成新的合成过的用户二维码并写入新图片  
	        ImageIO.write(imageLocal, "png", outputfile);  
	    } catch (Exception e) {  
	        e.printStackTrace();  
	    }  
	    // 返回给页面的图片地址(因为绝对路径无法访问)  
	    imgName = "http://localhost" + "codeImg/" + userId + ".png";  
	  
	    return imgName;  
	}  
	
	public static void main(String[] args) {
		String url="d:/ddd/1234.png";
		File file=new File(url);
		int userId=1234;
		String userName="llllllz";
		try{
		generateCode(file.toString(), userId, userName);
		}catch(Exception ex){
			
		}
	}
}
