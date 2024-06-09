//
//  CategoryViewTableViewCell.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import UIKit

class CategoryViewTableViewCell: UITableViewCell {
    
    var triggerAction: (() -> Void)?

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var firstMovie: UIImageView!
    
    @IBOutlet weak var secondMovie: UIImageView!
    
    @IBOutlet weak var thirdMovie: UIImageView!
    
    @IBOutlet weak var firstMovieLabel: UILabel!
    
    @IBOutlet weak var secondMovieLabel: UILabel!
    
    @IBOutlet weak var thirdMovieLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        triggerAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureMovieTiles(for movies: [Movie]?) {
        guard let movies = movies else {
            return
        }
        NetworkService.shared.loadImage(from: movies[0].imgSrc, into: firstMovie)
        NetworkService.shared.loadImage(from: movies[1].imgSrc, into: secondMovie)
        NetworkService.shared.loadImage(from: movies[2].imgSrc, into: thirdMovie)
        firstMovieLabel.text = movies[0].title + ": \(movies[0].rating)" + "*"
        secondMovieLabel.text = movies[1].title + ": \(movies[1].rating)" + "*"
        thirdMovieLabel.text = movies[2].title + ": \(movies[2].rating)" + "*"
    }
    
    func configureActionButton(for index: Int, time: Time, triggerAction: @escaping () -> Void) {
        if (index == 0) {
            let title = time == .day ? "Get by week" : "Get for today"
            actionButton.setTitle(title, for: .normal)
        } else {
            actionButton.setTitle("Get all movies", for: .normal)
        }
        self.triggerAction = triggerAction
    }

}
