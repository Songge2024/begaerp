package aos.framework.core.excel.xlsx;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSUtils;

/**
 * Excel数据读取器
 * 
 * @author BLRISE
 * @since 2010-08-12
 */
public class ExcelReaderX {
	private String metaData = null;
	private InputStream is = null;

	public ExcelReaderX() {
	};

	/**
	 * 构造函数
	 * 
	 * @param pMetaData
	 *            元数据
	 * @param pIs
	 *            Excel数据流
	 * @throws IOException
	 * @throws BiffException
	 */
	public ExcelReaderX(String pMetaData, InputStream pIs) {
		setIs(pIs);
		setMetaData(pMetaData);
	}

	/**
	 * 读取Excel数据
	 * 
	 * @param pBegin
	 *            从第几行开始读数据<br>
	 *            <b>注意下标索引从0开始的哦!
	 * @return 以List<BaseDTO>形式返回数据
	 * @throws BiffException
	 * @throws IOException
	 */
	public List read(int pBegin) throws IOException {
		List list = new ArrayList();
		Workbook workbook = new XSSFWorkbook(getIs());
		Sheet sheet = workbook.getSheetAt(0);
		int rowNum = sheet.getPhysicalNumberOfRows();
		for (int i = pBegin; i < rowNum; i++) {
			Dto rowDto = Dtos.newDto();
			Row row = sheet.getRow(i);
			int cellNum = sheet.getRow(i).getLastCellNum();
			for (int j = 0; j < cellNum; j++) {
				String key = getMetaData().trim().split(",")[j];
				if (AOSUtils.isNotEmpty(key)) {
					if (AOSUtils.isNotEmpty(row.getCell(j))) {
						rowDto.put(key, row.getCell(j).getStringCellValue());
					} else {
						rowDto.put(key, "");
					}
				}
			}
			list.add(rowDto);
		}
		return list;
	}

	/**
	 * 读取Excel数据
	 * 
	 * @param pBegin
	 *            从第几行开始读数据<br>
	 *            <b>注意下标索引从0开始的哦!</b>
	 * @param pBack
	 *            工作表末尾减去的行数
	 * @return 以List<BaseDTO>形式返回数据
	 * @throws BiffException
	 * @throws IOException
	 */
	public List read(int pBegin, int pBack) throws IOException {
		List list = new ArrayList();
		Workbook workbook = new XSSFWorkbook(getIs());
		Sheet sheet = workbook.getSheetAt(0);
		int rowNum = sheet.getLastRowNum();
		for (int i = pBegin; i < rowNum - pBack; i++) {
			Dto rowDto = Dtos.newDto();
			Row row = sheet.getRow(i);
			String[] arrMeta = getMetaData().trim().split(",");
			for (int j = 0; j < arrMeta.length; j++) {
				String key = arrMeta[j];
				if (AOSUtils.isNotEmpty(key))
					rowDto.put(key, row.getCell(j).getStringCellValue());
			}
			list.add(rowDto);
		}
		return list;
	}

	public InputStream getIs() {
		return is;
	}

	public void setIs(InputStream is) {
		this.is = is;
	}

	public String getMetaData() {
		return metaData;
	}

	public void setMetaData(String metaData) {
		this.metaData = metaData;
	};
}
