package com.bl3.pm.process.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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

import com.bl3.pm.mongodb.service.MongoDBService;
import com.bl3.pm.process.dao.ProcessDao;
import com.bl3.pm.process.dao.ProcessFileUploadDao;
import com.bl3.pm.process.dao.ProcessFiletypeDao;
import com.bl3.pm.process.dao.po.ProcessFileUploadPO;
import com.bl3.pm.process.dao.po.ProcessFiletypePO;
import com.bl3.pm.process.dao.po.ProcessPO;
import com.google.common.collect.Lists;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelReader;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSPropertiesHandler;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * <b>pr_process_file_upload[pr_process_file_upload]业务逻辑层</b>
 * 
 * @author heying
 * @date 2017-12-12 15:33:22
 */
@Service
public class ProcessFileUploadService {
	private static Logger logger = LoggerFactory.getLogger(ProcessFileUploadService.class);
	@Autowired
	private ProcessFileUploadDao processFileUploadDao;
	@Autowired
	private ProcessFiletypeDao processFiletypeDao;
	@Autowired
	private ProcessDao processDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private MongoDBService mongoDBService;

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id  = "";
		String proj_name = "";
		if(getDto.get("proj_id")!=null){
	    proj_id = getDto.get("proj_id").toString();
	    proj_name = getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		
		httpModel.setViewPath("pm3/process/processfilemanage/processfile_list.jsp");
	}

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	// @Transactional(readOnly:"",rollbackFor:AOSException.class)
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// inDto.remove("id");
		ProcessFileUploadPO processFileUploadPO = new ProcessFileUploadPO();
		processFileUploadPO.setFile_id(idService.nextValue("seq_pr_process_file_upload").intValue());
		processFileUploadPO.copyProperties(inDto);
		processFileUploadDao.insert(processFileUploadPO);
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
		// inDto.remove("id");
		ProcessFileUploadPO processFileUploadPO = new ProcessFileUploadPO();
		processFileUploadPO.copyProperties(inDto);
		processFileUploadDao.updateByKey(processFileUploadPO);
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
				ProcessFileUploadPO dto = new ProcessFileUploadPO();
				dto = processFileUploadDao.selectByKey(Integer.parseInt(codes[a]));
				if (AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getFile_path())) {
					String path = dto.getFile_path();
					File file = new File(path);
					file.delete();
				}
				processFileUploadDao.deleteByKey(Integer.parseInt(codes[a]));
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
		ProcessFileUploadPO processFileUploadPO = processFileUploadDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(processFileUploadPO));
	}

	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessFileUploadPO> processFileUploadPOs = processFileUploadDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processFileUploadPOs, inDto.getPageTotal()));
	}

	/**
	 * 根据项目ID 过程树分页查询
	 * 
	 * @param httpModel
	 */
	public void byProcPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String tree_param = (String) inDto.get("tree_param");
		if (AOSUtils.isNotEmpty(tree_param)) {
			if (!tree_param.equals("0")) {
				int index = tree_param.indexOf("-");
				if (index <= 0) {
					inDto.put("rootdir_id", tree_param);
				} else {
					inDto.put("process_id", tree_param.substring(index + 1));
				}
			}
		}
		List<ProcessFileUploadPO> processFileUploadPOs = processFileUploadDao.byProcListPage(inDto);
		for (ProcessFileUploadPO po : processFileUploadPOs) {
			long file_size = Long.parseLong(po.getFile_size());
			String str_file_size = getPrintSize(file_size);
			po.setFile_size(str_file_size);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(processFileUploadPOs, inDto.getPageTotal()));
	}

	/**
	 * excel数据的导入
	 * 
	 * @param httpModel
	 */
	public void importExcelFile(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
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
					String metaData = "file_id, process_id, proj_id, proc_filetype_id, file_title,file_path,file_size,file_remark,file_url";
					ExcelReader excelReader = new ExcelReader(metaData, myfile.getInputStream());
					List<Dto> list = excelReader.read(3, 1);
					for (int a = 0; a < list.size(); a++) {
						ProcessFileUploadPO processFileUploadPO = new ProcessFileUploadPO();
						processFileUploadPO.copyProperties(list.get(a));
						processFileUploadDao.insert(processFileUploadPO);
						processFileUploadPO.clear();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String message = "{success:true,msg:'导入成功！'}";
		httpModel.setOutMsg(message);
	}

	/**
	 * 获取模块导航树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getProcessListTreeData(HttpModel httpModel) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		Dto inDto = httpModel.getInDto();
		// String parent_id = (String) inDto.get("parent_id");
		if (AOSUtils.isEmpty(inDto.get("proj_id"))) {
			return;
		}

		// 父节点
		TreeNode parentNode = new TreeNode();
		String parent_id = "0";
		parentNode.setId(parent_id);
		parentNode.setText("全部");
		parentNode.setLeaf(false);
		parentNode.setParentId("00");
		parentNode.setExpanded(true);

		// 获取根目录节点
		List<ProcessPO> rootdirPOs = processDao.rootdirList(inDto);
		// List<Dto> modelDtos = Lists.newArrayList();
		for (ProcessPO rootdirPO : rootdirPOs) {
			TreeNode treeRootNode = new TreeNode();
			treeRootNode.setId(rootdirPO.getRootdir_id().toString());
			treeRootNode.setText(rootdirPO.getRootdir_name());
			treeRootNode.setLeaf(false);
			treeRootNode.setParentId(parent_id);
			treeRootNode.setExpanded(true);

			// 获取子目录节点
			inDto.put("rootdir_id", rootdirPO.getRootdir_id());
			List<ProcessPO> subdirPOs = processDao.subdirList(inDto);
			for (ProcessPO subdirPO : subdirPOs) {
				TreeNode treeSubNode = new TreeNode();
				treeSubNode.setId(treeRootNode.getId() + "-" + subdirPO.getProcess_id().toString());
				treeSubNode.setText(subdirPO.getProcess_name());
				treeSubNode.setParentId(treeRootNode.getId());
				treeSubNode.setLeaf(true);
				treeSubNode.setExpanded(false);
				treeRootNode.appendChild(treeSubNode);
			}

			parentNode.appendChild(treeRootNode);
		}
		// }
		treeNodes.add(parentNode);
		String treeJson = AOSJson.toJson(treeNodes);
		httpModel.setOutMsg(treeJson);
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

		// 获取文件版本号
		String version_num = paramDto.getString("version_num");

		// 根据proc_filetype_id查询项目ID和过程ID
		ProcessFiletypePO po = processFiletypeDao.selectByKey(paramDto.getInteger("proc_filetype_id"));
		int proj_id = po.getProj_id();
		paramDto.put("proj_id", proj_id);
		paramDto.put("process_id", po.getProcess_id());

		int userid = httpModel.getUserModel().getId();
		ProcessFileUploadPO inDto = new ProcessFileUploadPO();
		// 获取web应用根路径,也可以直接指定服务器任意盘符路径
		String savePath = httpModel.getRequest().getServletContext().getRealPath("uploaddata") + "/";

		// 设置数据库保存路径
		String http = httpModel.getRequest().getScheme();
		String server = httpModel.getRequest().getServerName();
		int port = httpModel.getRequest().getServerPort();
		String path = httpModel.getRequest().getContextPath();
		String saveURL = http + "://" + server + ":" + port + path + "\\uploaddata/";
		// String savePath = "d:/upload/";
		// 检查路径是否存在,如果不存在则创建之
		File file = new File(savePath);
		if (!file.exists()) {
			file.mkdir();
		}
		// 文件按项目ID归档
		savePath = savePath + "processfile_manage/";
		saveURL = saveURL + "processfile_manage/";
		File file1 = new File(savePath);
		if (!file1.exists()) {
			file1.mkdir();
		}
		savePath = savePath + proj_id + "/";
		saveURL = saveURL + proj_id + "/";
		File file2 = new File(savePath);
		if (!file2.exists()) {
			file2.mkdir();
		}
		savePath = savePath + version_num + "/";
		saveURL = saveURL + version_num + "/";
		File file3 = new File(savePath);
		if (!file3.exists()) {
			file3.mkdir();
		}
		System.out.println(savePath);

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
						File fileToCreate = new File(savePath, filename);
						if (fileToCreate.exists()) {
							message = "{success:true,msg:'该文件已经存在，请修改版本号再操作！'}";
							break;
						}
						// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如： c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
						// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
						int fileCode = idService.nextValue("seq_pr_process_file_upload").intValue();

						// 文件编号需唯一，根据此编号在mongoDB中找到对应的文件，在编号前加上前缀，避免编号重复
						fileCodeStr = "upload_files_" + String.valueOf(fileCode);
						inDto.setFile_id(fileCode);
						filename = filename.substring(filename.lastIndexOf("\\") + 1);
						// filename = filename.replace(".", "-"+version_num+".");
						inDto.setFile_code(fileCodeStr);
						inDto.setProj_id(paramDto.getInteger("proj_id"));
						inDto.setProcess_id(paramDto.getInteger("process_id"));
						inDto.setProc_filetype_id(paramDto.getInteger("proc_filetype_id"));
						inDto.setFile_title(filename);
						inDto.setFile_size(myfile.getSize() + "");
						inDto.setFile_path(savePath + filename);
						inDto.setFile_url(saveURL + filename);
						inDto.setVersion_num(version_num);
						inDto.setCreate_user_id(userid);
						inDto.setCreate_time(AOSUtils.getDateTime());
						inDto.setState("1");
						processFileUploadDao.insert(inDto);
						inDto.clear();
						// 获取item中的上传文件的输入流
						InputStream in = myfile.getInputStream();

						/*****************************
						 * mongoDB 文件上传下载 begin
						 ******************************/
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
	/*public static void save(InputStream in, Object id, String fileName) {
		DBObject query = new BasicDBObject("_id", id);
		GridFS gridFS = new GridFS(MongoDBService.getDB());
		GridFSDBFile gridFSDBFile = gridFS.findOne(query);
		if (gridFSDBFile == null) {
			GridFSInputFile gridFSInputFile = gridFS.createFile(in);
			gridFSInputFile.setId(id);
			gridFSInputFile.setFilename(fileName);
			gridFSInputFile.save();
		}
	}*/

	/**
	 * 据id获取文件
	 * 
	 * @param id
	 * @return
	 */
	/*public static GridFSDBFile findByFileCode(Object id) {
		DBObject query = new BasicDBObject("_id", id);
		GridFS gridFS = new GridFS(MongoDBService.getDB());
		GridFSDBFile gridFSDBFile = gridFS.findOne(query);
		return gridFSDBFile;
	}*/

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
		ProcessFileUploadPO po = processFileUploadDao.selectByKey(inDto.getInteger("file_id"));

		/*****************************
		 * mongoDB 文件上传下载 begin
		 ******************************/
		String fileCode = po.getFile_code();
		if (fileCode == null || fileCode.equals("")) {
			message = "该文件不存在，请检查后再操作！";
			httpModel.setOutMsg(message);
		}

		GridFSDBFile gfs = mongoDBService.findByFileCode(fileCode);

		try {
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(po.getFile_title(),"UTF-8") + ";");
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

		/*****************************
		 * mongoDB 文件上传下载 end
		 ******************************/

	}

	public void downloadFileByZip(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		String proj_name = (String) inDto.get("proj_name");
		// 把文件压缩成zip包，放在临时目录
		String tempPath = createZipFile(httpModel);
		File file = new File(tempPath);
		String filename = proj_name + AOSUtils.getDateTimeStr() + ".zip";
		filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"), filename);
		// 中文乱码转化
		try {
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(filename,"UTF-8") + ";");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		BufferedInputStream in;
		ServletOutputStream os = null;
		try {
			in = new BufferedInputStream(new FileInputStream(file));
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

	/**
	 * 创建zip文件,返回文件存放临时路径
	 * 
	 * @param httpModel
	 * @return
	 */
	public String createZipFile(HttpModel httpModel) {
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		int flag = 0;
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		String desPath = "";
		// 文件路径
		List<File> pathList = new ArrayList<File>();
		int index = 0;
		for (String file_id : selectionIds) {
			ProcessFileUploadPO po = processFileUploadDao.selectByKey(Integer.valueOf(file_id));
			if (AOSUtils.isEmpty(po)) {
				continue;
			}
			pathList.add(index, new File(po.getFile_path()));
			index++;
		}
		// String desPath =
		// request.getSession().getServletContext().getRealPath("/upload/zip/");
		desPath = request.getSession().getServletContext().getRealPath("/zipdown//");
		String fileName = "temp.zip";
		File file = new File(desPath);
		if (!file.exists()) {
			file.mkdir();
		}
		desPath = desPath + fileName;
		// System.out.println("临时文件="+desPath);
		File zipFile = new File(desPath);
		ZipOutputStream zipStream = null;
		FileInputStream zipSource = null;
		BufferedInputStream bufferStream = null;
		ServletOutputStream os = null;
		try {
			// 构造最终压缩包的输出流
			zipStream = new ZipOutputStream(new FileOutputStream(zipFile));
			for (int i = 0; i < pathList.size(); i++) {
				File filePath = pathList.get(i);
				// 将需要压缩的文件格式化为输入流
				zipSource = new FileInputStream(filePath);
				// 压缩条目不是具体独立的文件，而是压缩包文件列表中的列表项，称为条目，就像索引一样
				ZipEntry zipEntry = new ZipEntry(filePath.getName());
				// 定位该压缩条目位置，开始写入文件到压缩包中
				zipStream.putNextEntry(zipEntry);
				// 输入缓冲流
				bufferStream = new BufferedInputStream(zipSource, 1024 * 10);
				int read = 0;
				// 创建读写缓冲区
				byte[] buf = new byte[1024 * 10];
				while ((read = bufferStream.read(buf, 0, 1024 * 10)) != -1) {
					zipStream.write(buf, 0, read);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			// 关闭流
			try {
				if (null != bufferStream)
					bufferStream.close();
				if (null != zipStream)
					zipStream.close();
				if (null != zipSource)
					zipSource.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return desPath;
	}

	public String getPrintSize(long size) {
		// 如果字节数少于1024，则直接以B为单位，否则先除于1024，后3位因太少无意义
		if (size < 1024) {
			return String.valueOf(size) + "B";
		} else {
			size = size / 1024;
		}
		// 如果原字节数除于1024之后，少于1024，则可以直接以KB作为单位
		// 因为还没有到达要使用另一个单位的时候
		// 接下去以此类推
		if (size < 1024) {
			return String.valueOf(size) + "KB";
		} else {
			size = size / 1024;
		}
		if (size < 1024) {
			// 因为如果以MB为单位的话，要保留最后1位小数，
			// 因此，把此数乘以100之后再取余
			size = size * 100;
			return String.valueOf((size / 100)) + "." + String.valueOf((size % 100)) + "MB";
		} else {
			// 否则如果要以GB为单位的，先除于1024再作同样的处理
			size = size * 100 / 1024;
			return String.valueOf((size / 100)) + "." + String.valueOf((size % 100)) + "GB";
		}
	}

	/**
	 * 查询文件类型
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxFiletypeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProcessFileUploadDao.listCombBoxFiletypeData", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
}