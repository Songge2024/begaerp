package aos.framework.core.excel.xlsx;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import aos.framework.core.utils.AOSUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 导出Excel的模板对象
 * (修改成poi支持)
 * @author Remexs
 * @version 2.0
 */
public class ExcelTemplateX {

	private Log log = LogFactory.getLog(ExcelTemplateX.class);

	private List<Cell> staticObject = null;
	private List<Cell> parameterObjct = null;
	private List<Cell> fieldObjct = null;
	private List<Cell> variableObject = null;
	private String templatePath = null;

	public ExcelTemplateX(String pTemplatePath) {
		templatePath = pTemplatePath;
	}
	
	public ExcelTemplateX() {
	}
	
	/**
	 * 解析Excel模板
	 */
	public void parse(HttpServletRequest request) {
		staticObject = new ArrayList<Cell>();
		parameterObjct = new ArrayList<Cell>();
		fieldObjct = new ArrayList<Cell>();
		variableObject = new ArrayList<Cell>();
		if(AOSUtils.isEmpty(templatePath)){
			log.error( "Excel模板路径不能为空!");
		}
		//templatePath = request.getSession().getServletContext().getRealPath(templatePath);
        InputStream is = request.getSession().getServletContext().getResourceAsStream(templatePath); 
		if(AOSUtils.isEmpty(is)){
			log.error( "未找到模板文件,请确认模板路径是否正确[" + templatePath + "]");
		}
		Workbook workbook=null;
		try {
			workbook = new XSSFWorkbook(is);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Sheet sheet = workbook.getSheetAt(0);
		if (AOSUtils.isNotEmpty(sheet)) {
			int rowNum = sheet.getPhysicalNumberOfRows();
			for (int k = 0; k < rowNum; k++) {
				Row row = sheet.getRow(k);
				for (int j = 0; j < row.getPhysicalNumberOfCells();j++) {
					if (!AOSUtils.isEmpty(row.getCell(j))) {
						String cellContent = row.getCell(j).getStringCellValue();
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
	public void addStaticObject(Cell cell) {
		staticObject.add(cell);
	}

	/**
	 * 增加一个参数对象
	 */
	public void addParameterObjct(Cell cell) {
		parameterObjct.add(cell);
	}

	/**
	 * 增加一个字段对象
	 */
	public void addFieldObjct(Cell cell) {
		fieldObjct.add(cell);
	}


	public List<Cell> getStaticObject() {
		return staticObject;
	}

	public List<Cell> getParameterObjct() {
		return parameterObjct;
	}

	public List<Cell> getFieldObjct() {
		return fieldObjct;
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public List<Cell> getVariableObject() {
		return variableObject;
	}

}
