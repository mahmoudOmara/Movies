//
//  Webservice.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/2/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit
import SystemConfiguration

class Webservice: NSObject, URLSessionDelegate {
    static var shared = Webservice()
    
    var online = false
    
    func isInternetAvailable() -> Bool {
        // check internet
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func getUrlCahcePolicy(_ isCache: Bool) -> URLRequest.CachePolicy {
        // get cache policy
        online = isInternetAvailable()
        if isCache {
            if online {
                return .reloadIgnoringCacheData
            } else {
                return .returnCacheDataDontLoad
            }
        } else {
            return .reloadIgnoringCacheData
        }
    }
    
    func checkDic(_ result: Any?) -> [String : Any] {
        // validate the returned result
        
        let dic = result as? [String : Any]
        if dic == nil {
            return ["message" : "connection error, Please try again", "error" : "0"]
        } else{
            return dic!
        }
    }
    
    func isNotError(_ dic: [String : Any]) -> Bool {
        // check the returned result is error or not
        let error = checkNull(dic["status"])
        if error == "200" {
            return true
        }else{
            return false
        }
    }
        
    func checkNull(_ object: Any?) -> String {
        // check the returned result values to return it as string one by one
        if let string = object as? String {
            return string
        } else if let number = object as? NSNumber {
            return "\(number)"
        } else {
            return ""
        }
    }
        
    func callWebService (_ method: String, _ link: String, _ object: Any?, _ isCache: Bool, _ type: String, _ completionHandler: @escaping (_ isDone: Bool, _ object: [String : Any]) -> Void) {
        // create the request
        
        // validate url
        var urlString = link
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let eventsDataUrl = URL(string: urlString)
        
        // create the request
        var request = URLRequest(url: eventsDataUrl!, cachePolicy: getUrlCahcePolicy(isCache), timeoutInterval: 10)
        request.httpMethod = method
        request.addValue(type, forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // convert the object to data
        if object != nil {
            var jsonData: Data!
            if (object is String) {
                jsonData = (object as! String).data(using: .utf8)!
            } else if (object is Data){
                jsonData = object as? Data
            }else{
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: object!, options: [])
                } catch _ as NSError {
                } catch {
                }
            }
            request.httpBody = jsonData
        }
        
        // run the request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            // handle the response
            if (data == nil) {
                let dic = self.checkDic(nil)
                completionHandler(self.isNotError(dic), dic)
            } else {
                var jsonResults : Any!
                do {
                    jsonResults = try JSONSerialization.jsonObject(with: data!, options: [])
                } catch _ as NSError {
                    var resultString: String!
                    if (data != nil) {
                        resultString = String(data: data!, encoding: .utf8)
                    }
                    jsonResults = ["result" : resultString, "error" : false]
                } catch {
                }
                
                let dic = self.checkDic(jsonResults)                
                completionHandler(self.isNotError(dic), dic)
            }
        }
        task.resume()
    }
}
