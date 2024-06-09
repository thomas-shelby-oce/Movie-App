//
//  NetworkService.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import Foundation
import UIKit

public enum Time: String {
    case day = "day"
    case week = "week"
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let BASE_URL = "https://api.themoviedb.org/3/"
    private let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500/"
    
    func fetchTrendingMovies(for duration: Time, completion: @escaping ([Movie]?) -> ()) {
        let endPoint =  BASE_URL + "trending/movie/" + duration.rawValue
        guard let url = URL(string: endPoint) else {
            completion(nil)
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
            // Ensure there is no error and data is not nil
            guard let data = data, error == nil else {
                print("Error downloading image: \(String(describing: error))")
                return
            }
            
            // Create UIImage from data
            let image = UIImage(data: data)
            
            // Update UI on the main thread
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        task.resume()
    }
}
