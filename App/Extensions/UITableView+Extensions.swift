//
//  UITableView+Extensions.swift
//  UITableView 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics


extension UITableView
{
    func indexPathForRowContainingView(_ view: UIView) -> IndexPath?
    {
        let point = view.convert(view.bounds.origin, to: self)
        return self.indexPathForRow(at: point)
    }
    
    
    func scrollToFoot(_ animated: Bool)
    {
        let sections = self.numberOfSections
        guard sections >= 1 else {
            return
        }
        
        let rows = self.numberOfRows(inSection: sections - 1)
        guard rows >= 1 else {
            return
        }
        
        let indexPath = IndexPath(row: rows - 1, section: sections - 1)
        self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
    
    func addLineForCell(cell: UITableViewCell, at indexPath: IndexPath, leftSpace: CGFloat = 16, rightSpace: CGFloat = 0,
                        hasSectionLine: Bool = true, color: UIColor = Colors._DDD)
    {
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: 0, dy: 0)
        pathRef.addRect(bounds)
        
        let layer = CAShapeLayer()
        layer.path = pathRef
        
        if let color = cell.backgroundColor
        {
            layer.fillColor = color.cgColor
        }
        else if let color = cell.backgroundView?.backgroundColor
        {
            layer.fillColor = color.cgColor
        }
        else
        {
            layer.fillColor = UIColor(white: 1.0, alpha: 0.8).cgColor
        }
        
        let lineColor = color.cgColor
        let sectionLineColor = lineColor
        let row = indexPath.row
        let numberOfRows = self.numberOfRows(inSection: indexPath.section)
        
        if (row == 0 && row == numberOfRows - 1)  // 只有一个cell, 加上长线与下长线
        {
            if hasSectionLine
            {
                self.addLayer(layer: layer, isLineUp: true, isLong: true, color: sectionLineColor, bounds: bounds)
                self.addLayer(layer: layer, isLineUp: false, isLong: true, color: sectionLineColor, bounds: bounds)
            }
        }
        else if (row == 0)  // 第一个cell, 加上长线与下短线
        {
            if hasSectionLine
            {
                self.addLayer(layer: layer, isLineUp: true, isLong: true, color: sectionLineColor, bounds: bounds)
            }
            self.addLayer(layer: layer, isLineUp: false, isLong: false, color: lineColor, bounds: bounds, leftSpace: leftSpace, rightSpace: rightSpace)
        }
        else if (row == numberOfRows - 1)  // 最后一个cell, 加下长线
        {
            if hasSectionLine
            {
                self.addLayer(layer: layer, isLineUp: false, isLong: true, color: sectionLineColor, bounds: bounds)
            }
        }
        else  // 中间的cell, 只加下短线
        {
            self.addLayer(layer: layer, isLineUp: false, isLong: false, color: lineColor, bounds: bounds, leftSpace: leftSpace, rightSpace: rightSpace)
        }
        
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        cell.backgroundView = testView
    }
    
    
    fileprivate func addLayer(layer: CALayer, isLineUp: Bool, isLong: Bool, color: CGColor, bounds: CGRect, leftSpace: CGFloat = 0, rightSpace: CGFloat = 0)
    {
        let lineLayer = CALayer()
        let lineHeight = 1.0 / UIScreen.main.scale
        let top = isLineUp ? 0 : (bounds.size.height - lineHeight)
        let left = isLong ? 0 : leftSpace
        
        lineLayer.frame = CGRect(x: bounds.minX + left, y: top, width: bounds.width - left - rightSpace, height: lineHeight)
        lineLayer.backgroundColor = color
        layer.addSublayer(lineLayer)
    }
}
