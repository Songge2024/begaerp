package aos.framework.core.utils;  
import java.io.File;  
import java.io.FileFilter;  
/** 
 * 用来过滤非.java文件 
 * @author kfbsl 
 * 
 */  
class JavaFileFilter  implements FileFilter{  
    //如果文件扩展名为:.java  
    public boolean accept(File dir, String name) {  
          
        if(null == name || "".equals(name)){  
            return false;  
        }  
          
        return name.toUpperCase().endsWith(".JAVA");  
    }  
    public boolean accept(File pathname) {  
        if(pathname.isDirectory()){  
            return true;  
        }  
          
        String fileName = pathname.getName();  
        return accept(null, fileName);  
    }  
} 