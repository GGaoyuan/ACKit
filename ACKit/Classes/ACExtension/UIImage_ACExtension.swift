//
//  UIImage_ACExtension.swift
//  ACKit
//
//  Created by gaoyuan on 2023/3/17.
//

import UIKit

extension UIImage {
    
    /// 获取开屏图片LaunchImage
    /// - Returns: LaunchImage
    public static func launchImage() -> UIImage? {
        var lauchImage: UIImage?
        var viewOrientation: String!
        let orientation = UIApplication.shared.statusBarOrientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            viewOrientation = "Landscape"
        } else {
            viewOrientation = "Portrait"
        }
        if let infoDictionary = Bundle.main.infoDictionary, let launchImages = infoDictionary["UILaunchImages"] as? Array<Dictionary<String, String>> {
            for dict in launchImages {
                if let size = dict["UILaunchImageSize"],
                    let orientation = dict["UILaunchImageOrientation"],
                    let name = dict["UILaunchImageName"] {
                    
                    if CGSizeEqualToSize(NSCoder.cgSize(for: size), UIScreen.main.bounds.size) && viewOrientation == orientation {
                        return UIImage(named: name)
                    }
                }
            }
        }
        return lauchImage
    }
}
