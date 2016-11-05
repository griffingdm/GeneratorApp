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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
