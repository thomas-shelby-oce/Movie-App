//
//  HomeScreenViewModel.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import Foundation

final class HomeScreenViewModel {
    var trendingMovies: ObservableObject<[Movie]?>
    var nowPlayingMovies, popularMovies, topRatedMovies: ObservableObject<[Movie]?>
    var trendingMoviesRange: Time = .day
    let categories: [String] = ["Trending", "Now Playing", "Popular", "Top Rated"]
    
    init() {
        self.trendingMovies = ObservableObject(nil)
        self.nowPlayingMovies = ObservableObject(nil)
        self.popularMovies = ObservableObject(nil)
        self.topRatedMovies = ObservableObject(nil)
    }
    
    func fetchAllMovies() {
        NetworkService.shared.fetchTrendingMovies(for: self.trendingMoviesRange, completion: { movies in
            guard let movies = movies else {
                return
            }
            var moviesList = movies
            if movies.count > 3 {
                moviesList = Array(movies[0..<3])
            }
            self.trendingMovies.value = moviesList
            self.nowPlayingMovies.value = moviesList
            self.popularMovies.value = moviesList
            self.topRatedMovies.value = moviesList
        })
    }
    
}
