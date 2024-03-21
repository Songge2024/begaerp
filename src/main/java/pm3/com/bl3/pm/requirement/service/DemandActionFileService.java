package com.bl3.pm.requirement.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

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

import com.bl3.pm.mongodb.service.MongoDBService;
import com.bl3.pm.requirement.dao.DemandActionFileDao;
import com.bl3.pm.requirement.dao.po.DemandActionFilePO;
import com.mongodb.gridfs.GridFSDBFile;

/**
 * <b>re_demand_action_file[re_demand_action_file]业务逻辑层</b>
 * 
 * @author yj
 * @date 2017-12-24 17:03:57
 */
 @Service
 public class DemandActionFileService{
 	private static Logger logger = LoggerFactory.getLogger(DemandActionFileService.class);
 	@Autowired
	private DemandActionFileDao demandActionFileDao;
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
		httpModel.setViewPath("demandActionFile/demandActionFile_list.jsp");
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
		
		// 文件编码需唯一，根据文件编码，从mongoDB中获取对应的文件
		String demandFileCodeStr = "";
				
		DemandActionFilePO demandActionFilePO=new DemandActionFilePO();
		demandActionFilePO.copyProperties(inDto);
		demandActionFilePO.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time=AOSUtils.getDateTime();
		demandActionFilePO.setCreate_time(create_time);
		demandActionFilePO.setState("1");
		// 获取web应用根路径,也可以直接指定服务器任意盘符路径
		String savePath = httpModel.getRequest().getServletContext().getRealPath("uploaddata") + "/";
		
		//设置数据库保存路径
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
		// 文件按天归档
		savePath = savePath + AOSUtils.getDateStr() + "/";
		saveURL = saveURL + AOSUtils.getDateStr() + "/";
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
	          //List<FileItem> list = upload.parseRequest(httpModel.getRequest());
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
	                         int demandFileCode = idService.nextValue("seq_re_demand_action_file").intValue();
	                         
	                         // 文件编号需唯一，根据此编号在mongoDB中找到对应的文件，在编号前加上前缀，避免编号重复
	                         demandFileCodeStr = "upload_demandFad_" + String.valueOf(demandFileCode);
	                         demandActionFilePO.setFad_id(demandFileCode);
	                         demandActionFilePO.setFad_code(demandFileCodeStr);
	                        filename = filename.substring(filename.lastIndexOf("\\")+1);
	                        demandActionFilePO.setFad_name( filename);
	                        demandActionFilePO.setFad_size(myfile.getSize()+"");
	                        demandActionFilePO.setFad_path(savePath + filename);
	                        demandActionFilePO.setFad_adress(saveURL + filename);
	                        demandActionFileDao.insert(demandActionFilePO);
	                        inDto.clear();
	                         //获取item中的上传文件的输入流
	                        InputStream in = myfile.getInputStream();
//	                         //创建一个文件输出流
//	                         FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
//	                         //创建一个缓冲区
//	                         byte buffer[] = new byte[1024];
//	                         //判断输入流中的数据是否已经读完的标识
//	                        int len = 0;
//	                        //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
//	                        while((len=in.read(buffer))>0){
//	                            //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
//	                           out.write(buffer, 0, len);
//	                        }
//	                        //关闭输入流
//	                        in.close();
//	                        //关闭输出流
//	                        out.close();
	                        
	                        /*****************************
							 * mongoDB 文件上传下载 begin
							 ******************************/
							mongoDBService.save(in, demandFileCodeStr, filename);// 保存文件
							/*****************************
							 * mongoDB 文件上传下载 end
							 ******************************/
	                        
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
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		DemandActionFilePO demandActionFilePO=new DemandActionFilePO();
		demandActionFilePO.copyProperties(inDto);
		demandActionFileDao.updateByKey(demandActionFilePO);
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
		List<Dto>userList=sqlDao.list("com.bl3.pm.requirement.dao.DemandActionFileDao.queryPmAon", inDto);
		String userid = httpModel.getUserModel().getId().toString();
		String[] selectionIds = inDto.getRows();
		for(int a=0;a<userList.size();a++){
			Dto userDto=userList.get(a);
			if(userid.equals(userDto.getString("id"))||userid.equals(inDto.getString("create_user_id"))){
				for (String id : selectionIds) {
					DemandActionFilePO demandActionFilePO=new DemandActionFilePO();
					demandActionFilePO.copyProperties(inDto);
					Date update_time=AOSUtils.getDateTime();
					demandActionFilePO.setUpdate_time(update_time);
					demandActionFilePO.setState("-1");
					demandActionFilePO.setFad_id(Integer.valueOf(id));
					demandActionFileDao.updateByKey(demandActionFilePO);
				}
				httpModel.setOutMsg("删除成功");
			}else{
				httpModel.setOutMsg("您没有权限删除该数据！");
				continue;
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
		DemandActionFilePO demandActionFilePO=demandActionFileDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(demandActionFilePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("state", "1");
		List<DemandActionFilePO> demandActionFilePOs = demandActionFileDao.list(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(demandActionFilePOs, demandActionFilePOs.size()));
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
		DemandActionFilePO po = demandActionFileDao.selectByKey(inDto.getInteger("file_id"));
		
		/*****************************
		 * mongoDB 文件上传下载 begin
		 ******************************/
		String fadCode = po.getFad_code();
		if (fadCode == null || fadCode.equals("")) {
			message = "该文件不存在，请检查后再操作！";
			httpModel.setOutMsg(message);
		}
		GridFSDBFile gfs = mongoDBService.findByFileCode(fadCode);
		try {
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(po.getFad_name(),"UTF-8") + ";");
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
 }