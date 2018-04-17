package com.suyin.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.UnknownHostException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLInitializationException;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.PoolingClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;


/**
 * @author yll
 * @version 2015年7月7日
 * @see httpClient请求数据
 * @since
 */
@SuppressWarnings("deprecation")
public class HttpClientUtils {
	private static final Logger logger = Logger.getLogger("HttpClientUtils.class");
	

	private static PoolingClientConnectionManager conMgr = null;

	private static HttpParams params = null;

	// 请求超时时间
	private final static int CONNECTION_TIMEOUT = 20000;

	// 等待数据超时时间
	private final static int SO_TIMEOUT = 50000;

	// 连接不够用的时候等待超时时间
	private final static int CONN_MANAGER_TIMEOUT = 300;

	// 连接池总大小
	private final static int MAX_TOTAL_CONNECTIONS = 800;

	// 请求默认最大连接池
	private final static int MAX_ROUTE_CONNECTIONS = 200;

	// post 请求部分
	static {
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());

			SSLSocketFactory ssf = new SSLSocketFactory(sslContext) {
				// non-javadoc, see interface LayeredSocketFactory
				public Socket createSocket(final Socket socket,
						final String host, final int port,
						final boolean autoClose) throws IOException,
						UnknownHostException {
					SSLSocket sslSocket = (SSLSocket) createSocket(socket,
							host, port, autoClose);
					sslSocket.setEnabledProtocols(new String[] { "SSLv3" });
					return sslSocket;
				}
			};
			ssf.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);

			params = new BasicHttpParams();

			params.setParameter(CoreProtocolPNames.PROTOCOL_VERSION,
					HttpVersion.HTTP_1_1);
			// 请求超时时间
			params.setIntParameter(CoreConnectionPNames.CONNECTION_TIMEOUT,
					CONNECTION_TIMEOUT);
			// 请求相应时间
			params.setIntParameter(CoreConnectionPNames.SO_TIMEOUT, SO_TIMEOUT);
			// 请求等待时间
			params.setLongParameter(ClientPNames.CONN_MANAGER_TIMEOUT,
					CONN_MANAGER_TIMEOUT);
			// 在提交请求之前 测试连接是否可用
			params.setBooleanParameter(
					CoreConnectionPNames.STALE_CONNECTION_CHECK, true);
			SchemeRegistry schemeRegistry = new SchemeRegistry();

			schemeRegistry.register(new Scheme("http", 80, PlainSocketFactory
					.getSocketFactory()));

			schemeRegistry.register(new Scheme("https", 443, ssf));

			conMgr = new PoolingClientConnectionManager(schemeRegistry);
		} catch (SSLInitializationException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (KeyManagementException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		try {
			// 连接池的总大小
			conMgr.setMaxTotal(MAX_TOTAL_CONNECTIONS);
		} catch (NumberFormatException e) {
			logger.error( "Key[httpclient.max_total] Not Found in systemConfig.properties", e);
		}
		// 每条通道的并发连接数设置（连接池）
		try {
			// 单个IP 请求最大连接池
			conMgr.setDefaultMaxPerRoute(MAX_ROUTE_CONNECTIONS);
			HttpHost localhost = new HttpHost("localhost", 80);
			conMgr.setMaxPerRoute(new HttpRoute(localhost), 600);// 对本机80端口的socket连接上限是400
		} catch (NumberFormatException e) {
			logger.error( "Key[httpclient.default_max_connection] Not Found in systemConfig.properties", e);
		}
	}
	

	public static HttpClient getHttpClient() {
		return new DefaultHttpClient(conMgr, params);
	}

	public static void release() {
		if (conMgr != null) {
			conMgr.shutdown();
			logger.info("关闭连接");
		}
	}

	/**
	 * get请求inservice远程服务
	 * @param requestUrl <b>该参数前面要带 / 符号</b>
	 * @return
	 */
	public static JSONObject getRemote(String requestUrl) {
		return get(SystemPropertiesHolder.get("REMOTE_URL")+requestUrl);
	}
	
	/**
	 * get请求inservice远程服务
	 * @param requestUrl <b>该参数前面要带 / 符号</b>
	 * @return
	 */
	public static String getRemoteGyString(String requestUrl) {
		return getByString(SystemPropertiesHolder.get("REMOTE_URL")+requestUrl);
	}
	
	/**
	 * 不带cookie,post请求inservice远程服务
	 * @param requestUrl
	 * @param nvps
	 * @return
	 */
	public static JSONObject postRemote(String requestUrl, List<NameValuePair> nvps){
		return  post(SystemPropertiesHolder.get("REMOTE_URL")+requestUrl,nvps,null);
	}
	
	/**
	 * 不带cookie,post请求inservice远程服务
	 * @param requestUrl
	 * @param nvps
	 * @return
	 */
	public static JSONObject postRemote(String requestUrl, List<NameValuePair> nvps,HttpContext httpContext){
		return  post(SystemPropertiesHolder.get("REMOTE_URL")+requestUrl,nvps,httpContext);
	}
	
	
	
	
	
	
	/**
	 * get发送请求返回数据
	 * 
	 * @author Yll
	 * @return
	 * @throws IllegalStateException
	 * @throws URISyntaxException
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	@SuppressWarnings({ "static-access", "unused" })
	public static String getByString(String requestUrl){
		//logger.info("request by get :"+requestUrl);
		String responseMsg = null;
		// 开始时间
		JSONObject jsonObject = null;
		HttpGet get=null;
		try {
			get = new HttpGet(new URI(requestUrl));
			HttpClient httpClient = getHttpClient();
			HttpResponse response = null;
			response = httpClient.execute(get);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity entity = response.getEntity();
				BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
				if((responseMsg = reader.readLine()) != null) {
					
				}
				reader.close();
			} else {
				logger.error("请求错误,请求状态为："+response.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			logger.error("请求错误："+e.getMessage());
			jsonObject=new JSONObject();
			jsonObject.put("error", "1");
		}finally {
			if(get!=null) {
				get.abort();
				get.releaseConnection();
			}
		}
		return responseMsg;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * get发送请求返回数据
	 * 
	 * @author Yll
	 * @return
	 * @throws IllegalStateException
	 * @throws URISyntaxException
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	@SuppressWarnings({ "static-access", "unused" })
	public static JSONObject get(String requestUrl){
		//logger.info("request by get :"+requestUrl);
		String responseMsg = null;
		// 开始时间
		JSONObject jsonObject = null;
		HttpGet get=null;
		try {
			get = new HttpGet(new URI(requestUrl));
			HttpClient httpClient = getHttpClient();
			HttpResponse response = null;
			response = httpClient.execute(get);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity entity = response.getEntity();
				BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
				if((responseMsg = reader.readLine()) != null) {
					jsonObject = JSONObject.fromObject(responseMsg);
					jsonObject.put("error","0");
				}
				reader.close();
			} else {
				logger.error("请求错误,请求状态为："+response.getStatusLine().getStatusCode());
				jsonObject=new JSONObject();
				jsonObject.put("error","1");
			}
		} catch (Exception e) {
			logger.error("请求错误："+e.getMessage());
			jsonObject=new JSONObject();
			jsonObject.put("error", "1");
		}finally {
			if(get!=null) {
				get.abort();
				get.releaseConnection();
			}
		}
		return jsonObject;
	}
	
	

	/**
	 * post发送请求返回数据,这里还要cookie
	 * 
	 * @author Yll
	 * @return
	 * @throws URISyntaxException
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	public static JSONObject post(String requestUrl, List<NameValuePair> nvps,HttpContext httpContext){
		//logger.info("request by post :"+requestUrl);
		//logger.info("the parameters is: "+nvps);
		JSONObject jsonObject = null;
		HttpPost post=null;
		try {
			post=new HttpPost(requestUrl);
			post.setEntity(new UrlEncodedFormEntity(nvps,"UTF-8"));
			HttpClient httpClient = getHttpClient();
			HttpResponse response=httpClient.execute(post,httpContext);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity entity=response.getEntity();
				BufferedReader rd = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));
				String temp=null;
				if((temp=rd.readLine())!=null) {
					jsonObject=JSONObject.fromObject(temp);
					jsonObject.put("error","0");
				}
				rd.close();
				entity=null;
			}else {
				logger.error("请求错误,请求状态为："+response.getStatusLine().getStatusCode());
				jsonObject=new JSONObject();
				jsonObject.put("error", "1");
			}
		} catch (Exception e) {
			logger.error("请求错误："+e.getMessage());
			jsonObject=new JSONObject();
			jsonObject.put("error", "1");
		}finally {
			if(post!=null) {
				post.abort();
				post.releaseConnection();
			}
		}
		return jsonObject;
	}
	
	/**
	 * 敏感操作的post操作，
	 * 先带上openid去远程获取token
	 * 	1.返回success，那么就返回用post去获取需要的值
	 *  2.返回timeout，说明token失效了，这时去reset一下token
	 *  	a.reset 返回success，说明reset成功了，用post去获取需要的值
	 *  	b.reset返回其他东西（如invalidtoken，等等），那就是有出现错误了，就不理他了
	 *  3.返回isemptytoken，通2的情况
	 *  4.返回invalidinfo，理论上不可能出现这种情况
	 *  
	 *  使用方法：
	 *  JsonObject result=classifiedPost(...,..,....);
	 *  if("1".equals(result.getString("error")){
	 *  	//出现网络错误，post和get根本连不上
	 *  } else if("success".equals(result.getString("message))){
	 *  	//找到了正确结果了
	 *  } else {
	 *  	//反正就是servie内部出现了错误，我也不管什么错误了
	 *  }
	 *  
	 *
	 *  @param 必须包含moduleName 和regtype
	 * @return  必须明确：所有的get和post方法都可能报错（网络错误或者读写错误，在get和post方法中统一置error标志位为1）
	 */
	public static JSONObject  classifiedPost(String requestUrl, List<NameValuePair> nvps,String openId) {
		String temp="?regtype=0?openid="+openId;
		String remoteUrl=Constant.REMOTE_GETTOKEN+temp;
		JSONObject result=getRemote(remoteUrl);
		if("success".equalsIgnoreCase(result.getString("message"))) {
			return postRemote(requestUrl,nvps);
		//分别是token失效了，和第一次获取
		}else if("timeout".equalsIgnoreCase(result.getString("message"))||"isemptytoken".equalsIgnoreCase(result.getString("message"))) {
			result=getRemote(Constant.REMOTE_RESETTOKEN+temp);
			if("success".equalsIgnoreCase(result.getString("message"))) {
				return postRemote(requestUrl,nvps);
			}else { 
				return result;
			}
		}else if("invalidinfo".equalsIgnoreCase(result.getString("message"))){
			//理论上不可能出现这种错误。除非spring自己粗错了。。。
			return result;
		}
		return result;
	}	
}
