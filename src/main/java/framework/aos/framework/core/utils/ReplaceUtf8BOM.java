package aos.framework.core.utils;
import java.io.File;
import java.io.FileFilter;  
/**
 * 用空格替换Java文件utf-8 bom头
 * @author shanl
 *
 */
public class ReplaceUtf8BOM {
	public static void main(String[] args){
		if(args.length == 0){
			help();
			return;
		}
		
		if("-d".equalsIgnoreCase(args[0])){
			System.out.println("已替换指定目录:'"+args[1]+"'下所有.java文件的utf-8 BOM头");
			removeDirectoryUtf8BOM(args[1]);
			return;
		}
		
		if("-f".equalsIgnoreCase(args[0])){
			System.out.println("已替换指定文件:'" + args[1] + "'utf-8 BOM头");
			removeFileUtf8BOM(args[1]);
			return;
		}
		
		System.out.println("错误的参数:" + args[0]);	
		help();
	}
	
	static void help(){
		System.out.println("ReplaceUtf8BOM -d <目录名>|-f <文件名>");
		System.out.println("-d <目录名>:遍历删除整个目录的.java文件的utf-8 BOM头");
		System.out.println("-f <文件名>:删除指定.java文件的utf-8 BOM头");
	}
	
	static void removeFileUtf8BOM(String fileStr){
		File file = null;
		
		file = new File(fileStr);
		removeFileUtf8BOM(file);
	}
	
	static void removeFileUtf8BOM(File file){
		Utf8BOMUtils.replaceUtf8BOM(file);
	}
	
	static void removeDirectoryUtf8BOM(String dirStr){
		File dir = null;
		File[] files = null;
		
		dir = new File(dirStr);
		files = dir.listFiles(new JavaFileFilter());
		
		if(null != files && 0 != files.length){
			for(File f:files){
				
				if(f.isDirectory()){
					removeDirectoryUtf8BOM(f.getAbsolutePath());
				}else{
					removeFileUtf8BOM(f);
				}
			}
		}
	}
}
