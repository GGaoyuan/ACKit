//
//  WKWebView_Extension.swift
//  ACKit
//
//  Created by gaoyuan on 2023/2/28.
//

import UIKit
import WebKit


extension WKWebView {
    
    /// 将WebView进行截屏生成一张图
    /// https://juejin.cn/post/6844903680055967757
    public static func ac_captureSnapshot(webView: WKWebView, completion:@escaping (UIImage?)->Void) {
        
        func drawScreenshotOfPageContent(_ index: Int, maxIndex: Int, completion: @escaping () -> Void) {
            let scrollView = webView.scrollView
            scrollView.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * scrollView.frame.size.height), animated: false)
            let pageFrame = CGRect(x: 0, y: CGFloat(index) * scrollView.frame.size.height, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                scrollView.drawHierarchy(in: pageFrame, afterScreenUpdates: true)
                
                if index < maxIndex {
                    drawScreenshotOfPageContent(index + 1, maxIndex: maxIndex, completion: completion)
                }else{
                    completion()
                }
            }
        }
        
        
        // 分页绘制内容到ImageContext
        let originalOffset = webView.scrollView.contentOffset

        // 当contentSize.height<bounds.height时，保证至少有1页的内容绘制
        var pageNum = 1
        if webView.scrollView.contentSize.height > webView.scrollView.bounds.height {
            pageNum = Int(floorf(Float(webView.scrollView.contentSize.height / webView.scrollView.bounds.height)))
        }

        let backgroundColor = webView.backgroundColor ?? UIColor.white

        UIGraphicsBeginImageContextWithOptions(webView.scrollView.contentSize, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            completion(nil)
            return
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        
        drawScreenshotOfPageContent(0, maxIndex: pageNum) {
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            webView.scrollView.contentOffset = originalOffset
            completion(image)
        }
        
        
    }
}
