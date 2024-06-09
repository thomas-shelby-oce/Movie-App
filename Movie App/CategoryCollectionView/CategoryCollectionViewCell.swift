//
//  CategoryCollectionViewCell.swift
//  Movie App
//
//  Created by Anish Gupta on 09/06/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieRatingAndLabel: UILabel!
    
    func configureCell(for movie: Movie?) {
        guard let movie = movie else {
            return
        }
        NetworkService.shared.loadImage(from: movie.imgSrc, into: movieImage)
        movieRatingAndLabel.text = movie.title + ": \(movie.rating)"
        
    }
}
