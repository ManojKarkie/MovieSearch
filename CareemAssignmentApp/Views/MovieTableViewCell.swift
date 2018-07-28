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

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!

    private struct Constants {
        static let posterImageCornerRadius: CGFloat = 3.0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = Constants.posterImageCornerRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setup(cellVm: MovieCellViewModel) {
//        posterImageView.sd_setImage(with: cellVm.posterUrl) { (image, _, _, _) in
//            self.posterImageView.image = image
//        }

        posterImageView.sd_setImage(with: cellVm.posterUrl, placeholderImage: #imageLiteral(resourceName: "movie_placeholder"), options: .refreshCached) { (image, _, _, _) in
            UIView.transition(with: self.posterImageView,
                              duration:0.5,
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
