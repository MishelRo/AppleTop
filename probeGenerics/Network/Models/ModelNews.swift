//
//  ModelNews.swift
//  probeGenerics
//
//  Created by User on 15.12.2020.
//

import Foundation

protocol InterfaceNews {
    var source: Source? {get set}
    var title: String? {get set}
    var url: String {get set}
    var urlToImage: String? {get set}
}

struct ModelNews : Decodable {
    let status: String
    let totalResults: Int 
    let articles: [Article]
}

struct Article : Decodable, InterfaceNews {
    var source: Source?
    var author: String?
    var title: String?
    var articleDescription: String?
    var url: String
    var urlToImage: String?
    var content: String?
}

struct Source : Decodable {
    let id: String?
    let name: String
}
