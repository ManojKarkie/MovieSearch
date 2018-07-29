//
//  MovieTableViewCell.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    // MARK:- IBOutlets

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!

    // MARK:- Constants

    private struct Constants {
        static let posterImageCornerRadius: CGFloat = 3.0
        static let transitionAnimationDuration = 0.5
    }

    // MARK:- Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = Constants.posterImageCornerRadius
    }

    // MARK:- Setup with cell view model

    func setup(cellVm: MovieCellViewModel) {

        posterImageView.sd_setImage(with: cellVm.posterUrl, placeholderImage: #imageLiteral(resourceName: "movie_placeholder"), options: .refreshCached) { (image, _, _, _) in

            // Animate change of posterImageView's image with cross dissolve transition

            UIView.transition(with: self.posterImageView,
                              duration: Constants.transitionAnimationDuration,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.posterImageView.image = image ?? #imageLiteral(resourceName: "movie_placeholder")
            },
                              completion: nil)
        }

        nameLabel.text = cellVm.movieName
        releaseDateLabel.text = cellVm.releaseDate
        previewLabel.text = cellVm.preview
    }

}
