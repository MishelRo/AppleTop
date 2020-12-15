//
//  JsonResponceModel.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//

import Foundation
class ModelInfoParse {
    
    func parseInfo (data : Data, completionHandler : @escaping (ModelInfo)->()) {
        let decoder = JSONDecoder()
        do {
            let songs = try  decoder.decode(ModelInfo.self, from: data)
           completionHandler(songs)
        } catch {
            print (error.localizedDescription)
        }
    }
}
