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
        case imgSrc = "poster_path"
        case rating = "vote_average"
    }
}

public enum Time: String {
    case day = "day"
    case week = "week"
}

public enum MovieCategory: CaseIterable {
    case trending
    case now_playing
    case popular
    case top_rated
}


