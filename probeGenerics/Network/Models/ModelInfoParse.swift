//
//  JsonResponceModel.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//


protocol Parse {
    func parseInfo<T: Decodable>(model: T.Type ,data: Data, completionHandler: @escaping (T)->())
}

import Foundation
class ModelInfoParse: Parse {
    func parseInfo<T: Decodable>(model: T.Type ,data: Data, completionHandler: @escaping (T)->()) {
        let decoder = JSONDecoder()
        do {
            let songs = try  decoder.decode(model.self, from: data)
           completionHandler(songs)
        } catch {
            print (error.localizedDescription)
        }
    }
}
