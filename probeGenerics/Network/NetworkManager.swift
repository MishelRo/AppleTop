//
//  NetworkManager.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//

import Foundation
protocol Network {
    func dataRecive<T : Decodable>(model: T.Type,url: String, completionHandler: @escaping (T) -> ())
    func taskCreate<T: Decodable>(model: T.Type ,session: URLSession,request: NSMutableURLRequest,
                                  completionHandler: @escaping(T)-> ()) -> URLSessionDataTask
}

class NetworkManager : Network {
    
    func dataRecive<T : Decodable>(model: T.Type,url: String, completionHandler: @escaping (T) -> ()) {
        let postData = NSData(data: "".data(using: String.Encoding.utf8)!)
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        let session = URLSession.shared
        let dataTask = taskCreate(model: model.self, session: session, request: request) { (request) in
            completionHandler(request)
        }
        dataTask.resume()
    }
    
    func taskCreate<T: Decodable>(model: T.Type ,session: URLSession,request: NSMutableURLRequest,completionHandler: @escaping(T)-> ()) -> URLSessionDataTask {
        let dataTask =
            session.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print("error \(String(describing: error?.localizedDescription))")
                } else {
                    ModelInfoParse().parseInfo(model: model.self, data: data!) { (responce) in
                        completionHandler(responce)
                    }
                }
            })
        return dataTask
    }
}
