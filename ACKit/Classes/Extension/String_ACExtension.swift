//
//  String_Extension.swift
//  ACKit
//
//  Created by gaoyuan on 2023/2/27.
//

import UIKit

//MARK: - 手机号和邮箱号处理
extension String {
    
    /// 匹配手机号
    public func ac_matchPhoneNumber() -> Bool {
        let pred : NSPredicate = NSPredicate.init(format: "self matches %@", "^1[3456789]\\d{9}$")
        if pred.evaluate(with: self) {
            return true
        }
        return false
    }
    
    /// 匹配邮箱
    public func ac_matchMailString() -> Bool {
        let pred : NSPredicate = NSPredicate.init(format: "self matches %@", "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$")
        if pred.evaluate(with: self) {
            return true
        }
        return false
    }
    
    /// 手机号脱敏显示，中间4位用*代替，比如185****8888
    public func ac_fetchSecrectPhoneNumber() -> String {
        if ac_matchPhoneNumber() && self.count >= 11 {
            let starts = "****"
            let starNum = starts.count
            let beginOffset = Int(self.count / 2) - starNum/2
            let startIndex = self.index(self.startIndex, offsetBy:beginOffset)
            let endIndex = self.index(self.startIndex, offsetBy:(beginOffset + starNum))
            let range = startIndex..<endIndex
            var phone = self
            phone.replaceSubrange(range, with: starts)
            return phone
        }
        return self
    }
    
    /// 邮箱脱敏显示，邮箱用4位*代替
    public func ac_fetchSecrectEmail() -> String {
        if ac_matchMailString() {
            let emailComponents = self.components(separatedBy: "@")
            guard var availableNum = emailComponents.first, let availableAddress = emailComponents.last else { return self }
            if availableNum.count < 4 {
                let r = ("***@" + availableAddress)
                return r
            }
            let starts = "****"
            let starNum = starts.count
            let beginOffset = Int(availableNum.count / 2) - starNum/2
            let startIndex = self.index(availableNum.startIndex, offsetBy:beginOffset)
            let endIndex = self.index(availableNum.startIndex, offsetBy:beginOffset + starNum)
            let range = startIndex..<endIndex
            availableNum.replaceSubrange(range, with: "****")
            let r = (availableNum + "@" + availableAddress)
            return r
        }
        return self
    }
}

//MARK: - 设备信息
extension String {
    
    /// 获取设备ip地址
    /// - Returns:
    public static func ac_deviceIP() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name: String = String(cString: (interface!.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
    
}
