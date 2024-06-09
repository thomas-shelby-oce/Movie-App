//
//  NetworkService.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let BASE_URL = "https://api.themoviedb.org/3/"
    private let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500/"
    
    private func getRequestUrl(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 1
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NWRhNzg5OGY4ODFiNjk5Yzc2YWViZjZkYzkwNGE2MSIsInN1YiI6IjY2NjQwYzEwNTJmNWE3NjkxYjkxNzVhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jwXEeTRkU1vWiwb_D13UpjssP6rb6-fe8jCTgUsijRc"
        ]
        
        return request
    }
    
    func fetchTrendingMovies(for duration: Time, completion: @escaping ([Movie]?) -> ()) {
        let endPoint =  BASE_URL + "trending/movie/" + duration.rawValue
        guard let url = URL(string: endPoint) else {
            completion(nil)
            return
        }
        let request = getRequestUrl(for: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let decodedMovies: MoviesList = try JSONDecoder().decode(MoviesList.self, from: data!)
                completion(decodedMovies.movies)
            } catch {
                
            }
        }.resume()
    }
    
    func fetchMoviesForCategory(for category: MovieCategory, completion: @escaping ([Movie]?) -> ()) {
        var endPoint = BASE_URL + "movie/"
        
        switch category {
            case .now_playing:
                endPoint = endPoint + "now_playing"
            case .popular:
                endPoint = endPoint + "popular"
            case .top_rated:
                endPoint = endPoint + "top_rated"
            case .trending:
                print("function should not get called for trending category")
        }
        
        guard let url = URL(string: endPoint) else {
            completion(nil)
            return
        }
        var request = getRequestUrl(for: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let decodedMovies: MoviesList = try JSONDecoder().decode(MoviesList.self, from: data!)
                completion(decodedMovies.movies)
            } catch {
                
            }
        }.resume()
    }
    
    func loadImage(from path: String, into imageView: UIImageView) {
        let endPoint = IMAGE_BASE_URL + path
        guard let url = URL(string: endPoint) else {
            print("Unable to create url for image path: \(path)")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(String(describing: error))")
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        task.resume()
    }
}
