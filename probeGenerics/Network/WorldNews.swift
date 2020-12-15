//
//  Wheather.swift
//  probeGenerics
//
//  Created by User on 15.12.2020.
//

import Foundation
class WorldNews : NetworkManager {
    
    override func dataRecive<T>(model: T.Type, url: String, completionHandler: @escaping (T) -> ()) where T : Decodable {
        super.dataRecive(model: model, url: url, completionHandler: completionHandler)
    }
    override func taskCreate<T>(model: T.Type, session: URLSession, request: NSMutableURLRequest, completionHandler: @escaping (T) -> ()) -> URLSessionDataTask where T : Decodable {
        super.taskCreate(model: model, session: session, request: request, completionHandler: completionHandler)
    }
    
}
