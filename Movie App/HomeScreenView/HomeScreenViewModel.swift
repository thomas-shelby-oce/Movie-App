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
    var trendingMoviesRange: ObservableObject<Time> = ObservableObject(.day)
    let categories: [String] = ["Trending", "Now Playing", "Popular", "Top Rated"]
    let categoryList: [MovieCategory] = MovieCategory.allCases
    
    init() {
        self.trendingMovies = ObservableObject(nil)
        self.nowPlayingMovies = ObservableObject(nil)
        self.popularMovies = ObservableObject(nil)
        self.topRatedMovies = ObservableObject(nil)
    }
    
    private func addValuesInModel(in category: MovieCategory, movies: [Movie]?) {
        switch category {
        case .trending:
            self.trendingMovies.value = movies
        case .now_playing:
            self.nowPlayingMovies.value =  movies
        case .popular:
            self.popularMovies.value = movies
        case .top_rated:
            self.topRatedMovies.value = movies
        }
    }
    
    func fetchAllMovies() {
        for categoryName in categoryList {
            if(categoryName == .trending) {
                NetworkService.shared.fetchTrendingMovies(for: self.trendingMoviesRange.value, completion: { movies in
                    guard let movies = movies else {
                        return
                    }
                    var moviesList = movies
                    self.addValuesInModel(in: categoryName, movies: moviesList)
                })
            } else {
                NetworkService.shared.fetchMoviesForCategory(for: categoryName, completion: { movies in
                    guard let movies = movies else {
                        return
                    }
                    var moviesList = movies
                    self.addValuesInModel(in: categoryName, movies: moviesList)
                })
            }
        }
    }
    
    func getMovieList(for index: Int) -> [Movie]? {
        let category = categoryList[index]
        switch category {
        case .now_playing:
            return self.nowPlayingMovies.value
        case .trending:
            return self.trendingMovies.value
        case .popular:
            return self.popularMovies.value
        case .top_rated:
            return self.topRatedMovies.value
        }
    }
    
}
