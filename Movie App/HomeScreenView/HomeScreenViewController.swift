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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.dataSource = self
        setupBinders()
        viewModel.fetchAllMovies()
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let categoryCell = categoryTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryViewTableViewCell {
            categoryCell.title.text = viewModel.categories[indexPath.row]
            categoryCell.configureMovieTiles(for: viewModel.nowPlayingMovies.value)
            cell = categoryCell
        }
        return cell
    }
    
    
}
