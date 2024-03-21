package aos.framework.core.utils;
import java.io.File;
import java.io.RandomAccessFile;
class Utf8BOMUtils {
	/**
	 * 用空格替换掉指定文件的UTF-8 BOM头(前3个字节)
	 * @param file	 
	 */
	public static void replaceUtf8BOM(File file){
		RandomAccessFile accessFile = null;
		byte[] utf8Bom = new byte[3];
		int readSize = 0;
		
		if(null == file){
			return ;
		}
		
		try{
			accessFile = new RandomAccessFile(file, "rw");
			readSize = accessFile.read(utf8Bom);
			
			if(0 >= readSize){
				return;
			}
			
			if(-17 == utf8Bom[0] && -69 == utf8Bom[1] && -65 ==utf8Bom[2]){
				
				accessFile.seek(0);
				accessFile.write(new byte[]{
						' ',' ',' '
				});
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try{
				if(null != accessFile) accessFile.close();
			}catch(Exception ex){
				
			}
		}
	}
}
