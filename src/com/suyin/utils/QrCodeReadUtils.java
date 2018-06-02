package com.suyin.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import com.google.zxing.Binarizer;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.common.HybridBinarizer;
import com.suyin.utils.zxing.BufferedImageLuminanceSource;
/**
 * 解析
 * @author Administrator
 *
 */
public class QrCodeReadUtils {

    public static void main(String[] args) {


        
        try {
            MultiFormatReader multiFormatReader = new MultiFormatReader();
            
            File file = new File("cjz.jpg");
            
            BufferedImage image = ImageIO.read(file);
            
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            
            Binarizer binarizer = new HybridBinarizer(source);
            
            BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);
            
            Map hints = new HashMap();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            
            Result result = multiFormatReader.decode(binaryBitmap, hints);
            
            System.out.println("result: " + result.toString());
            System.out.println("resultFormat: " + result.getBarcodeFormat());
            System.out.println("resultText: " + result.getText());
            
        } catch (IOException e) {
            e.printStackTrace();
        } catch (NotFoundException e) {
            e.printStackTrace();
        }
        
        
    }
}
