//
//  NetworkManager.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//

import Foundation
protocol Network {
    func dataRecive(url: String)
    func taskCreate(session: URLSession, request: NSMutableURLRequest) -> URLSessionDataTask
}

struct NetworkManager {
    
    func dataRecive(url: String, completionHandler: @escaping (ModelInfo) -> ()) {
        let postData = NSData(data: "".data(using: String.Encoding.utf8)!)
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        let session = URLSession.shared
        let dataTask = taskCreate(session: session, request: request) { (request) in
            completionHandler(request)
        }
        dataTask.resume()
    }
    
    
    func taskCreate(session: URLSession,
                    request : NSMutableURLRequest,
                    completionHandler : @escaping(ModelInfo)-> ()) -> URLSessionDataTask {
        let dataTask =
            session.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print("error \(String(describing: error?.localizedDescription))")
                } else {
                    ModelInfoParse().parseInfo(data: data!) { (responce) in
                        completionHandler(responce)
                    }
                }
            })
        
        return dataTask
    }
    
    
    
    
    
    
    
}
