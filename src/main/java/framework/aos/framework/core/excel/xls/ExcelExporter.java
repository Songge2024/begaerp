package aos.framework.core.excel.xls;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aos.framework.core.excel.ExcelData;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSUtils;


/**
 * Excel导出器(适用于WebAPP)
 * 
 * @author Remexs
 */
public class ExcelExporter {

	private String templatePath;
	private Dto parametersDto;
	private List parametersList;
	private List fieldsList;
	private String filename = "Excel.xls";

	/**
	 * 设置数据
	 * 
	 * @param pDto
	 *            参数集合
	 * @param pList
	 *            字段集合
	 */
	public void setData(Dto pDto, List pList) {
		parametersDto = pDto;
		fieldsList = pList;
	}
	
	/**
	 * 设置数据
	 * 
	 * @param pDto
	 *            参数集合
	 * @param pList
	 *            字段集合
	 */
	public void setData(List pDto, List pList) {
		parametersList = pDto;
		fieldsList = pList;
	}

	/**
	 * 导出Excel
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void export(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.ms-excel");
		filename = AOSUtils.encodeChineseDownloadFileName(request.getHeader("USER-AGENT"), getFilename());
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		ExcelData excelData = new ExcelData(parametersDto, fieldsList);
		ExcelTemplate excelTemplate = new ExcelTemplate();
		excelTemplate.setTemplatePath(getTemplatePath());
		excelTemplate.parse(request);
		ExcelFiller excelFiller = new ExcelFiller(excelTemplate, excelData);
		ByteArrayOutputStream bos = excelFiller.fill(request);
		ServletOutputStream os = response.getOutputStream();
		os.write(bos.toByteArray());
		os.flush();
		os.close();
	}
	
	/**
	 * 导出Excel，支持tab页
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void export_tab(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.ms-excel");
		filename = AOSUtils.encodeChineseDownloadFileName(request.getHeader("USER-AGENT"), getFilename());
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		ExcelData excelData = new ExcelData(parametersList, fieldsList);
		ExcelTemplate excelTemplate = new ExcelTemplate();
		excelTemplate.setTemplatePath(getTemplatePath());
		excelTemplate.parse(request);
		ExcelFiller excelFiller = new ExcelFiller(excelTemplate, excelData);
		ByteArrayOutputStream bos = excelFiller.fill_tab(request);
		ServletOutputStream os = response.getOutputStream();
		os.write(bos.toByteArray());
		os.flush();
		os.close();
	}
	/**
	 * 导出Excel，支持tab页
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void export_tabe(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.ms-excel");
		filename = AOSUtils.encodeChineseDownloadFileName(request.getHeader("USER-AGENT"), getFilename());
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		ExcelData excelData = new ExcelData(parametersList, fieldsList);
		ExcelTemplate excelTemplate = new ExcelTemplate();
		excelTemplate.setTemplatePath(getTemplatePath());
		excelTemplate.parse(request);
		ExcelFiller excelFiller = new ExcelFiller(excelTemplate, excelData);
		ByteArrayOutputStream bos = excelFiller.fill_tabe(request);
		ServletOutputStream os = response.getOutputStream();
		os.write(bos.toByteArray());
		os.flush();
		os.close();
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public Dto getParametersDto() {
		return parametersDto;
	}

	public void setParametersDto(Dto parametersDto) {
		this.parametersDto = parametersDto;
	}

	public List getFieldsList() {
		return fieldsList;
	}

	public void setFieldsList(List fieldsList) {
		this.fieldsList = fieldsList;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
}
