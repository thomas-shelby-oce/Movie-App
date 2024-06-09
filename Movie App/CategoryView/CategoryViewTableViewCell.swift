//
//  CategoryViewTableViewCell.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import UIKit

class CategoryViewTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var firstMovie: UIImageView!
    
    @IBOutlet weak var secondMovie: UIImageView!
    
    @IBOutlet weak var thirdMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMovieTiles(for movies: [Movie]?) {
        guard let movies = movies else {
            return
        }
        NetworkService.shared.loadImage(from: movies[0].imgSrc, into: firstMovie)
        NetworkService.shared.loadImage(from: movies[1].imgSrc, into: secondMovie)
        NetworkService.shared.loadImage(from: movies[2].imgSrc, into: thirdMovie)
    }

}
