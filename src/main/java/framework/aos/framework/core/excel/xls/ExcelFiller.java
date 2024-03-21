package aos.framework.core.excel.xls;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import aos.framework.core.excel.ExcelData;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.typewrap.PO;
import aos.framework.core.typewrap.VO;
import aos.framework.core.typewrap.utils.TypeConvertUtil;
import aos.framework.core.utils.AOSUtils;
import jxl.Cell;
import jxl.format.CellFormat;
import jxl.write.Label;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.util.Region;

/**
 * Excel数据填充器
 * 
 * @author Remexs
 */
public class ExcelFiller {

	private Logger log = LoggerFactory.getLogger(ExcelFiller.class);

	private ExcelTemplate excelTemplate = null;

	private ExcelData excelData = null;

	public ExcelFiller() {
	}

	/**
	 * 构造函数
	 * 
	 * @param pExcelTemplate
	 * @param pExcelData
	 */
	public ExcelFiller(ExcelTemplate pExcelTemplate, ExcelData pExcelData) {
		setExcelData(pExcelData);
		setExcelTemplate(pExcelTemplate);
	}

	/**
	 * 数据填充 将ExcelData填入excel模板
	 * 
	 * @return ByteArrayOutputStream
	 */
	public ByteArrayOutputStream fill(HttpServletRequest request) {
		HSSFSheet wSheet = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		Dto parameterDto =  getExcelData().getParametersDto();
		try {
			InputStream is = request.getSession().getServletContext().getResourceAsStream(getExcelTemplate().getTemplatePath());
			HSSFWorkbook wb = new HSSFWorkbook(is);
			wSheet = wb.getSheetAt(0);
			wb.setSheetName(0, parameterDto.getString("tab_name")); 
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
	 * 数据填充 将ExcelData填入excel模板
	 * 
	 * @return ByteArrayOutputStream
	 */
	public ByteArrayOutputStream fill_tab(HttpServletRequest request) {
		HSSFSheet wSheet = null;
		HSSFSheet wSheet1 = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		List<Dto> parameterList =  getExcelData().getParametersList();
		try {
			InputStream is = request.getSession().getServletContext().getResourceAsStream(getExcelTemplate().getTemplatePath());
			HSSFWorkbook wb = new HSSFWorkbook(is);
			wSheet = wb.getSheetAt(0);
			wb.setSheetName(0, parameterList.get(0).getString("tab_name")); 
			for(int i=1;i<parameterList.size();i++){
				copySheet(wb,wSheet,wb.createSheet(parameterList.get(i).getString("tab_name")), wSheet.getFirstRowNum(), wSheet.getLastRowNum()+1);
				wSheet1 = wb.getSheetAt(i);
				fillStatics(wSheet1);
				fillParameters(wSheet1,i);
				if (AOSUtils.isNotEmpty(getExcelData().getFieldsList())) {
					fillFields(wSheet1,i);
				}
			}
			fillStatics(wSheet);
			fillParameters(wSheet,0);
			if (AOSUtils.isNotEmpty(getExcelData().getFieldsList())) {
				fillFields(wSheet,0);
			}
			
			wb.write(bos);
		} catch (Exception e) {
			log.error("基于模板生成可写工作表出错了!");
			e.printStackTrace();
		}
		return bos;
	}
	/**
	 * 数据填充 将ExcelData填入excel模板
	 * 
	 * @return ByteArrayOutputStream
	 */
	public ByteArrayOutputStream fill_tabe(HttpServletRequest request) {
		HSSFSheet wSheet = null;
		HSSFSheet wSheet1 = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		List<Dto> parameterList =  getExcelData().getParametersList();
		try {
			InputStream is = request.getSession().getServletContext().getResourceAsStream(getExcelTemplate().getTemplatePath());
			HSSFWorkbook wb = new HSSFWorkbook(is);
			wSheet = wb.getSheetAt(0);
			wb.setSheetName(0, parameterList.get(0).getString("tab_name")); 
			for(int i=1;i<parameterList.size();i++){
				copySheet(wb,wSheet,wb.createSheet(parameterList.get(i).getString("tab_name")), wSheet.getFirstRowNum(), wSheet.getLastRowNum()+1);
				wSheet1 = wb.getSheetAt(i);
				fillStatics(wSheet1);
				fillParameters(wSheet1,i);
				if (AOSUtils.isNotEmpty(getExcelData().getFieldsList())) {
					fillFieldss(wSheet1,i);
				}
			}
			fillStatics(wSheet);
			fillParameters(wSheet,0);
			if (AOSUtils.isNotEmpty(getExcelData().getFieldsList())) {
				fillFieldss(wSheet,0);
			}
			
			wb.write(bos);
		} catch (Exception e) {
			log.error("基于模板生成可写工作表出错了!");
			e.printStackTrace();
		}
		return bos;
	}
	
	/**
	  * 
	  * @param Excel工作簿对象
	  * @param 模板Sheet页
	  * @param 新建Sheet页
	  * @param 模板页的第一行
	  * @param 模板页的最后一行
	  */
	 private static void copySheet(HSSFWorkbook wb, HSSFSheet fromsheet, HSSFSheet newSheet, int firstrow, int lasttrow) {
	  // 复制一个单元格样式到新建单元格
	  if ((firstrow == -1) || (lasttrow == -1) || lasttrow < firstrow) {
	   return;
	  }
	  // 复制合并的单元格
	  Region region = null;
	  for (int i = 0; i < fromsheet.getNumMergedRegions(); i++) {
	   region = fromsheet.getMergedRegionAt(i);
	   if ((region.getRowFrom() >= firstrow) && (region.getRowTo() <= lasttrow)) {
	    newSheet.addMergedRegion(region);
	   }
	  }
	  HSSFRow fromRow = null;
	  HSSFRow newRow = null;
	  HSSFCell newCell = null;
	  HSSFCell fromCell = null;
	  // 设置列宽
	  for (int i = firstrow; i < lasttrow; i++) {
	   fromRow = fromsheet.getRow(i);
	   if (fromRow != null) {
	    for (int j = fromRow.getLastCellNum(); j >= fromRow.getFirstCellNum(); j--) {
	     int colnum = fromsheet.getColumnWidth((short) j);
	     if (colnum > 100) {
	      newSheet.setColumnWidth((short) j, (short) colnum);
	     }
	     if (colnum == 0) {
	      newSheet.setColumnHidden((short) j, true);
	     } else {
	      newSheet.setColumnHidden((short) j, false);
	     }
	    }
	    break;
	   }
	  }
	  // 复制行并填充数据
	  for (int i = 0; i < lasttrow; i++) {
	   fromRow = fromsheet.getRow(i);
	   if (fromRow == null) {
	    continue;
	   }
	   newRow = newSheet.createRow(i - firstrow);
	   newRow.setHeight(fromRow.getHeight());
	   for (int j = fromRow.getFirstCellNum(); j < fromRow.getPhysicalNumberOfCells(); j++) {
	    fromCell = fromRow.getCell((short) j);
	    if (fromCell == null) {
	     continue;
	    }
	    newCell = newRow.createCell((short) j);
	    newCell.setCellStyle(fromCell.getCellStyle());
	    int cType = fromCell.getCellType();
	    newCell.setCellType(cType);
	    switch (cType) {
	     case HSSFCell.CELL_TYPE_STRING:
	      newCell.setCellValue(fromCell.getRichStringCellValue());
	      break;
	     case HSSFCell.CELL_TYPE_NUMERIC:
	      newCell.setCellValue(fromCell.getNumericCellValue());
	      break;
	     case HSSFCell.CELL_TYPE_FORMULA:
	      newCell.setCellValue(fromCell.getCellFormula());
	      break;
	     case HSSFCell.CELL_TYPE_BOOLEAN:
	      newCell.setCellValue(fromCell.getBooleanCellValue());
	      break;
	     case HSSFCell.CELL_TYPE_ERROR:
	      newCell.setCellValue(fromCell.getErrorCellValue());
	      break;
	     default:
	      newCell.setCellValue(fromCell.getRichStringCellValue());
	      break;
	    }
	   }
	  }
	 }
	 
	 /**
		 * 写入参数对象
		 */
		private void fillParameters(HSSFSheet wSheet,int number) {
			List<HSSFCell> parameters = getExcelTemplate().getParameterObjct();
			Dto parameterDto = (Dto) getExcelData().getParametersList().get(number);
			for (int i = 0; i < parameters.size(); i++) {
				HSSFCell cell = parameters.get(i);
				String key = getKey(cell.getStringCellValue().trim());
				String type = getType(cell.getStringCellValue().trim());
				try {
					HSSFCell newCell = wSheet.getRow(cell.getRowIndex()).getCell(cell.getColumnIndex());
					// 格式化数据类型
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
		private void fillFields(HSSFSheet wSheet,int number) throws Exception {
			List<HSSFCell> fields = getExcelTemplate().getFieldObjct();
			List fieldList = (List) getExcelData().getFieldsList().get(number);
			List<HSSFCellStyle> listStyle = new ArrayList<HSSFCellStyle>();
			for (int i = 0; i < fields.size(); i++) {
				HSSFCellStyle style = wSheet.getWorkbook().createCellStyle();
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
					log.error("涓嶆敮鎸佺殑鏁版嵁绫诲瀷!");
				}
				HSSFRow newRow = wSheet.createRow(fields.get(0).getRowIndex() + j);
				for (int i = 0; i < fields.size(); i++) {
					HSSFCell cell = fields.get(i);
					String key = getKey(cell.getStringCellValue().trim());
					String type = getType(cell.getStringCellValue().trim());
					HSSFCell newCell = newRow.createCell(cell.getColumnIndex());
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
						log.error("鍐欏叆琛ㄦ牸瀛楁瀵硅薄鍙戠敓閿欒!");
						e.printStackTrace();
					}
				}
			}
			int row = 0;
			row += fieldList.size();
			if (AOSUtils.isEmpty(fieldList)) {
				if (AOSUtils.isNotEmpty(fields)) {
					HSSFCell cell = fields.get(0);
					row = cell.getRowIndex();
					wSheet.removeRowBreak(row + 5);
					wSheet.removeRowBreak(row + 4);
					wSheet.removeRowBreak(row + 3);
					wSheet.removeRowBreak(row + 2);
					wSheet.removeRowBreak(row + 1);
					wSheet.removeRowBreak(row);
				}
			} else {
				HSSFCell cell = fields.get(0);
				row += cell.getRowIndex();
				fillVariables(wSheet, row,number);
			}
		}
		/**
		 * 写入表格字段对象
		 * 
		 * @throws Exception
		 */
		private void fillFieldss(HSSFSheet wSheet,int number) throws Exception {
			List<HSSFCell> fields = getExcelTemplate().getFieldObjct();
			List fieldList =  (List) getExcelData().getFieldsList().get(number);
			List<HSSFCellStyle> listStyle = new ArrayList<HSSFCellStyle>();
			for (int i = 0; i < fields.size(); i++) {
				HSSFCellStyle style = wSheet.getWorkbook().createCellStyle();
				style.cloneStyleFrom(fields.get(i).getCellStyle());
				listStyle.add(style);
			}
			int a = 0;
			for (int j = 0; j < fieldList.size(); j++) {
				List dataList =  (List) fieldList.get(j);
				for (int i = 0; i < dataList.size(); i++) {
					if(j==0) {
						a=i;
					}else {
						a=a+1;
					}
					Dto dataDto = Dtos.newDto();
					Object object = dataList.get(i);
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
					HSSFRow newRow = wSheet.createRow(fields.get(0).getRowIndex() + a+j);
					for (int k = 0; k < fields.size(); k++) {
						HSSFCell cell = fields.get(k);
						String key = getKey(cell.getStringCellValue().trim());
						String type = getType(cell.getStringCellValue().trim());
						HSSFCell newCell = newRow.createCell(cell.getColumnIndex());
						newCell.setCellStyle(listStyle.get(k));
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
					
					
					int row = 0;
					row = row+fieldList.size();
					if (AOSUtils.isEmpty(fieldList)) {
						if (AOSUtils.isNotEmpty(fields)) {
							HSSFCell cell = fields.get(j);
							row = cell.getRowIndex();
							wSheet.removeRowBreak(row + 5);
							wSheet.removeRowBreak(row + 4);
							wSheet.removeRowBreak(row + 3);
							wSheet.removeRowBreak(row + 2);
							wSheet.removeRowBreak(row + 1);
							wSheet.removeRowBreak(row);
						}
					} else {
						HSSFCell cell = fields.get(j);
						row += cell.getRowIndex();
						fillVariables(wSheet, row+dataList.size()+1000,number);
					}
				}
			}
		}
		/**
		 * 写入变量对象
		 */
		private void fillVariables(HSSFSheet wSheet, int row,int number) {
			List<HSSFCell> variables = getExcelTemplate().getVariableObject();
			Dto parameterDto = (Dto) getExcelData().getParametersList().get(number);
			HSSFRow newRow = wSheet.createRow(row);
			for (int i = 0; i < variables.size(); i++) {
				HSSFCellStyle style = wSheet.getWorkbook().createCellStyle();
				HSSFCell cell = variables.get(i);
				String key = getKey(cell.getStringCellValue().trim());
				String type = getType(cell.getStringCellValue().trim());
				try {
					HSSFCell newCell = newRow.createCell(cell.getColumnIndex());
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
	 * 写入静态对象
	 */
	private void fillStatics(HSSFSheet wSheet) {
		List<HSSFCell> statics = getExcelTemplate().getStaticObject();
		for (int i = 0; i < statics.size(); i++) {
			HSSFCell cell = statics.get(i);
			try {
				HSSFCell newCell = wSheet.getRow(cell.getRowIndex()).getCell(cell.getColumnIndex());
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
	private void fillParameters(HSSFSheet wSheet) {
		List<HSSFCell> parameters = getExcelTemplate().getParameterObjct();
		Dto parameterDto = getExcelData().getParametersDto();
		for (int i = 0; i < parameters.size(); i++) {
			HSSFCell cell = parameters.get(i);
			String key = getKey(cell.getStringCellValue().trim());
			String type = getType(cell.getStringCellValue().trim());
			try {
				HSSFCell newCell = wSheet.getRow(cell.getRowIndex()).getCell(cell.getColumnIndex());
				// 格式化数据类型
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
	private void fillFields(HSSFSheet wSheet) throws Exception {
		List<HSSFCell> fields = getExcelTemplate().getFieldObjct();
		List fieldList = getExcelData().getFieldsList();
		List<HSSFCellStyle> listStyle = new ArrayList<HSSFCellStyle>();
		for (int i = 0; i < fields.size(); i++) {
			HSSFCellStyle style = wSheet.getWorkbook().createCellStyle();
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
			HSSFRow newRow = wSheet.createRow(fields.get(0).getRowIndex() + j);
			for (int i = 0; i < fields.size(); i++) {
				HSSFCell cell = fields.get(i);
				String key = getKey(cell.getStringCellValue().trim());
				String type = getType(cell.getStringCellValue().trim());
				HSSFCell newCell = newRow.createCell(cell.getColumnIndex());
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
				HSSFCell cell = fields.get(0);
				row = cell.getRowIndex();
				wSheet.removeRowBreak(row + 5);
				wSheet.removeRowBreak(row + 4);
				wSheet.removeRowBreak(row + 3);
				wSheet.removeRowBreak(row + 2);
				wSheet.removeRowBreak(row + 1);
				wSheet.removeRowBreak(row);
			}
		} else {
			HSSFCell cell = fields.get(0);
			row += cell.getRowIndex();
			fillVariables(wSheet, row);
		}
	}

	/**
	 * 写入变量对象
	 */
	private void fillVariables(HSSFSheet wSheet, int row) {
		List<HSSFCell> variables = getExcelTemplate().getVariableObject();
		Dto parameterDto = getExcelData().getParametersDto();
		HSSFRow newRow = wSheet.createRow(row);
		for (int i = 0; i < variables.size(); i++) {
			HSSFCellStyle style = wSheet.getWorkbook().createCellStyle();
			HSSFCell cell = variables.get(i);
			String key = getKey(cell.getStringCellValue().trim());
			String type = getType(cell.getStringCellValue().trim());
			try {
				HSSFCell newCell = newRow.createCell(cell.getColumnIndex());
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

	public ExcelTemplate getExcelTemplate() {
		return excelTemplate;
	}

	public void setExcelTemplate(ExcelTemplate excelTemplate) {
		this.excelTemplate = excelTemplate;
	}

	public ExcelData getExcelData() {
		return excelData;
	}

	public void setExcelData(ExcelData excelData) {
		this.excelData = excelData;
	}
}
