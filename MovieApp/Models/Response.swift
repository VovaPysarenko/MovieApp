//
//  Response.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 08.09.2021.
//

import Foundation

struct Response: Codable {
    var results: [Film]
}

struct Film: Codable {
//    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var genreIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title, overview, posterPath = "poster_path", genreIds  = "genre_ids"
        }
    
    func encode(to encode: Encoder) throws {
        var conteiner = encode.container(keyedBy: CodingKeys.self)
//        try conteiner.encode(id, forKey: .id)
        try conteiner.encode(title, forKey: .title)
        try conteiner.encode(overview, forKey: .overview)
        try conteiner.encode(posterPath, forKey: .posterPath)
        try conteiner.encode(genreIds, forKey: .genreIds)
    }
}

struct ResponseGenre: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    
    var id: Int
    var name: String
    
//    func encode(to encode: Encoder) throws {
//        var conteiner = encode.container(keyedBy: CodingKeys.self)
//        try conteiner.encode(id, forKey: .id)
//        try conteiner.encode(name, forKey: .name)
//    }
}



