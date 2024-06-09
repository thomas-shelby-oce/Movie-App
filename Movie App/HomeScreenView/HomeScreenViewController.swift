//
//  HomeScreenViewController.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet var categoryTableView: UITableView!
    let viewModel: HomeScreenViewModel = HomeScreenViewModel()
    
    private func reloadMoviesData() {
        DispatchQueue.main.async { [weak self] in
            self?.categoryTableView.reloadData()
        }
    }
    
    private func setupBinders() {
        viewModel.nowPlayingMovies.bind() { [weak self] in
            self?.reloadMoviesData()
        }
        viewModel.trendingMovies.bind() { [weak self] in
            self?.reloadMoviesData()
        }
        viewModel.topRatedMovies.bind() { [weak self] in
            self?.reloadMoviesData()
        }
        viewModel.popularMovies.bind() { [weak self] in
            self?.reloadMoviesData()
        }
        
        viewModel.trendingMoviesRange.bind() { [weak self] in
            self?.reloadMoviesData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        setupBinders()
        viewModel.fetchAllMovies()
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    private func toggleTrendingMoviesRange() {
        let currentRange = self.viewModel.trendingMoviesRange.value
        if(currentRange == .day) {
            self.viewModel.trendingMoviesRange.value = .week
        } else {
            self.viewModel.trendingMoviesRange.value = .day
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let categoryCell = categoryTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryViewTableViewCell {
            categoryCell.title.text = viewModel.categories[indexPath.row]
            let movieList = viewModel.getMovieList(for: indexPath.row)
            categoryCell.configureMovieTiles(for: movieList)
            categoryCell.configureActionButton(for: indexPath.row, time: viewModel.trendingMoviesRange.value) { [weak self] in
                self?.toggleTrendingMoviesRange()
                if(indexPath.row != 0) {
                    let storyboard = UIStoryboard(name: "CategoryCollectionViewController", bundle: nil)
                    guard let categoryViewController = storyboard.instantiateViewController(withIdentifier: "CategoryCollectionViewController") as? CategoryCollectionViewController else {
                        return
                    }
                    
                    categoryViewController.movies = movieList
                    self?.navigationController?.pushViewController(categoryViewController, animated: true)
                }
                
            }
            cell = categoryCell
        }
        return cell
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
