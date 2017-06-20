//
//  Network.swift
//  Network
//
//  Created by Akash on 20/06/17.
//  Copyright © 2017 Akash. All rights reserved.
//

import Foundation

typealias JSONResponse = [String : Any]
typealias APIParameters = [String : Any]

class Network: NSObject {
    
    static let Net = Network()
    
    static var Session: URLSession = {
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 50
        urlconfig.timeoutIntervalForResource = 50
        return URLSession(configuration: urlconfig, delegate: nil, delegateQueue: nil)
    }()
    
    class func GETRequest(using strUrl: URL , onCompletion: @escaping (_ JSON:JSONResponse) -> Void) {
        
        let request = NSMutableURLRequest(url: strUrl)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //        let paramString = "data=Hello"
        //        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = Session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                print("======= Result =======",resultJson!)
                onCompletion(resultJson!)
            } catch {
                print("SOmething went wrong Error ---------> \(error)")
            }
        }
        task.resume()
    }
    
    
    class func POSTRequest(using strURL: URL, param: APIParameters ,completionHandler: @escaping (_ JSON:JSONResponse) -> Void) {
        do {
            let requestObject = try JSONSerialization.data(withJSONObject: param)
            
            var request = URLRequest(url: strURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 50)
            
            request.httpBody = requestObject
            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = Session.dataTask(with: request) {data, response, error in
                guard let data = data, error == nil else {
                    print(error!)
                    return
                }
                do {
                    let resultJsons = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    print("======Result =====",resultJsons!)
                    completionHandler(resultJsons!)
                } catch {
                    print("Error ---------> \(error)")
                }
                
            }
            
            task.resume()
        } catch {
            
            print("parameter configuration Error")
        }
    }
    
}
