package com.bl3.pm.task.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSPropertiesHandler;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

import com.bl3.pm.mongodb.service.MongoDBService;
import com.bl3.pm.process.dao.po.ProcessFiletypePO;
import com.bl3.pm.task.dao.TaskFileUploadDao;
import com.bl3.pm.task.dao.TaskFileUploadTempDao;
import com.bl3.pm.task.dao.po.TaskFileUploadPO;
import com.bl3.pm.task.dao.po.TaskFileUploadTempPO;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

/**
 * <b>ta_task_file_upload[ta_task_file_upload]业务逻辑层</b>
 * 
 * @author heying
 * @date 2019-01-12 15:36:01
 */
 @Service
 public class TaskFileUploadService{
 	private static Logger logger = LoggerFactory.getLogger(TaskFileUploadService.class);
 	@Autowired
	private TaskFileUploadDao taskFileUploadDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private MongoDBService mongoDBService;
	@Autowired
	private TaskFileUploadTempDao taskFileUploadTempDao;
	
	/*****************************
	 * mongoDB 文件上传下载 begin
	 ******************************/
	private static String mongoURL;// 连接地址 localhost
	private static int mongoPort;// 端口 27017
	private static String dbName;// 数据库实例 test
	private static String mongoUserName;// mongoDB用户名
	private static String mongoPWD;// mongoDB密码

	// 实例化连接对象
	static MongoClient mongoClient = null;
	// 获取数据库
	private static DB db = null;

	public TaskFileUploadService() {
		// 初始化mongoDB连接参数
		mongoURL = AOSPropertiesHandler.getProperty("mongoDB.URL");
		mongoPort = Integer.valueOf(AOSPropertiesHandler.getProperty("mongoDB.Port"));
		dbName = AOSPropertiesHandler.getProperty("mongoDB.DBName");
		mongoUserName = AOSPropertiesHandler.getProperty("mongoDB.UserName");
		mongoPWD = AOSPropertiesHandler.getProperty("mongoDB.PWD");

		// 实例化连接对象，此处无用户名密码,如果有用户名密码，请修改实例化对象
		mongoClient = new MongoClient(mongoURL, mongoPort);
		// 获取数据库
		db = mongoClient.getDB(dbName);
	}

	/*****************************
	 * mongoDB 文件上传下载end
	 ********************************/
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("taskFileUpload/taskFileUpload_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		TaskFileUploadPO taskFileUploadPO=new TaskFileUploadPO();
		taskFileUploadPO.setFile_id(idService.nextValue("seq_ta_task_file_upload").intValue());
		taskFileUploadPO.copyProperties(inDto);
		taskFileUploadDao.insert(taskFileUploadPO);
		httpModel.setOutMsg("新增成功");
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		TaskFileUploadPO taskFileUploadPO=new TaskFileUploadPO();
		taskFileUploadPO.copyProperties(inDto);
		taskFileUploadDao.updateByKey(taskFileUploadPO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] codes = inDto.getString("file_id").split(",");
		for (int a = 0; a < codes.length; a++) {
			if (!codes[a].isEmpty()) {
				TaskFileUploadPO dto = new TaskFileUploadPO();
				dto = taskFileUploadDao.selectByKey(Integer.parseInt(codes[a]));
				if (AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getFile_path())) {
					String path = dto.getFile_path();
					File file = new File(path);
					file.delete();
				}
//				String _id = "task_files_"+codes[a];
//				Boolean flag = deleteMongoDB(_id);
//				if(flag){
//					taskFileUploadDao.deleteByKey(Integer.parseInt(codes[a]));
//				}
				taskFileUploadDao.deleteByKey(Integer.parseInt(codes[a]));
			}
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TaskFileUploadPO taskFileUploadPO=taskFileUploadDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(taskFileUploadPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TaskFileUploadPO> taskFileUploadPOs = taskFileUploadDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(taskFileUploadPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * @param httpModel
	 */
	public void createPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<TaskFileUploadPO> taskFileUploadPOs = taskFileUploadDao.likeCreatePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(taskFileUploadPOs, inDto.getPageTotal()));
	}
	
	/**
	 * 上传文件
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel) {
		Dto paramDto = httpModel.getInDto();

		// 文件编码需唯一，根据文件编码，从mongoDB中获取对应的文件
		String fileCodeStr = "";

		// 根据proc_filetype_id查询项目ID和过程ID
		/*ProcessFiletypePO po = taskFiletypeDao.selectByKey(paramDto.getInteger("proc_filetype_id"));
		int proj_id = po.getProj_id();
		paramDto.put("proj_id", proj_id);
		paramDto.put("process_id", po.getProcess_id());*/

		int userid = httpModel.getUserModel().getId();
		TaskFileUploadTempPO inDto = new TaskFileUploadTempPO();
		// 获取web应用根路径,也可以直接指定服务器任意盘符路径
		//String savePath = httpModel.getRequest().getServletContext().getRealPath("uploaddata") + "/";

		// 消息提示
		String message = "";
		try {// 使用Apache文件上传组件处理文件上传步骤：
				// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断提交上来的数据是否是上传表单的数据
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if (!isMultipart) {
				// 按照传统方式获取数据
				return;
			}
			// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
			// List<FileItem> list = upload.parseRequest(httpModel.getRequest());
			try {
				MultipartHttpServletRequest multipartRequest = null;
				if (httpModel.getRequest() instanceof MultipartHttpServletRequest) {
					try {
						multipartRequest = (MultipartHttpServletRequest) httpModel.getRequest();
					} catch (Exception ex) {
						ex.getMessage();
					}
				}
				if (multipartRequest != null) {
					Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
					for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
						MultipartFile myfile = entity.getValue();
						// 得到上传的文件名称，
						String filename = myfile.getOriginalFilename();
						System.out.println(filename);
						if (filename == null || filename.trim().equals("")) {
							continue;
						}
						
						// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如： c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
						// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
						 int fileCode = idService.nextValue("seq_pr_process_file_upload").intValue();
//						int fileCode = idService.nextValue("seq_temp_task_upload").intValue();

						// 文件编号需唯一，根据此编号在mongoDB中找到对应的文件，在编号前加上前缀，避免编号重复
						fileCodeStr = "task_files_" + String.valueOf(fileCode);
//						inDto.setFile_id(fileCode);
						filename = filename.substring(filename.lastIndexOf("\\") + 1);
						// filename = filename.replace(".", "-"+version_num+".");
						inDto.setFile_code(fileCodeStr);
						inDto.setProj_id(paramDto.getInteger("proj_id"));
						inDto.setTemp_task_id(paramDto.getString("temp_task_id"));
						inDto.setTask_file_type(paramDto.getInteger("task_file_type"));
						inDto.setFile_title(filename);
						inDto.setFile_size(myfile.getSize() + "");
						inDto.setCreate_user_id(userid);
						inDto.setCreate_time(AOSUtils.getDateTime());
						inDto.setState("1");
						taskFileUploadTempDao.insert(inDto);
						inDto.clear();
						// 获取item中的上传文件的输入流
						InputStream in = myfile.getInputStream();

						/*****************************
						 * mongoDB 文件上传下载 begin
						 ******************************/
						//save(in, fileCodeStr, filename);// 保存文件
						mongoDBService.save(in, fileCodeStr, filename);// 保存文件
						/*****************************
						 * mongoDB 文件上传下载 end
						 ******************************/

						// 删除处理文件上传时生成的临时文件
						message = "{success:true,msg:'上传成功！'}";

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			message = "文件上传失败！";
			e.printStackTrace();
		}
		httpModel.setOutMsg(message);
	}
	
	/**
	 * 上传文件
	 * 
	 * @param httpModel
	 */
	public void importFileCreate(HttpModel httpModel) {
		Dto paramDto = httpModel.getInDto();

		// 文件编码需唯一，根据文件编码，从mongoDB中获取对应的文件
		String fileCodeStr = "";

		int userid = httpModel.getUserModel().getId();
		TaskFileUploadPO inDto = new TaskFileUploadPO();

		// 消息提示
		String message = "";
		try {// 使用Apache文件上传组件处理文件上传步骤：
				// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断提交上来的数据是否是上传表单的数据
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if (!isMultipart) {
				// 按照传统方式获取数据
				return;
			}
			try {
				MultipartHttpServletRequest multipartRequest = null;
				if (httpModel.getRequest() instanceof MultipartHttpServletRequest) {
					try {
						multipartRequest = (MultipartHttpServletRequest) httpModel.getRequest();
					} catch (Exception ex) {
						ex.getMessage();
					}
				}
				if (multipartRequest != null) {
					Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
					for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
						MultipartFile myfile = entity.getValue();
						// 得到上传的文件名称，
						String filename = myfile.getOriginalFilename();
						System.out.println(filename);
						if (filename == null || filename.trim().equals("")) {
							continue;
						}
						
						// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如： c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
						// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
						 int fileCode = idService.nextValue("seq_pr_process_file_upload").intValue();
//						int fileCode = idService.nextValue("seq_temp_task_upload").intValue();

						// 文件编号需唯一，根据此编号在mongoDB中找到对应的文件，在编号前加上前缀，避免编号重复
						fileCodeStr = "task_files_" + String.valueOf(fileCode);
//						inDto.setFile_id(fileCode);
						filename = filename.substring(filename.lastIndexOf("\\") + 1);
						// filename = filename.replace(".", "-"+version_num+".");
						inDto.setFile_code(fileCodeStr);
						inDto.setProj_id(paramDto.getInteger("proj_id"));
						inDto.setTask_id(paramDto.getInteger("task_id"));
						inDto.setTask_file_type(paramDto.getInteger("task_file_type"));
						inDto.setFile_title(filename);
						inDto.setFile_size(myfile.getSize() + "");
						inDto.setCreate_user_id(userid);
						inDto.setCreate_time(AOSUtils.getDateTime());
						inDto.setState("1");
						taskFileUploadDao.insert(inDto);
						inDto.clear();
						// 获取item中的上传文件的输入流
						InputStream in = myfile.getInputStream();

						/*****************************
						 * mongoDB 文件上传下载 begin
						 ******************************/
						//save(in, fileCodeStr, filename);// 保存文件
						mongoDBService.save(in, fileCodeStr, filename);// 保存文件
						/*****************************
						 * mongoDB 文件上传下载 end
						 ******************************/

						// 删除处理文件上传时生成的临时文件
						message = "{success:true,msg:'上传成功！'}";

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			message = "文件上传失败！";
			e.printStackTrace();
		}
		httpModel.setOutMsg(message);
	}
	
	/**
	 * 保存文件 保存关键字段：ID，文件名，文件内容
	 * 
	 * @param in
	 * @param id
	 */
	public static void save(InputStream in, Object id, String fileName) {
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
	public static GridFSDBFile findByFileCode(Object id) {
		DBObject query = new BasicDBObject("_id", id);
		GridFS gridFS = new GridFS(db);
		GridFSDBFile gridFSDBFile = gridFS.findOne(query);
		return gridFSDBFile;
	}
	
	/**
	 * 保存文件 保存关键字段：ID，文件名，文件内容
	 * 
	 * @param in
	 * @param id
	 */
	public static boolean deleteMongoDB(String id) {
		DBObject query = new BasicDBObject("_id", id);
		GridFS gridFS = new GridFS(db);
		GridFSDBFile gridFSDBFile = gridFS.findOne(query);
		gridFS.remove(gridFSDBFile);
		return true;
	}
	
	/**
	 * 文件下载
	 * 
	 * @param httpModel
	 */
	public void downloadFile(HttpModel httpModel) {
		// 这里只是演示获取httpmodel获取response对象，具体的表格生成请自行使用poi生成电子表格
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		Dto inDto = httpModel.getInDto();
		String message = "";
		TaskFileUploadPO po = taskFileUploadDao.selectByKey(inDto.getInteger("file_id"));

		/*****************************
		 * mongoDB 文件上传下载 begin
		 ******************************/
		String fileCode = po.getFile_code();
		if (fileCode == null || fileCode.equals("")) {
			message = "该文件不存在，请检查后再操作！";
			httpModel.setOutMsg(message);
		}

//		GridFSDBFile gfs = findByFileCode(fileCode);
		GridFSDBFile gfs = mongoDBService.findByFileCode(fileCode);

		try {
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(po.getFile_title(),"UTF-8") + ";");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
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