//
//  UIColor_ACExtension.swift
//  ACKit
//
//  Created by gaoyuan on 2023/3/8.
//

import UIKit

extension UIColor {
    
    /// 将16进制颜色转化为RGB颜色
    public static func ac_RGBValue(_ hexColor: String) -> (CGFloat, CGFloat, CGFloat) {
        //先把#替换了
        let hex = hexColor.replacingOccurrences(of: "#", with: "")
        if hex.count != 6 {
            return (0, 0, 0)
        }
        let text = Scanner.init(string: hex)
        var colorValue:UInt64 = 0
        text.scanHexInt64(&colorValue)
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        red = CGFloat((colorValue & 0xFF0000)>>16)
        green = CGFloat((colorValue & 0x00FF00)>>8)
        blue = CGFloat((colorValue & 0x0000FF))
        return (red, green, blue)
    }

    
    /// 获取一个随机颜色
    /// - Returns: 随机颜色
    public static func ac_random() -> UIColor {
        func randomC() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }
        return UIColor(red: randomC(),
                       green: randomC(),
                       blue: randomC(),
                       alpha: 1.0)
    }
}
