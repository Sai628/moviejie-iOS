//
//  ImageUtil.swift
//  图片工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation
import EZSwiftExtensions


class ImageUtil
{
    /// 返回限定大小的图片
    static func scale(_ image: UIImage, toSize size: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    
    /// 按原图比例返回限定大小的图片
    static func scale(_ image: UIImage, toLimitSize size: CGSize) -> UIImage
    {
        let limitWidth = size.width
        let limitHeight = size.height
        var width = image.size.width
        var height = image.size.height
        
        if (limitWidth == 0 || limitHeight == 0 || (limitWidth >= width && limitHeight >= height))
        {
            return image
        }
        
        let scale = limitHeight / limitWidth
        let imageScale = height / width
        
        if (imageScale < scale && width > limitWidth)
        {
            width = limitWidth
            height = width * imageScale
        }
        else if (imageScale > scale && height > limitHeight)
        {
            height = limitHeight
            width = height / imageScale
        }
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height));
        image.draw(in: CGRect(x: 0, y: 0, w: width, h: height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage!
    }
    
    
    /// 根据颜色与大小创建图片
    static func create(withColor color: UIColor, andSize size: CGSize) -> UIImage!
    {
        UIGraphicsBeginImageContext(size)
        
        let colorComponents = color.cgColor.components
        UIGraphicsGetCurrentContext()?.setFillColor(red: (colorComponents?[0])!, green: (colorComponents?[1])!, blue: (colorComponents?[2])!, alpha: (colorComponents?[3])!)
        UIRectFill(CGRect(x: 0, y: 0, w: size.width, h: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    /// 计算图片的字节大小(返回单位为MB)
    static func getMBSize(_ image: UIImage) -> Double
    {
        let cgImage = image.cgImage
        let bpp = cgImage?.bitsPerPixel
        let bpc = cgImage?.bitsPerComponent
        let bytesPerPixel = bpp! / bpc!
        let totalPixel = (cgImage?.width)! * (cgImage?.height)!
        
        return Double(totalPixel * bytesPerPixel) / (1024 * 1024 * 8)
    }
}
