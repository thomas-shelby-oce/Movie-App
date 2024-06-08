//
//  NetworkService.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import Foundation

public enum Time: String {
    case day = "day"
    case week = "week"
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let BASE_URL = "https://api.themoviedb.org/3/"
    
    func fetchTrendingMovies(for duration: Time, completion: @escaping () -> Void) {
        let endPoint =  BASE_URL + "trending/movie/" + duration.rawValue
        guard let url = URL(string: endPoint) else {
            completion()
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 1
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NWRhNzg5OGY4ODFiNjk5Yzc2YWViZjZkYzkwNGE2MSIsInN1YiI6IjY2NjQwYzEwNTJmNWE3NjkxYjkxNzVhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jwXEeTRkU1vWiwb_D13UpjssP6rb6-fe8jCTgUsijRc"
        ]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let decodedMovies: MoviesList = try JSONDecoder().decode(MoviesList.self, from: data!)
                print(decodedMovies)
            } catch {
                
            }
        }.resume()
    }
}
