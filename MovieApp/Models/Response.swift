//
//  Response.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 08.09.2021.
//

import Foundation
import UIKit

struct Response: Codable {
    var results: [Film]
}

struct Film: Codable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, posterPath = "poster_path"
        }
    
    func encode(to encode: Encoder) throws {
        var conteiner = encode.container(keyedBy: CodingKeys.self)
        try conteiner.encode(id, forKey: .id)
        try conteiner.encode(title, forKey: .title)
        try conteiner.encode(overview, forKey: .overview)
        try conteiner.encode(posterPath, forKey: .posterPath)
    }
    
}
