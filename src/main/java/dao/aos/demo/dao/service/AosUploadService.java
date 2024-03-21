package aos.demo.dao.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.excel.xls.ExcelExporter_week;
import aos.framework.core.excel.xls.ExcelReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import aos.framework.core.dao.SqlDao;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import aos.demo.dao.AosUploadDao;
import aos.demo.dao.po.AosUploadPO;

/**
 * <b>aos_upload[aos_upload]业务逻辑层</b>
 * 
 * @author yj
 * @date 2017-11-14 14:47:18
 */
 @Service
 public class AosUploadService{
 	private static Logger logger = LoggerFactory.getLogger(AosUploadService.class);
 	@Autowired
	private AosUploadDao aosUploadDao;
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
		httpModel.setViewPath("showcase/upload/upload.jsp");
	}
	/**
	 * 初始化视图EditorMD
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initEditor(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("showcase/upload/EditorMD.jsp");
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
		AosUploadPO aosUploadPO=new AosUploadPO();
		aosUploadPO.setFileid(idService.nextValue("seq_aos_upload").intValue());
		aosUploadPO.copyProperties(inDto);
		aosUploadDao.insert(aosUploadPO);
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
		AosUploadPO aosUploadPO=new AosUploadPO();
		aosUploadPO.copyProperties(inDto);
		aosUploadDao.updateByKey(aosUploadPO);
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
		String[] codes = inDto.getString("fileid").split(",");
		for(int a=0; a<codes.length;a++){
			if(!codes[a].isEmpty()){
				AosUploadPO dto = new AosUploadPO();
				dto = aosUploadDao.selectByKey(Integer.parseInt(codes[a]));
				if(AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getPath())){
					String path = dto.getPath();
					File file = new File(path);
					file.delete();
				}
				aosUploadDao.deleteByKey(Integer.parseInt(codes[a]));
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
		AosUploadPO aosUploadPO=aosUploadDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(aosUploadPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<AosUploadPO> aosUploadPOs = aosUploadDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(aosUploadPOs, inDto.getPageTotal()));
	}
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<AosUploadPO> faPOs = aosUploadDao.list(inDto);
		ExcelExporter exporter=new ExcelExporter();
		Dto paramsDto=Dtos.newDto();
		paramsDto.put("reportTitle","测试导出");
		paramsDto.put("dcr", httpModel.getUserModel().getName());
		paramsDto.put("dcsj", AOSUtils.getDateStr());
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/cardReport.xls");
		exporter.setFilename("测试导出信息.xls");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
	
	/**
	 * 上传文件
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel){
		    
			AosUploadPO inDto=new AosUploadPO();
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
      				String newName="";
      				String url="";
      				String paths = httpModel.getRequest().getServletContext().getRealPath("uploaddata") + "/";
      				String newNameSub="";
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
                            filename = filename.substring(filename.lastIndexOf("\\")+1);
                            inDto.setTitle( filename);
                            inDto.setFilesize(myfile.getSize()+"");
                            inDto.setPath(savePath + filename);
                            inDto.setLoadurl(saveURL + filename);
                            inDto.setManin_id(httpModel.getInDto().getString("manin_id"));
                            aosUploadDao.insert(inDto);
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
		AosUploadPO po = aosUploadDao.selectByKey(inDto.getInteger("fileid"));
		File file = new File(po.getPath());
		
		 File fileToCreate = new File(po.getPath());
         if (!fileToCreate.exists()) {
        	 message="该文件不存在，请检查后再操作！";
        	 httpModel.setOutMsg(message);
         }else{
        	 String filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"),po.getTitle());
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
	/**
	 * excel数据的导入
	 * @param httpModel
	 */
	public void importExcelFile(HttpModel httpModel){
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
         			String metaData = "fileid,title,path,filesize,remark,loadurl";
         			ExcelReader excelReader = new ExcelReader(metaData, myfile.getInputStream());
         			List<Dto> list = excelReader.read(3,1);
        			for(int a=0;a<list.size();a++){
        				AosUploadPO aosUploadPO=new AosUploadPO();
        				aosUploadPO.copyProperties(list.get(a));
        				aosUploadDao.insert(aosUploadPO);
        				aosUploadPO.clear();
        			}
  				}
  			}
  		}catch(Exception e){
  			e.printStackTrace();
  		}        
        String message="{success:true,msg:'导入成功！'}";
        httpModel.setOutMsg(message);
	}
	
	/**
	 * 导出Excel_DIY
	 * 
	 * @param httpModel
	 */
	public void exportDIYExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<AosUploadPO> faPOs = aosUploadDao.list(inDto);
		Dto paramsDto=Dtos.newDto();
		paramsDto.put("reportTitle", "测试导出");
		paramsDto.put("reportTitle2", "测试导出2");
		paramsDto.put("dcr", httpModel.getUserModel().getName());
		paramsDto.put("dcsj", AOSUtils.getDateStr());
		paramsDto.put("rowTitle1", "标题1");//第一个list 对应的标题行  *必填
		paramsDto.put("rowTitle2", "标题2");//第二个list 对应的标题行  *必填
		paramsDto.put("rowTitle3", "标题3");//第三个list 对应的标题行  *必填
		paramsDto.put("data_row", "3");//数据从多少行开始写入 从0开始  *必填
		List allList = new ArrayList();
        List sList = new ArrayList();
        Dto smap = Dtos.newDto();
        smap.put("num", 1);
        smap.put("item_name", "testname");
        smap.put("unit", "个");
        smap.put("month1", "23.23");
        smap.put("month2", "23.23");
        smap.put("month3", "23.23");
        smap.put("sum", "23.23");
        smap.put("appo_flag", "appo_flag");
        smap.put("gs_remark", "gs_remark");
        smap.put("remark", " ");
        smap.put("week","3");
		sList.add(smap);
        List cList = new ArrayList();
        Dto cmap = Dtos.newDto();
        cmap.put("c_num", 1);
        cmap.put("c_item_name", "item_name");
        cmap.put("c_unit", "unit");
        cmap.put("c_month1", "12.12");
        cmap.put("c_month2", "13.12");
        cmap.put("c_month3", "14.12");
        cmap.put("c_sum", "12.12");
        cmap.put("appo_flag", "12.12");
        cmap.put("gs_remark", "12.12");
        cmap.put("c_remark", "remark");
		cList.add(cmap);
		 Dto cmap2 = Dtos.newDto();
		 cmap2.put("c_num", 2);
		 cmap2.put("c_item_name", "item_name2");
		 cmap2.put("c_unit", "unit");
		 cmap2.put("c_month1", "22.12");
		 cmap2.put("c_month2", "23.12");
        cmap2.put("c_month3", "24.12");
        cmap2.put("c_sum", "22.12");
        cmap2.put("appo_flag", "22.12");
        cmap2.put("gs_remark", "22.12");
        cmap2.put("c_remark", "remark");
        cList.add(cmap2);
        Dto cmap3 = Dtos.newDto();
		 cmap3.put("c_num", 3);
		 cmap3.put("c_item_name", "item_name3");
		 cmap3.put("c_unit", "unit");
		 cmap3.put("c_month1", "22.12");
		 cmap3.put("c_month2", "23.12");
       cmap3.put("c_month3", "24.12");
       cmap3.put("c_sum", "22.12");
       cmap3.put("appo_flag", "22.12");
       cmap3.put("gs_remark", "22.12");
       cmap3.put("c_remark", "remark");
       cList.add(cmap3);
        List rList = new ArrayList();
        
        Dto rmap_t = Dtos.newDto();
        rmap_t.put("r_num", "序号");
        rmap_t.put("r_item_name", "项目名称");
        rmap_t.put("r_unit", "单位");
        rmap_t.put("r_month1", "1月");
        rmap_t.put("r_sum", "本季累计");
		rList.add(rmap_t);
        
        
        Dto rmap = Dtos.newDto();
        rmap.put("r_num", 1);
        rmap.put("r_item_name", "r_item_name");
        rmap.put("r_unit", "unit");
        rmap.put("r_month1", "33.33");
        rmap.put("r_month2", "33.33");
        rmap.put("r_month3", "33.33");
        rmap.put("r_sum", "33.33");
        rmap.put("appo_flag", "1");
        rmap.put("gs_remark", "gs_remark");
        rmap.put("r_remark", " ");
        rmap.put("week","3");
		rList.add(rmap);
		allList.add(sList);
        allList.add(cList);
        allList.add(rList);
        paramsDto.put("countXmid", new Integer(allList.size()));
        
        ExcelExporter_week exporter=new ExcelExporter_week();
		exporter.setData(paramsDto, allList);
//		exporter.setTemplatePath("/export/excel/hisDateQuarterReport2.xls");
		exporter.setTemplatePath("/export/excel/hisDateQuarterReport.xls");
		exporter.setFilename("测试导出信息.xls");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
 }