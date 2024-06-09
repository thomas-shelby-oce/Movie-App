//
//  CategoryCollectionViewController.swift
//  Movie App
//
//  Created by Anish Gupta on 09/06/24.
//

import UIKit

class CategoryCollectionViewController: UIViewController {
    
    var movies: [Movie]?

    @IBOutlet var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}

extension CategoryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCollectionViewCell {
            movieCell.configureCell(for: movies?[indexPath.row])
            cell = movieCell
        }
        return cell
    }
    
    
}
