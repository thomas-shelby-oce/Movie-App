//
//  Movie.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import Foundation

struct MoviesList: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let title: String
    let imgSrc: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case imgSrc = "backdrop_path"
        case rating = "vote_average"
    }
}

