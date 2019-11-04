//
//  Reachability.swift
//  LOTTEHOTELFMS
//
//  Created by ldcc on 2019/10/28.
//  Copyright © 2019 ldcc. All rights reserved.
//

import Foundation
import SystemConfiguration


public class NetworkUtil{
    class func isConnectedToNetwork() -> Bool{
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0,0,0,0,0,0,0,0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    class func isIPv4(_ IP: String) -> Bool {
        let items = IP.components(separatedBy: ".")
        
        if(items.count != 4) {
            return false
        }
        
        for item in items {
            var tmp = 0
            
            if(item.count > 3 || item.count < 1){
                return false
            }
            
            for char in item{
                if(char < "0" || char > "9"){
                    return false
                }
                
                tmp = tmp * 10 + Int(String(char))!
            }
            
            if(tmp < 0 || tmp > 255){
                return false
            }
            
            if((tmp > 0 && item.first == "0") || (tmp == 0 && item.count > 1)){
                return false
            }
        }
        
        return true
    }
}
