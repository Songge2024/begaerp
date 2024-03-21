package aos.framework.core.excel.xls;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;



import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import aos.framework.core.utils.AOSUtils;

/**
 * 导出Excel的模板对象 (修改成poi支持)
 * @author Remexs
 */
public class ExcelTemplate {

	private Logger log = LoggerFactory.getLogger(ExcelTemplate.class);

	private List<HSSFCell> staticObject = null;
	private List<HSSFCell> parameterObjct = null;
	private List<HSSFCell> fieldObjct = null;
	private List<HSSFCell> variableObject = null;
	private String templatePath = null;

	public ExcelTemplate(String pTemplatePath) {
		templatePath = pTemplatePath;
	}
	
	public ExcelTemplate() {
	}
	
	/**
	 * 解析Excel模板
	 */
	public void parse(HttpServletRequest request) {
		staticObject = new ArrayList<HSSFCell>();
		parameterObjct = new ArrayList<HSSFCell>();
		fieldObjct = new ArrayList<HSSFCell>();
		variableObject = new ArrayList<HSSFCell>();
		if(AOSUtils.isEmpty(templatePath)){
			log.error("Excel模板路径不能为空!");
		}
		//templatePath = request.getSession().getServletContext().getRealPath(templatePath);
        InputStream is = request.getSession().getServletContext().getResourceAsStream(templatePath); 
		if(AOSUtils.isEmpty(is)){
			log.error("未找到模板文件,请确认模板路径是否正确[" + templatePath + "]");
		}
		HSSFWorkbook workbook=null;
		try {
			workbook = new HSSFWorkbook(is);
		} catch (Exception e) {
			e.printStackTrace();
		}
		HSSFSheet sheet = workbook.getSheetAt(0);
		if (AOSUtils.isNotEmpty(sheet)) {
			int rowNum = sheet.getPhysicalNumberOfRows();
			for (int k = 0; k < rowNum; k++) {
				HSSFRow row = sheet.getRow(k);
				for (int j = 0; j < row.getPhysicalNumberOfCells();j++) {
					String cellContent = row.getCell(j).getStringCellValue();
					if (!AOSUtils.isEmpty(cellContent)) {
						if (cellContent.indexOf("$P") != -1 || cellContent.indexOf("$p") != -1) {
							parameterObjct.add(row.getCell(j));
						} else if (cellContent.indexOf("$F") != -1 || cellContent.indexOf("$f") != -1) {
							fieldObjct.add(row.getCell(j));
						} else if(cellContent.indexOf("$V") != -1 || cellContent.indexOf("$v") != -1) {
							variableObject.add(row.getCell(j));
						}else {
							staticObject.add(row.getCell(j));
						}
					}
				}
			}
		} else {
			log.error("模板工作表对象不能为空!");
		}
	}

	/**
	 * 增加一个静态文本对象
	 */
	public void addStaticObject(HSSFCell cell) {
		staticObject.add(cell);
	}

	/**
	 * 增加一个参数对象
	 */
	public void addParameterObjct(HSSFCell cell) {
		parameterObjct.add(cell);
	}

	/**
	 * 增加一个字段对象
	 */
	public void addFieldObjct(HSSFCell cell) {
		fieldObjct.add(cell);
	}


	public List<HSSFCell> getStaticObject() {
		return staticObject;
	}

	public List<HSSFCell> getParameterObjct() {
		return parameterObjct;
	}

	public List<HSSFCell> getFieldObjct() {
		return fieldObjct;
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public List<HSSFCell> getVariableObject() {
		return variableObject;
	}

}
