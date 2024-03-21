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
 * @author XiongChun
 * @since 2010-08-12
 */
public class ExcelExporter_week {

	private String templatePath;
	private Dto parametersDto;
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
		ExcelTemplate_diy excelTemplate = new ExcelTemplate_diy();
		excelTemplate.setTemplatePath(getTemplatePath());
		excelTemplate.parse(request);
		ExcelFiller_week_old excelFiller = new ExcelFiller_week_old(excelTemplate, excelData);
		ByteArrayOutputStream bos = excelFiller.fill(request);
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
