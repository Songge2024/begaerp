package com.bl3.pm.mongodb.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.bl3.pm.process.dao.po.ProcessFileUploadPO;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSPropertiesHandler;
import aos.framework.web.router.HttpModel;

/**
 * <b>连接mongodb服务类</b>
 * 
 * @author heying
 * @date 2019-03-28
 */
@Service
public class MongoDBService {

	private static String mongoURL;// 连接地址 localhost
	private static int mongoPort;// 端口 27017
	private static String dbName;// 数据库实例 test
	private static String mongoUserName;// mongoDB用户名
	private static String mongoPWD;// mongoDB密码

	// 实例化连接对象
	private static MongoClient mongoClient = null;
	// 获取数据库
	private DB db = null;

	public MongoDBService() {
		// 初始化mongoDB连接参数
		mongoURL = AOSPropertiesHandler.getProperty("mongoDB.URL");
		mongoPort = Integer.valueOf(AOSPropertiesHandler.getProperty("mongoDB.Port"));
		dbName = AOSPropertiesHandler.getProperty("mongoDB.DBName");
		mongoUserName = AOSPropertiesHandler.getProperty("mongoDB.UserName");
		mongoPWD = AOSPropertiesHandler.getProperty("mongoDB.PWD");

		// 实例化连接对象，此处无用户名密码,如果有用户名密码，请修改实例化对象
		//mongoClient = new MongoClient(mongoURL, mongoPort);
			
		MongoClient mongoClient = new MongoClient(new MongoClientURI("mongodb://"+mongoUserName+":"+mongoPWD+"@"+mongoURL+":"+mongoPort+"/?authSource="+dbName+"&ssl=false"));
		db = mongoClient.getDB(dbName);
	}

	
	/**
	 * 保存文件 保存关键字段：ID，文件名，文件内容
	 * 
	 * @param in
	 * @param id
	 */
	public void save(InputStream in, Object id, String fileName) {
		DBObject query = new BasicDBObject("_id", id);
		GridFS gridFS = new GridFS(db);
		GridFSDBFile gridFSDBFile = gridFS.findOne(query);
		if (gridFSDBFile == null) {
			GridFSInputFile gridFSInputFile = gridFS.createFile(in);
			gridFSInputFile.setId(id);
			gridFSInputFile.setFilename(fileName);
			gridFSInputFile.save();
		}
	}
	
	/**
	 * 据id获取文件
	 * 
	 * @param id
	 * @return
	 */
	public GridFSDBFile findByFileCode(Object id) {
		DBObject query = new BasicDBObject("_id", id);
		GridFS gridFS = new GridFS(db);
		GridFSDBFile gridFSDBFile = gridFS.findOne(query);
		return gridFSDBFile;
	}
	
	/**
	 * 下载文件
	 * @param
	 */
	public void downloadFile(HttpModel httpModel){
		// 这里只是演示获取httpmodel获取response对象，具体的表格生成请自行使用poi生成电子表格
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		Dto inDto = httpModel.getInDto();
		String fileName = inDto.getString("fileName");
	
		GridFSDBFile gfs = findByFileCode(fileName);
	
		try {
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName,"UTF-8") + ";");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		BufferedInputStream in;
		ServletOutputStream os = null;
		try {
			in = new BufferedInputStream(gfs.getInputStream());
			ByteArrayOutputStream out = new ByteArrayOutputStream(1024);
			byte[] temp = new byte[1024];
			int size = 0;
			while ((size = in.read(temp)) != -1) {
				out.write(temp, 0, size);
			}
			in.close();
			os = response.getOutputStream();
			os.write(out.toByteArray());
			os.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
}