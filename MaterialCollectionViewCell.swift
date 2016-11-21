//
//  MaterialCollectionViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/4/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class MaterialCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var materialImage: UIImageView!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageLink: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage(){
        self.activityIndicator.startAnimating()
        materialImage.downloadedFrom(link: imageLink!, completion: {
            self.activityIndicator.stopAnimating()
        })
    }
}
