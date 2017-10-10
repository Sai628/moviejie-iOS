//
//  FileUtil.swift
//  文件工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


struct FileUtil
{
    /// 为URL指定路径的文件或目录添加"do not backup"属性
    static func addSkipBackupAttribute(to url: URL) -> Bool
    {
        guard FileManager.default.fileExists(atPath: url.path) else
        {
            return false
        }
        
        do
        {
            var url = url
            var resultValues = URLResourceValues()
            resultValues.isExcludedFromBackup = true
            try url.setResourceValues(resultValues)
            
        }
        catch let error
        {
            log.error("\(error)")
            return false
        }
        
        return true
    }
    
    
    /// 获取某路径目录下文件的完整路径
    static func getAbsolutePath(in dirPath: String, withFileName fileName: String) -> String?
    {
        let filePath = (dirPath as NSString).appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: filePath)
        {
            return filePath
        }
        
        return nil
    }
    
    
    /// 获取某文件夹在某用户目录下的完整路径
    static func getFolderAbsolutePath(inDirectory directory: FileManager.SearchPathDirectory, withFolderName folderName: String, isCreateIfNotExist: Bool, isBackup: Bool) -> String?
    {
        let docsDir: NSString = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0] as NSString
        let folderPath = docsDir.appendingPathComponent(folderName)
        
        let fleManager = FileManager.default
        if (!fleManager.fileExists(atPath: folderPath) && isCreateIfNotExist)  //不存在目录时,创建该文件目录
        {
            do
            {
                try fleManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error
            {
                log.error("\(error)")
                return nil
            }
            
            if !isBackup  //添加"do not backup"属性
            {
                let url = URL(fileURLWithPath: folderPath)
                _ = addSkipBackupAttribute(to: url)
            }
        }
        
        return folderPath
    }
    
    
    /// 保存数据到某目录的文件中
    static func saveData(_ data: Data, toDirPath path: String, withFileName fileName: String) -> Bool
    {
        guard FileManager.default.fileExists(atPath: path) else
        {
            return false
        }
        
        let filePath = (path as NSString).appendingPathComponent(fileName)
        let url = URL(fileURLWithPath: filePath)
        return ((try? data.write(to: url, options: [.atomic])) != nil)
    }
    
    
    /// 获取文件的大小
    static func getFileSize(_ filePath: String) -> Int64
    {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath)
        {
            do
            {
                let attrs = try fileManager.attributesOfItem(atPath: filePath)
                if let fileSize = attrs[FileAttributeKey.size]
                {
                    return (fileSize as! NSNumber).int64Value
                }
            }
            catch let error
            {
                log.error("\(error)")
            }
        }
        
        return 0
    }
    
    
    /// 获取文件的拓展名
    static func getExtension(_ fileName: String?) -> String?
    {
        guard let name = fileName else
        {
            return nil
        }
        
        let arr = (name as NSString).components(separatedBy: ".")
        if arr.count > 1
        {
            return arr.last
        }
        
        return nil
    }
    
    
    /// 容量单元转换 根据传入的大小识别为 B 或 KB 或 MB 显示，型如："12.34B"、"23.45KB"、"34.56MB"
    static func getPrettySize(_ size: Int64) -> String
    {
        var sizeText = ""
        if size <= 0
        {
            sizeText = "0B"
        }
        else if size < 1024
        {
            sizeText = "\(size)B"
        }
        else if size < 1024 * 1024
        {
            sizeText = NSString(format: "%.1fKB", Float(size)/1024) as String
        }
        else
        {
            sizeText = NSString(format: "%.1fMB", Float(size)/1024/1024) as String
        }
        
        return sizeText
    }
}
