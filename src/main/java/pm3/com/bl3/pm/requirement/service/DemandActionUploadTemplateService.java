package com.bl3.pm.requirement.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
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

import com.bl3.pm.mongodb.service.MongoDBService;
import com.bl3.pm.requirement.dao.DemandActionUploadTemplateDao;
import com.bl3.pm.requirement.dao.po.DemandActionUploadTemplatePO;
import com.bl3.pm.task.dao.po.TaskImportTemplatePO;
import com.mongodb.gridfs.GridFSDBFile;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

/**
 * <b>re_demand_action_upload_template[re_demand_action_upload_template]业务逻辑层</b>
 * 
 * @author zhaojiaqi
 * @date 2020-09-06 09:13:27
 */
 @Service
 public class DemandActionUploadTemplateService{
 	private static Logger logger = LoggerFactory.getLogger(DemandActionUploadTemplateService.class);
 	@Autowired
	private DemandActionUploadTemplateDao demandActionUploadTemplateDao;
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
		httpModel.setViewPath("demandActionUploadTemplate/demandActionUploadTemplate_list.jsp");
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
		DemandActionUploadTemplatePO demandActionUploadTemplatePO=new DemandActionUploadTemplatePO();
		demandActionUploadTemplatePO.copyProperties(inDto);
		demandActionUploadTemplateDao.insert(demandActionUploadTemplatePO);
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
		DemandActionUploadTemplatePO demandActionUploadTemplatePO=new DemandActionUploadTemplatePO();
		demandActionUploadTemplatePO.copyProperties(inDto);
		demandActionUploadTemplateDao.updateByKey(demandActionUploadTemplatePO);
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
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			demandActionUploadTemplateDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	
	public void importFile(HttpModel httpModel) {
		// 文件编码需唯一，根据文件编码，从mongoDB中获取对应的文件
		String fileCodeStr = "";

		int userid = httpModel.getUserModel().getId();
		DemandActionUploadTemplatePO inDto = new DemandActionUploadTemplatePO();

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
//						int fileCode = idService.nextValue("seq_temp_demand_upload").intValue();
						int fileCode = idService.nextValue("seq_mould_demand_upload").intValue();
						
						// 文件编号需唯一，根据此编号在mongoDB中找到对应的文件，在编号前加上前缀，避免编号重复
						fileCodeStr = "demand_mould_" + String.valueOf(fileCode);
//						fileCodeStr = "demand_temp_" + String.valueOf(fileCode);
						filename = filename.substring(filename.lastIndexOf("\\") + 1);
						inDto.setFile_code(fileCodeStr);
						inDto.setFile_title(filename);
						inDto.setFile_size(myfile.getSize() + "");
						inDto.setCreate_user_id(userid);
						inDto.setCreate_time(AOSUtils.getDateTime());
						demandActionUploadTemplateDao.insert(inDto);
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
	 * 下载导入文件
	 * @param httpModel
	 */
	public void downloadFile(HttpModel httpModel) {
		// 这里只是演示获取httpmodel获取response对象，具体的表格生成请自行使用poi生成电子表格
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		Dto inDto = httpModel.getInDto();
		String message = "";
		DemandActionUploadTemplatePO po = demandActionUploadTemplateDao.selectOne(inDto);

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
	
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		DemandActionUploadTemplatePO demandActionUploadTemplatePO=demandActionUploadTemplateDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(demandActionUploadTemplatePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<DemandActionUploadTemplatePO> demandActionUploadTemplatePOs = demandActionUploadTemplateDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(demandActionUploadTemplatePOs, inDto.getPageTotal()));
	}
 }