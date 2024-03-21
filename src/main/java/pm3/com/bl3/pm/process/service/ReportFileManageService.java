package com.bl3.pm.process.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
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
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.process.dao.ReportFileManageDao;
import com.bl3.pm.process.dao.po.ReportFileManagePO;
import com.bl3.pm.process.dao.po.ProcessFileUploadPO;
import com.bl3.pm.process.dao.po.ProcessFiletypePO;
import com.bl3.pm.process.dao.po.ReportFileManagePO;

/**
 * <b>pr_report_file_manage[pr_report_file_manage]业务逻辑层</b>
 * 
 * @author heying
 * @date 2018-01-11 11:26:58
 */
 @Service
 public class ReportFileManageService{
 	private static Logger logger = LoggerFactory.getLogger(ReportFileManageService.class);
 	@Autowired
	private ReportFileManageDao reportFileManageDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/process/reportFileManage/reportFileManage_list.jsp");
	}
	
	/**
	 * 初始化年终总结文档上传视图
	 * @param httpModel
	 */
	public void uploadInit(HttpModel httpModel){
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/process/reportFileUpload/reportFileUpload_list.jsp");
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
		ReportFileManagePO reportFileManagePO=new ReportFileManagePO();
		reportFileManagePO.setRe_file_id(idService.nextValue("seq_pr_report_file_manage").intValue());
		reportFileManagePO.copyProperties(inDto);
		reportFileManageDao.insert(reportFileManagePO);
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
		ReportFileManagePO reportFileManagePO=new ReportFileManagePO();
		reportFileManagePO.copyProperties(inDto);
		reportFileManageDao.updateByKey(reportFileManagePO);
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
		for(int a=0; a<codes.length;a++){
			if(!codes[a].isEmpty()){
				ReportFileManagePO dto = new ReportFileManagePO();
				dto = reportFileManageDao.selectByKey(Integer.parseInt(codes[a]));
				if(AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getRe_file_path())){
					String path = dto.getRe_file_path();
					File file = new File(path);
					file.delete();
				}
				reportFileManageDao.deleteByKey(Integer.valueOf(codes[a]));
			}
		}
		httpModel.setOutMsg("删除成功");
	}
	
	public void submit(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] codes = inDto.getString("file_id").split(",");
		for(int a=0; a<codes.length;a++){
			if(!codes[a].isEmpty()){
				ReportFileManagePO po = new ReportFileManagePO();
				po.setRe_file_id(Integer.valueOf(codes[a]));
				po.setState("1");
				reportFileManageDao.updateByKey(po);
			}
		}
		httpModel.setOutMsg("提交成功");
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ReportFileManagePO reportFileManagePO=reportFileManageDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(reportFileManagePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String user_param = inDto.getString("user_param");
		
		
		if(AOSUtils.isNotEmpty(user_param)){
			int index = user_param.indexOf("org_");
			if(index <= -1){
				inDto.put("create_user_id", user_param);
			}else{
				int org_id = Integer.parseInt(user_param.substring(4));
				inDto.put("org_id", org_id);
			}
		}
		
		List<ReportFileManagePO> reportFileManagePOs = reportFileManageDao.listPage(inDto);
		for(ReportFileManagePO po : reportFileManagePOs){
			long file_size = Long.parseLong(po.getRe_file_size());
			String str_file_size = getPrintSize(file_size);
			po.setRe_file_size(str_file_size);
			//查询上传者姓名
			String create_user_name = reportFileManageDao.queryUserNameByUserId(po.getCreate_user_id());
			po.setCreate_user_name(create_user_name);
			//查询提交对象姓名
			String submit_user_name = reportFileManageDao.queryUserNameByUserId(po.getSubmit_user_id());
			po.setSubmit_user_name(submit_user_name);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(reportFileManagePOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询-当前登录人
	 * 
	 * @param httpModel
	 */
	public void currPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int userid = httpModel.getUserModel().getId();
		inDto.put("create_user_id", userid);
		List<ReportFileManagePO> reportFileManagePOs = reportFileManageDao.listPage(inDto);
		for(ReportFileManagePO po : reportFileManagePOs){
			long file_size = Long.parseLong(po.getRe_file_size());
			String str_file_size = getPrintSize(file_size);
			po.setRe_file_size(str_file_size);
			//查询上传者姓名
			String create_user_name = reportFileManageDao.queryUserNameByUserId(po.getCreate_user_id());
			po.setCreate_user_name(create_user_name);
			//查询提交对象姓名
			String submit_user_name = reportFileManageDao.queryUserNameByUserId(po.getSubmit_user_id());
			po.setSubmit_user_name(submit_user_name);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(reportFileManagePOs, inDto.getPageTotal()));
	}
	
	/**
	 * 上传文件
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel){
		Dto paramDto = httpModel.getInDto();
		
		int userid = httpModel.getUserModel().getId();
		String account = httpModel.getUserModel().getAccount();
		String username = httpModel.getUserModel().getName();
		ReportFileManagePO inDto = new ReportFileManagePO();
		// 获取web应用根路径,也可以直接指定服务器任意盘符路径
		String savePath = httpModel.getRequest().getServletContext().getRealPath("uploaddata") + "/yearfile_manage/";

		//设置数据库保存路径
		String http = httpModel.getRequest().getScheme();
		String server = httpModel.getRequest().getServerName();
		int port = httpModel.getRequest().getServerPort(); 
		String path = httpModel.getRequest().getContextPath(); 
		String saveURL = http + "://" + server + ":" + port + path + "\\uploaddata/yearfile_manage/";
		// String savePath = "d:/upload/";
		// 检查路径是否存在,如果不存在则创建之
		File file = new File(savePath);
		if (!file.exists()) {
			file.mkdir();
		}
		String cata_root = "yearfile_manage";
		String cata_name = userid + "-" + account;
		// 文件按用户ID—账号归档
		savePath = savePath + userid + "/";
		saveURL = saveURL + userid  + "/";
		File file1 = new File(savePath);
		if (!file1.exists()) {
			file1.mkdir();
		}
		//消息提示
		String message = "";
		try{//使用Apache文件上传组件处理文件上传步骤：
			//1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			//2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			//解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8"); 
			//3、判断提交上来的数据是否是上传表单的数据
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if(!isMultipart){
				//按照传统方式获取数据
				return;
			}
			//4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
			List<FileItem> list = upload.parseRequest(httpModel.getRequest());
			try{
				MultipartHttpServletRequest multipartRequest = null;
				if(httpModel.getRequest() instanceof MultipartHttpServletRequest){
					try{
						multipartRequest=(MultipartHttpServletRequest) httpModel.getRequest();
					}catch(Exception ex){
						ex.getMessage();
					}
				}
				if(multipartRequest!=null){
					Map<String,MultipartFile> fileMap =multipartRequest.getFileMap();
					
					for(Map.Entry<String,MultipartFile> entity:fileMap.entrySet()){
						MultipartFile myfile=entity.getValue();
						//得到上传的文件名称，
						String filename = myfile.getOriginalFilename();
						System.out.println(filename);
						if(filename==null || filename.trim().equals("")){
							continue;
						}
						File fileToCreate = new File(savePath, filename);
						if (fileToCreate.exists()) {
							message="{success:true,msg:'该文件已经存在，请检查后再操作！'}";
							break;
						}
						//注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
						//处理获取到的上传文件的文件名的路径部分，只保留文件名部分
						inDto.setRe_file_id(idService.nextValue("seq_pr_report_file_manage").intValue());
						filename = filename.substring(filename.lastIndexOf("\\")+1);
						inDto.setRe_file_title( filename);
						inDto.setRe_file_size(myfile.getSize()+"");
						inDto.setRe_file_path(savePath + filename);
						inDto.setRe_file_url(saveURL + filename);
						inDto.setCreate_user_id(userid);
						inDto.setCreate_time(AOSUtils.getDateTime());
						//inDto.setSubmit_user_id(paramDto.getInteger("submit_user_id"));
						inDto.setRe_file_type(paramDto.getInteger("re_file_type")); // 提交类型 1 周总结 2 月总结 3 季度总结 4 年度总结
						inDto.setRe_file_year(paramDto.getString("re_file_year"));
						inDto.setState("0"); // 0 未提交 1 已提交
						inDto.setDown_num(0); // 下载量
						reportFileManageDao.insert(inDto);
						inDto.clear();
						//获取item中的上传文件的输入流
						InputStream in = myfile.getInputStream();
						//创建一个文件输出流
						FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
						//创建一个缓冲区
						byte buffer[] = new byte[1024];
						//判断输入流中的数据是否已经读完的标识
						int len = 0;
						//循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
						while((len=in.read(buffer))>0){
							//使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
							out.write(buffer, 0, len);
						}
						//关闭输入流
						in.close();
						//关闭输出流
						out.close();
						//删除处理文件上传时生成的临时文件
						message="{success:true,msg:'上传成功！'}";

					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}catch (Exception e) {
			message= "文件上传失败！";
			e.printStackTrace();

		}
		httpModel.setOutMsg(message);
	}
	/**
	 * 文件下载
	 * @param httpModel
	 */
	public void downloadFile(HttpModel httpModel){
		// 这里只是演示获取httpmodel获取response对象，具体的表格生成请自行使用poi生成电子表格
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		Dto inDto = httpModel.getInDto();
		String message="";
		ReportFileManagePO po = reportFileManageDao.selectByKey(inDto.getInteger("re_file_id"));
		File file = new File(po.getRe_file_path());

		File fileToCreate = new File(po.getRe_file_path());
		if (!fileToCreate.exists()) {
			message="该文件不存在，请检查后再操作！";
			httpModel.setOutMsg(message);
		}else{
			String filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"),po.getRe_file_title());
			//中文乱码转化
			response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
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
	}

	public void downloadFileByZip(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		String proj_name = (String) inDto.get("proj_name");
		//把文件压缩成zip包，放在临时目录
		String tempPath = createZipFile(httpModel);
		File file = new File(tempPath);
		String filename = proj_name + AOSUtils.getDateTimeStr()+".zip";
		filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"),filename);
		//中文乱码转化
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
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
	 * @param httpModel
	 * @return
	 */
	public String createZipFile(HttpModel httpModel){
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		int flag = 0;
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		String desPath="";
		//文件路径
		List<File> pathList = new ArrayList<File>();
		int index = 0;
		for (String file_id : selectionIds) {
			ReportFileManagePO po = reportFileManageDao.selectByKey(Integer.valueOf(file_id));
			if (AOSUtils.isEmpty(po)) {
				continue;
			}
			pathList.add(index, new File(po.getRe_file_path()));
			index++;
		}
		//String desPath = request.getSession().getServletContext().getRealPath("/upload/zip/");
		desPath = request.getSession().getServletContext().getRealPath("/zipdown//");
		String fileName = "temp.zip";
		File file = new File(desPath);
		if (!file.exists()) {
			file.mkdir();
		}
		desPath = desPath + fileName;
		//		System.out.println("临时文件="+desPath);
		File zipFile = new File(desPath);
		ZipOutputStream zipStream = null;
		FileInputStream zipSource = null;
		BufferedInputStream bufferStream = null;
		ServletOutputStream os = null;
		try {
			//构造最终压缩包的输出流
			zipStream = new ZipOutputStream(new FileOutputStream(zipFile));
			for(int i =0;i<pathList.size();i++){
				File filePath = pathList.get(i);
				//将需要压缩的文件格式化为输入流
				zipSource = new FileInputStream(filePath);
				//压缩条目不是具体独立的文件，而是压缩包文件列表中的列表项，称为条目，就像索引一样
				ZipEntry zipEntry = new ZipEntry(filePath.getName());
				//定位该压缩条目位置，开始写入文件到压缩包中
				zipStream.putNextEntry(zipEntry);
				//输入缓冲流
				bufferStream = new BufferedInputStream(zipSource, 1024 * 10);
				int read = 0;
				//创建读写缓冲区
				byte[] buf = new byte[1024 * 10];
				while((read = bufferStream.read(buf, 0, 1024 * 10)) != -1)
				{
					zipStream.write(buf, 0, read);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			//关闭流
			try {
				if(null != bufferStream) bufferStream.close();
				if(null != zipStream) zipStream.close();
				if(null != zipSource) zipSource.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return desPath;
	}

	public String getPrintSize(long size) {  
		//如果字节数少于1024，则直接以B为单位，否则先除于1024，后3位因太少无意义  
		if (size < 1024) {  
			return String.valueOf(size) + "B";  
		} else {  
			size = size / 1024;  
		}  
		//如果原字节数除于1024之后，少于1024，则可以直接以KB作为单位  
		//因为还没有到达要使用另一个单位的时候  
		//接下去以此类推  
		if (size < 1024) {  
			return String.valueOf(size) + "KB";  
		} else {  
			size = size / 1024;  
		}  
		if (size < 1024) {  
			//因为如果以MB为单位的话，要保留最后1位小数，  
			//因此，把此数乘以100之后再取余  
			size = size * 100;  
			return String.valueOf((size / 100)) + "."  
			+ String.valueOf((size % 100)) + "MB";  
		} else {  
			//否则如果要以GB为单位的，先除于1024再作同样的处理  
			size = size * 100 / 1024;  
			return String.valueOf((size / 100)) + "."  
			+ String.valueOf((size % 100)) + "GB";  
		}  
	}  
	
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxUserData(HttpModel httpModel) {
		List<Dto> list = reportFileManageDao.listComboBoxUserData();
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
 }