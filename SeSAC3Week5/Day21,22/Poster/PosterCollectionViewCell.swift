//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        posterImageView.image = nil
    }

}
