//
//  TestObj.swift
//  ACKit
//
//  Created by gaoyuan on 2023/2/27.
//

import UIKit

/// dispatch_after
public func dispatch_after(delay: TimeInterval, execute: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: execute)
}

/// RGBA
public func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a:CGFloat)-> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

/// 刘海屏
public func isNotchScreen() -> Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            return true
        }
    }
    return false
}

// MARK - Device
public let ACStatusBar_Height: CGFloat = isNotchScreen() ? 44 : 20;

public let ACNavigationBar_Height: CGFloat = 44;

public let ACStatusBar_NavigationBar_Height: CGFloat = ACStatusBar_Height + ACNavigationBar_Height;

public let ACSafeBottomMargin_Height: CGFloat = isNotchScreen() ? 34 : 0

public let ACScreenWidth = UIScreen.main.bounds.size.width;

public let ACScreenHeight = UIScreen.main.bounds.size.height;
