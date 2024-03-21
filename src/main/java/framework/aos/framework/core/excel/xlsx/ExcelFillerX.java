package aos.framework.core.excel.xlsx;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import aos.framework.core.excel.ExcelData;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.typewrap.PO;
import aos.framework.core.typewrap.VO;
import aos.framework.core.typewrap.utils.TypeConvertUtil;
import aos.framework.core.utils.AOSUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * Excel数据填充器
 * 
 * @author BLRISE
 * @since 2010-08-12
 */
public class ExcelFillerX {

	private Log log = LogFactory.getLog(ExcelFillerX.class);

	private ExcelTemplateX excelTemplate = null;

	private ExcelData excelData = null;

	public ExcelFillerX() {
	}

	/**
	 * 构造函数
	 * 
	 * @param pExcelTemplate
	 * @param pExcelData
	 */
	public ExcelFillerX(ExcelTemplateX pExcelTemplate, ExcelData pExcelData) {
		setExcelData(pExcelData);
		setExcelTemplate(pExcelTemplate);
	}

	/**
	 * 数据填充 将ExcelData填入excel模板
	 * 
	 * @return ByteArrayOutputStream
	 */
	public ByteArrayOutputStream fill(HttpServletRequest request) {
		Sheet wSheet = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		try {
			InputStream is = request.getSession().getServletContext()
					.getResourceAsStream(getExcelTemplate().getTemplatePath());
			Workbook wb = new XSSFWorkbook(is);
			wSheet = wb.getSheetAt(0);	
			fillStatics(wSheet);
			fillParameters(wSheet);
			if (AOSUtils.isNotEmpty(getExcelData().getFieldsList())) {
				fillFields(wSheet);
			}
			wb.write(bos);
		} catch (Exception e) {
			log.error("基于模板生成可写工作表出错了!");
			e.printStackTrace();
		}
		return bos;
	}

	/**
	 * 写入静态对象
	 */
	private void fillStatics(Sheet wSheet) {
		List<Cell> statics = getExcelTemplate().getStaticObject();
		for (int i = 0; i < statics.size(); i++) {
			Cell cell = statics.get(i);
			try {
				Cell newCell = wSheet.getRow(cell.getRowIndex()).getCell(cell.getColumnIndex());
				newCell.setCellValue(cell.getStringCellValue());
			} catch (Exception e) {
				log.error("写入静态对象发生错误!");
				e.printStackTrace();
			}
		}
	}

	/**
	 * 写入参数对象
	 */
	private void fillParameters(Sheet wSheet) {
		List<Cell> parameters = getExcelTemplate().getParameterObjct();
		Dto parameterDto = getExcelData().getParametersDto();
		for (int i = 0; i < parameters.size(); i++) {
			Cell cell = (Cell) parameters.get(i);
			String key = getKey(cell.getStringCellValue().trim());
			String type = getType(cell.getStringCellValue().trim());
			try {
				Cell newCell = wSheet.getRow(cell.getRowIndex()).getCell( cell.getColumnIndex());
				if (type.equalsIgnoreCase("number")) {
					newCell.setCellValue(parameterDto.getBigDecimal(key).doubleValue());
				} else if (type.equals("dateformat")) {
					newCell.setCellValue(AOSUtils.date2String(new Date(parameterDto.getDate(key).getTime()), "yyyy-MM-dd"));
				} else if (type.equals("datetimeformat")) {
					newCell.setCellValue(AOSUtils.date2String(new Date(parameterDto.getTimestamp(key).getTime()), "yyyy-MM-dd HH:mm:ss"));
				} else {
					newCell.setCellValue(parameterDto.getString(key));
					newCell.getCellStyle().cloneStyleFrom(cell.getCellStyle());
				}
			} catch (Exception e) {
				log.error("写入表格参数对象发生错误!");
				e.printStackTrace();
			}
		}
	}

	/**
	 * 写入表格字段对象
	 * 
	 * @throws Exception
	 */
	private void fillFields(Sheet wSheet) throws Exception {
		List<Cell> fields = getExcelTemplate().getFieldObjct();
		List fieldList = getExcelData().getFieldsList();
		List<CellStyle> listStyle = new ArrayList<CellStyle>();
		for (int i = 0; i < fields.size(); i++) {
			CellStyle style = wSheet.getWorkbook().createCellStyle();
			style.cloneStyleFrom(fields.get(i).getCellStyle());
			listStyle.add(style);
		} 
		for (int j = 0; j < fieldList.size(); j++) {
			Dto dataDto = Dtos.newDto();
			Object object = fieldList.get(j);
			if (object instanceof PO) {
				PO po = (PO) object;
				dataDto.putAll(po.toDto());
			} else if (object instanceof VO) {
				VO vo = (VO) object;
				dataDto.putAll(vo.toDto());
			} else if (object instanceof Dto) {
				Dto dto = (Dto) object;
				dataDto.putAll(dto);
			} else {
				log.error("不支持的数据类型!");
			}
			Row newRow = wSheet.createRow(fields.get(0).getRowIndex() + j);
			for (int i = 0; i < fields.size(); i++) {
				Cell cell = fields.get(i);
				String key = getKey(cell.getStringCellValue().trim());
				String type = getType(cell.getStringCellValue().trim());
				Cell newCell = newRow.createCell(cell.getColumnIndex());
				newCell.setCellStyle(listStyle.get(i));
				try {
					if (type.equalsIgnoreCase("number")) {
						newCell.setCellValue(dataDto.getBigDecimal(key).doubleValue());
					} else if (type.equals("dateformat")) {
						newCell.setCellValue(AOSUtils.date2String(new Date(dataDto.getDate(key).getTime()), "yyyy-MM-dd"));
					} else if (type.equals("datetimeformat")) {
						newCell.setCellValue(AOSUtils.date2String(new Date(dataDto.getTimestamp(key).getTime()), "yyyy-MM-dd HH:mm:ss"));
					} else {
						newCell.setCellValue(dataDto.getString(key));
					}
				} catch (Exception e) {
					log.error("写入表格字段对象发生错误!");
					e.printStackTrace();
				}
			}
		}
		int row = 0;
		row += fieldList.size();
		if (AOSUtils.isEmpty(fieldList)) {
			if (AOSUtils.isNotEmpty(fields)) {
				Cell cell = (Cell) fields.get(0);
				row = cell.getRowIndex();
				wSheet.removeRowBreak(row + 5);
				wSheet.removeRowBreak(row + 4);
				wSheet.removeRowBreak(row + 3);
				wSheet.removeRowBreak(row + 2);
				wSheet.removeRowBreak(row + 1);
				wSheet.removeRowBreak(row);
			}
		} else {
			Cell cell = fields.get(0);
			row += cell.getRowIndex();
			fillVariables(wSheet, row);
		}
	}

	/**
	 * 写入变量对象
	 */
	private void fillVariables(Sheet wSheet, int row) {
		List<Cell> variables = getExcelTemplate().getVariableObject();
		Dto parameterDto = getExcelData().getParametersDto();
		Row newRow = wSheet.createRow(row);
		for (int i = 0; i < variables.size(); i++) {
			CellStyle style = wSheet.getWorkbook().createCellStyle();
			Cell cell = variables.get(i);
			String key = getKey(cell.getStringCellValue().trim());
			String type = getType(cell.getStringCellValue().trim());
			try {
				Cell newCell = newRow.createCell(cell.getColumnIndex());
				style.cloneStyleFrom(cell.getCellStyle());
				newCell.setCellStyle(style);
				if (type.equalsIgnoreCase("number")) {
					newCell.setCellValue(parameterDto.getBigDecimal(key).doubleValue());
				} else if (type.equals("dateformat")) {
					newCell.setCellValue(AOSUtils.date2String(new Date(parameterDto.getDate(key).getTime()), "yyyy-MM-dd"));
				} else if (type.equals("datetimeformat")) {
					newCell.setCellValue(AOSUtils.date2String(new Date(parameterDto.getTimestamp(key).getTime()), "yyyy-MM-dd HH:mm:ss"));
				} else {
					String content = parameterDto.getString(key);
					if (AOSUtils.isEmpty(content) && !key.equalsIgnoreCase("nbsp")) {
						content = key;
					}
					newCell.setCellValue(content);
				}
			} catch (Exception e) {
				log.error("写入表格变量对象发生错误!");
				e.printStackTrace();
			}
		}
	}
  
	/**
	 * 获取模板键名
	 * 
	 * @param pKey
	 *            模板元标记
	 * @return 键名
	 */
	private static String getKey(String pKey) {
		String key = null;
		int index = pKey.indexOf(":");
		if (index == -1) {
			key = pKey.substring(3, pKey.length() - 1);
		} else {
			key = pKey.substring(3, index);
		}
		return key;
	}

	/**
	 * 获取模板单元格标记数据类型
	 * 
	 * @param pType
	 *            模板元标记
	 * @return 数据类型
	 */
	private static String getType(String pType) {
		String type = "label";
		if (pType.indexOf(":n") != -1 || pType.indexOf(":N") != -1) {
			type = "number";
		} else if (pType.indexOf(":df") != -1 || pType.indexOf(":DF") != -1) {
			type = "dateformat";
		} else if (pType.indexOf(":dtf") != -1 || pType.indexOf(":DTF") != -1) {
			type = "datetimeformat";
		}
		return type;
	}

	public ExcelTemplateX getExcelTemplate() {
		return excelTemplate;
	}

	public void setExcelTemplate(ExcelTemplateX excelTemplate) {
		this.excelTemplate = excelTemplate;
	}

	public ExcelData getExcelData() {
		return excelData;
	}

	public void setExcelData(ExcelData excelData) {
		this.excelData = excelData;
	}
}
