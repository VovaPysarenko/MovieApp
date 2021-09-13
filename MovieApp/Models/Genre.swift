//
//  Genre.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 13.09.2021.
//

import Foundation

struct ResponseGenre: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    
    let id: Int
    let name: String
}
